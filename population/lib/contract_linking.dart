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
      "b944115ce684af2ee457637c9a8cc2e4c5cd9f50f13792eddf6615bfd1b9fb21";

  Web3Client _client;
  String _abiCode;

  EthereumAddress _contractAddress;
  Credentials _credentials;

  DeployedContract _contract;
  ContractFunction _countryName;
  ContractFunction _currentPopulation;
  ContractFunction _set;
  ContractFunction _decrement;
  ContractFunction _increment;

  bool isLoading = true;
  String countryName;
  String currentPopulation;

  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    final abiStringFile =
        await rootBundle.loadString("src/artifacts/Population.json");
    final jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Population"), _contractAddress);
    _countryName = _contract.function("countryName");
    _currentPopulation = _contract.function("currentPopulation");
    _set = _contract.function("set");
    _decrement = _contract.function("decrement");
    _increment = _contract.function("increment");

    getData();
  }

  getData() async {
    List name = await _client
        .call(contract: _contract, function: _countryName, params: []);
    List population = await _client
        .call(contract: _contract, function: _currentPopulation, params: []);
    countryName = name[0];
    currentPopulation = population[0].toString();
    print("$countryName , $currentPopulation");
    isLoading = false;
    notifyListeners();
  }

  addData(String nameData, BigInt countData) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _set,
            parameters: [nameData, countData]));
    getData();
  }

  increasePopulation(int incrementBy) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _increment,
            parameters: [BigInt.from(incrementBy)]));
    getData();
  }

  decreasePopulation(int decrementBy) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _decrement,
            parameters: [BigInt.from(decrementBy)]));
    getData();
  }
}
