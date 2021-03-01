import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://10.0.2.2:7545";
  final String _wsUrl = "ws://10.0.2.2:7545/";
  final String _privateKey =
      "7ebf66311ac8185812d28a222e376e6d11fa678b09b882480110f40e1a2aff45";
  Web3Client _client;

  String _abiCode;

  EthereumAddress _contractAddress;
  Credentials _credentials;

  DeployedContract _contract;
  ContractFunction _minterAddr;
  ContractFunction _balanceGet;
  ContractFunction _mintFunc;
  ContractFunction _sendFunc;
  ContractEvent _sentEvent;
  bool isLoading = true;

  String minterAddress;

  ContractLinking() {
    initialSetup();
  }

  Future<void> initialSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString("src/abis/Minter.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Minter"), _contractAddress);
    _minterAddr = _contract.function("minter");
    _balanceGet = _contract.function("balance");
    _mintFunc = _contract.function("mint");
    _sendFunc = _contract.function("send");
    _sentEvent = _contract.event("Sent");
    getMinterAddr();
  }

  getMinterAddr() async {
    final _minterAddress = await _client
        .call(contract: _contract, function: _minterAddr, params: []);
    minterAddress = "${_minterAddress.first}";
    print(minterAddress);
    isLoading = false;
    notifyListeners();
  }

  getBalance(String addr) async {
    final _balance = await _client.call(
        contract: _contract,
        function: _balanceGet,
        params: [EthereumAddress.fromHex(addr)]);
    //print("$_balance");
    isLoading = false;
    notifyListeners();
    return "${_balance.first}";
  }

  mintCoins(String receiver, int amount) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _mintFunc,
            parameters: [
              EthereumAddress.fromHex(receiver),
              BigInt.from(amount)
            ]));
    print("Coins $amount minted to $receiver");
    getMinterAddr();
  }

  sendCoins(String sender, String receiver, int amount) async {
    isLoading = true;
    notifyListeners();

    // listen for the Sent event when it's emitted by the contract above
    final subscription = _client
        .events(FilterOptions.events(contract: _contract, event: _sentEvent))
        .take(1)
        .listen((event) {
      final decoded = _sentEvent.decodeResults(event.topics, event.data);

      final from = decoded[0] as EthereumAddress;
      final to = decoded[1] as EthereumAddress;
      final value = decoded[2] as BigInt;

      print('$from sent $value Coins to $to');
    });

    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _sendFunc,
            parameters: [
              EthereumAddress.fromHex(sender),
              EthereumAddress.fromHex(receiver),
              BigInt.from(amount),
            ]));

    print("Coins Transferred Successfully");
    getMinterAddr();

    await subscription.asFuture();
    await subscription.cancel();
  }
}
