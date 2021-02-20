import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://10.0.2.2:7545";
  final String _wsUrl = "ws://10.0.2.2:7545/";
  final String _privateKey =
      "1f8aa8f9d7f7ae745e4d58ab5daed17f2d0111e6244131a2f267502a675c9505";

  Web3Client _client;
  String _abiCode;

  Credentials _credentials;
  EthereumAddress _ownAddress;
  EthereumAddress _contractAddress;

  DeployedContract _contract;
  ContractFunction _chairperson;
  ContractFunction _registerFunc;
  ContractFunction _voteFunc;
  ContractFunction _declareWinnerFunc;

  bool isLoading = true;

  ContractLinking() {
    inititalSetup();
  }

  inititalSetup() async {
    _client = await Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/abis/Election.json");
    var jsonFile = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonFile["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonFile["networks"]["5777"]["address"]);
  }

  getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
    _ownAddress = await _credentials.extractAddress();
  }

  getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Election"), _contractAddress);
    _chairperson = _contract.function("chairperson");
    _registerFunc = _contract.function("Register");
    _voteFunc = _contract.function("Vote");
    _declareWinnerFunc = _contract.function("Winner");
    getChairperson();
  }

  getChairperson() async {
    var chairperson = await _client
        .call(contract: _contract, function: _chairperson, params: []);
    print("${chairperson.first}");
    isLoading = false;
    notifyListeners();
  }

  registerVoter(String voterAddress, String chairpersonAddress) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _registerFunc,
            parameters: [
              EthereumAddress.fromHex(voterAddress),
              EthereumAddress.fromHex(chairpersonAddress)
            ]));
    print("Voter Registered");
    getChairperson();
  }

  vote(int toProposal, String voterAddress) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _voteFunc,
            parameters: [toProposal, EthereumAddress.fromHex(voterAddress)]));
    getChairperson();
  }

  winner() async {
    var winnerIs = await _client
        .call(contract: _contract, function: _declareWinnerFunc, params: []);
    return "${winnerIs.first}";
  }
}
