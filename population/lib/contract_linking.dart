import 'dart:convert';

import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://10.0.2.2:7545";
  final String _wsUrl = "ws://10.0.2.2:7545/";
  final String _privateKey =
      "97f008aa845cc5785a54e14a85bfb551cd1f4f64fe401ded6ddb3cc4a68c85b6";

  late Web3Client _client;
  late String _abiCode;

  late EthereumAddress _contractAddress;
  late Credentials _credentials;

  late DeployedContract _contract;
  late ContractFunction _countryName;
  late ContractFunction _currentPopulation;
  late ContractFunction _set;
  late ContractFunction _decrement;
  late ContractFunction _increment;

  bool isLoading = true;
  late String countryName;
  late String currentPopulation;

  ContractLinking() {
    initialSetUp();
  }

  initialSetUp() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    getCredentials();
    await getAbi();
    await getDeployedContract();
  }

  getCredentials() {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/artifacts/Population.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    // print(_abiCode);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    print(_contractAddress);
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

  setData(String name, BigInt count) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract, function: _set, parameters: [name, count]));
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
