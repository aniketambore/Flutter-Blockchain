import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://10.0.2.2:7545";
  final String _wsUrl = "ws://10.0.2.2:7545/";
  final String _privateKey =
      "bba93ee5c8b75f150ff78c6a9e690bcef9157d3f5f809c384bd740caca93a562";

  Web3Client _client;
  String _abiCode;

  EthereumAddress _contractAddress;
  Credentials _credentials;

  DeployedContract _contract;
  ContractFunction _createAccount;
  ContractFunction _loginAccount;

  bool isLoading = false;

  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    _client = await Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  getAbi() async {
    String artifactString =
        await rootBundle.loadString("src/artifacts/Auth.json");
    var jsonFile = jsonDecode(artifactString);
    _abiCode = jsonEncode(jsonFile["abi"]);
    //print(_abiCode);
    _contractAddress =
        EthereumAddress.fromHex(jsonFile["networks"]["5777"]["address"]);
  }

  getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
  }

  getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Auth"), _contractAddress);

    _createAccount = _contract.function("createAccount");
    _loginAccount = _contract.function("loginAccount");
  }

  createAccount(String name, String pass, String mail) async {
    isLoading = true;
    notifyListeners();

    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _createAccount,
            parameters: [name, pass, mail],
            maxGas: 1000000));
    print("Account Created Bro");

    isLoading = false;
    notifyListeners();
  }

  loginAccount(String mail, String pass) async {
    var msg = await _client.call(
        contract: _contract, function: _loginAccount, params: [mail, pass]);
    print(msg[0]);
    isLoading = false;
    notifyListeners();
  }
}
