import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

typedef TransferEvent = void Function(
    EthereumAddress from, EthereumAddress to, BigInt value);

abstract class IContractService {
  Future<Credentials> getCredentials(String privateKey);
  Future<String> send(
      String privateKey, EthereumAddress receiver, BigInt amount,
      {TransferEvent onTransfer, Function onError});
  Future<BigInt> getTokenBalance(EthereumAddress from);
  Future<EtherAmount> getEthBalance(EthereumAddress from);
  Future<void> dispose();
  StreamSubscription listenTransfer(TransferEvent onTransfer);
}

class ContractService implements IContractService {
//  final Web3Client client;
//  ContractService(this.client);

  final String _rpcUrl = "http://10.0.2.2:7545";
  final String _wsUrl = "ws://10.0.2.2:7545/";
  Web3Client _client;
  DeployedContract contract;
  EthereumAddress _contractAddress;

  ContractService() {
    initialSetup();
  }

  initialSetup() async {
    _client = await Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
  }

  getAbi() async {
    String artifactFile =
        await rootBundle.loadString("src/artifacts/PersonalCoin.json");
    var jsonFile = jsonDecode(artifactFile);
    String _abiCode = jsonEncode(jsonFile["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonFile["networks"]["5777"]["address"]);
    contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "PersonalCoin"), _contractAddress);
  }

  ContractEvent _transferEvent() => contract.event('Transfer');
  ContractFunction _balanceFunction() => contract.function('balanceOf');
  ContractFunction _sendFunction() => contract.function('transfer');

  Future<Credentials> getCredentials(String privateKey) =>
      _client.credentialsFromPrivateKey(privateKey);

  Future<String> send(
      String privateKey, EthereumAddress receiver, BigInt amount,
      {TransferEvent onTransfer, Function onError}) async {
    final credentials = await this.getCredentials(privateKey);
    final from = await credentials.extractAddress();
    final networkId = await _client.getNetworkId();

    StreamSubscription event;
    // Workaround once sendTransacton doesn't return a Promise containing confirmation / receipt
    if (onTransfer != null) {
      event = listenTransfer((from, to, value) async {
        onTransfer(from, to, value);
        await event.cancel();
      }, take: 1);
    }

    try {
      final transactionId = await _client.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: contract,
          function: _sendFunction(),
          parameters: [receiver, amount],
          from: from,
        ),
        chainId: networkId,
      );
      print('transact started $transactionId');
      return transactionId;
    } catch (ex) {
      if (onError != null) {
        onError(ex);
      }
      return null;
    }
  }

  Future<EtherAmount> getEthBalance(EthereumAddress from) async {
    return await _client.getBalance(from);
  }

  Future<BigInt> getTokenBalance(EthereumAddress from) async {
    var response = await _client.call(
      contract: contract,
      function: _balanceFunction(),
      params: [from],
    );

    return response.first as BigInt;
  }

  StreamSubscription listenTransfer(TransferEvent onTransfer, {int take}) {
    var events = _client.events(FilterOptions.events(
      contract: contract,
      event: _transferEvent(),
    ));

    if (take != null) {
      events = events.take(take);
    }

    return events.listen((event) {
      final decoded = _transferEvent().decodeResults(event.topics, event.data);

      final from = decoded[0] as EthereumAddress;
      final to = decoded[1] as EthereumAddress;
      final value = decoded[2] as BigInt;

      print('$from');
      print('$to');
      print('$value');

      onTransfer(from, to, value);
    });
  }

  Future<void> dispose() async {
    await _client.dispose();
  }
}
