import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:population/populationUI.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Population On Blockchain',
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.cyan[400],
          accentColor: Colors.deepOrange[200]),
      home: PopulationUI(),
    );
  }
}
