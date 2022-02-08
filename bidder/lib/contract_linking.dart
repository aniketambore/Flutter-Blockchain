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
      "3571cbb8b18bc0aa01d11f8ea87ddfad88dce216762324c12cc68de7ba4a4cb0";

  late Web3Client _client;
  late String _abiCode;

  late EthereumAddress _contractAddress;
  late Credentials _credentials;

  late DeployedContract _contract;
  late ContractFunction _bidderName;
  late ContractFunction _bidAmount;
  late ContractFunction _minBidAmount;
  late ContractFunction _setBidder;
  late ContractFunction _displayEligibility;

  bool isLoading = true;
  String? bidderName;
  BigInt? bidAmount;
  BigInt? minAmount;
  bool? displayEligibility;

  ContractLinking() {
    initialSetUp();
  }

  initialSetUp() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile =
        await rootBundle.loadString("src/artifacts/Bidder.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    // print(_abiCode);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  void getCredentials() {
    _credentials = EthPrivateKey.fromHex(_privateKey);
    // print(_credentials);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Bidder"), _contractAddress);

    _bidderName = _contract.function("bidderName");
    _bidAmount = _contract.function("bidAmount");
    _minBidAmount = _contract.function("minBidAmount");
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
        .call(contract: _contract, function: _minBidAmount, params: []);
    List eligibility = await _client
        .call(contract: _contract, function: _displayEligibility, params: []);

    bidderName = name[0];
    bidAmount = amount[0];
    minAmount = min[0];
    displayEligibility = eligibility[0];

    // print("${minAmount}");
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
