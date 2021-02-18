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
      "4ebb55b39b32e9f6346b3b6daa15c879effca9b2e7ff69bca074f31392e782bf";

  Web3Client _client;
  String _abiCode;

  Credentials _credentials;
  EthereumAddress _contractAddress;
  EthereumAddress _ownAddress;

  DeployedContract _contract;
  ContractFunction _adopterGetter;
  ContractFunction _adoptFunc;
  ContractFunction _getAdoptersFunc;

  List allAdopters = [];

  bool isLoading = true;

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

  getAbi() async {
    final abiStringFile =
        await rootBundle.loadString("src/abis/CatAdoption.json");
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
        ContractAbi.fromJson(_abiCode, "CatAdoption"), _contractAddress);
    _adopterGetter = _contract.function("adopters");
    _adoptFunc = _contract.function("adopt");
    _getAdoptersFunc = _contract.function("getAdopters");
    getAdoptersFunc();
  }

  getAdoptersFunc() async {
    var adopterS = await _client
        .call(contract: _contract, function: _getAdoptersFunc, params: []);
    isLoading = false;
    allAdopters = adopterS.first;
    print(allAdopters[0]);
    notifyListeners();
  }

  Future<String> getAdopter(int id) async {
    var adopterIs = await _client.call(
        contract: _contract,
        function: _adopterGetter,
        params: [BigInt.from(id)]);
    notifyListeners();
    return "${adopterIs.first}";
  }

  adoptFunc(int id, String adopterAddr) async {
    isLoading = false;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _adoptFunc,
            parameters: [
              BigInt.from(id),
              EthereumAddress.fromHex(adopterAddr)
            ]));
    getAdoptersFunc();
  }
}
