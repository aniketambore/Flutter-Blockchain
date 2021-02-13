import 'package:bidder/bidder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bidder/contract_linking.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContractLinking(),
      child: MaterialApp(
          title: 'Bidder',
          theme: ThemeData(
              primaryColor: Colors.cyan[400],
              accentColor: Colors.deepOrange[200],
              brightness: Brightness.dark),
          home: BidderUI()),
    );
  }
}
