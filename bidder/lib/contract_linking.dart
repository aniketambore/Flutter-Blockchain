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
      "6c03184a66a3602743ec66c4bb83561ea3b2a4b588d720d6203a69112ee41f35";

  Web3Client _client;
  String _abiCode;

  EthereumAddress _contractAddress;
  EthereumAddress _ownAddress;
  Credentials _credentials;

  DeployedContract _contract;
  ContractFunction _bidderName;
  ContractFunction _bidAmount;
  ContractFunction _minAmount;
  ContractFunction _setBidder;
  ContractFunction _displayEligibility;

  bool isLoading = true;
  String bidderName;
  BigInt bidAmount;
  BigInt minAmount;
  bool displayEligibility;

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

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString("src/abis/Bidder.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
    _ownAddress = await _credentials.extractAddress();
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Bidder"), _contractAddress);
    _bidderName = _contract.function("bidderName");
    _bidAmount = _contract.function("bidAmount");
    _minAmount = _contract.function("minBid");
    _setBidder = _contract.function("setBidder");
    _displayEligibility = _contract.function("displayEligibility");
    getBidderData();
  }

  getBidderData() async {
    List name = await _client
        .call(contract: _contract, function: _bidderName, params: []);
    List amount = await _client
        .call(contract: _contract, function: _bidAmount, params: []);
    List min = await _client
        .call(contract: _contract, function: _minAmount, params: []);
    List eligibility = await _client
        .call(contract: _contract, function: _displayEligibility, params: []);

    bidderName = name[0];
    bidAmount = amount[0];
    minAmount = min[0];
    displayEligibility = eligibility[0];

    print("${minAmount}");
    isLoading = false;
    notifyListeners();
  }

  setBidder(String nm, int amount) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _setBidder,
            parameters: [nm, BigInt.from(amount)]));
    getBidderData();
  }
}
