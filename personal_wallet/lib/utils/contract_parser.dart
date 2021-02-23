import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';

class ContractParser {
  static Future fromAssets(String contractAddress) async {
//    final contractJson =
//    jsonDecode(await rootBundle.loadString('assets/PersonalCoin.json'));

    final artifactsStringFile = jsonDecode(
        await rootBundle.loadString("src/artifacts/PersonalCoin.json"));
    String _abiCode = jsonEncode(artifactsStringFile["abi"]);

    return DeployedContract(ContractAbi.fromJson(_abiCode, "PersonalCoin"),
        EthereumAddress.fromHex(contractAddress));
  }
}
