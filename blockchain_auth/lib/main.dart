import 'dart:convert';

import 'package:blockchain_auth/contract_link/contract_linking.dart';
import 'package:blockchain_auth/screens/login_page.dart';
import 'package:blockchain_auth/utils/colors.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContractLinking(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme:
            ThemeData(primarySwatch: Colors.blue, primaryColor: persian_blue),
        home: LoginForm(),
      ),
    );
  }
}

//class MyHomePage extends StatelessWidget {
//  var bytes = utf8.encode("Aniket");
//
//  @override
//  Widget build(BuildContext context) {
//    var digest = sha256.convert(bytes);
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Cryptography"),
//      ),
//      body: Container(
//        child: SingleChildScrollView(
//          child: Center(
//            child: Column(
//              children: [
//                Text("${digest.bytes}"),
//                SizedBox(
//                  height: 10,
//                ),
//                SelectableText("${digest}"),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
