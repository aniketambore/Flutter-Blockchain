// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  ContractLinking() {
    initialSetup();
  }

  final String _rpcUrl = 'http://127.0.0.1:7545';
  final String _wsUrl = 'ws://10.0.2.2:7545/';
  final String _privateKey =
      'f7c4e01b7af6c36ef6f50d21926f2e90c5f0305350e6a74b6bdc8d0c27693270';

  bool isLoading = true;
  late Web3Client _client;
  late String _abiCode;
  late EthereumAddress _contractAddress;
  late Credentials _credentials;
  late DeployedContract _contract;
  late ContractFunction _yourName;
  late ContractFunction _setName;
  late String deployedName;

  Future<void> initialSetup() async {
    // establish a connection to the ethereum rpc node. The socketConnector
    // property allows more efficient event streams over websocket instead of
    // http-polls. However, the socketConnector property is experimental.
    _client = Web3Client(
      _rpcUrl,
      http.Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
      },
    );

    await getAbi();
    getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    // Reading the contract abi
    final abiStringFile =
        await rootBundle.loadString('src/artifacts/HelloWorld.json');
    final jsonAbi = jsonDecode(abiStringFile) as Map<String, dynamic>;
    _abiCode = jsonEncode(jsonAbi['abi']);

    _contractAddress = EthereumAddress.fromHex(
      // ignore: avoid_dynamic_calls
      jsonAbi['networks']['5777']['address'] as String,
    );
  }

  void getCredentials() {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    // Telling Web3dart where our contract is declared.
    _contract = DeployedContract(
      ContractAbi.fromJson(_abiCode, 'HelloWorld'),
      _contractAddress,
    );

    // Extracting the functions, declared in contract.
    _yourName = _contract.function('yourName');
    _setName = _contract.function('setName');
    await getName();
  }

  Future<void> getName() async {
    // Getting the current name declared in the smart contract.
    final currentName = await _client.call(
      contract: _contract,
      function: _yourName,
      params: <dynamic>[],
    );
    deployedName = currentName[0] as String;
    isLoading = false;
    notifyListeners();
  }

  Future<void> setName(String nameToSet) async {
    // Setting the name to nameToSet(name defined by user)
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _setName,
        parameters: <dynamic>[nameToSet],
      ),
    );
    await getName();
  }
}
