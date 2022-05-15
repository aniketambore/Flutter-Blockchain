import 'package:flutter/material.dart';
import 'package:hello_world/contract_linking.dart';
import 'package:hello_world/hello.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Inserting Provider as a parent of HelloUI()
    return ChangeNotifierProvider<ContractLinking>(
      create: (_) => ContractLinking(),
      child: MaterialApp(
        title: 'Hello World',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.deepOrange[200],
            brightness: Brightness.dark,
            primary: Colors.cyan[400],
          ),
        ),
        home: const Hello(),
      ),
    );
  }
}
