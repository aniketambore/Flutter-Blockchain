import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home.dart';
import 'package:todo_app/linking/contract_linking.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContractLinking(),
      child: MaterialApp(
        title: 'Blockchain Todo',
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.cyan[400],
            accentColor: Colors.deepOrange[200]),
        home: MyHomePage(),
      ),
    );
  }
}
