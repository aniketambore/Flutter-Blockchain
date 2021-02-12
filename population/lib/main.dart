import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:population/display_population.dart';
import 'package:provider/provider.dart';
import 'package:population/contract_linking.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContractLinking>(
      create: (_) => ContractLinking(),
      child: MaterialApp(
        title: 'Population On Blockchain',
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.cyan[400],
            accentColor: Colors.deepOrange[200]),
        home: DisplayPopulation(),
      ),
    );
  }
}
