import 'package:flutter/material.dart';
import 'package:personal_wallet/app_config.dart';
import 'package:personal_wallet/service_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:personal_wallet/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final stores = await createProviders(AppConfig().params["dev"]);
  runApp(MyApp(stores));
}

class MyApp extends StatelessWidget {
  final List<SingleChildWidget> stores;

  MyApp(this.stores);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: stores,
      child: MaterialApp(
       initialRoute: "/",
        routes: getRoutes(context),
        theme: ThemeData(
            primaryColor: Colors.cyan[400],
            accentColor: Colors.deepOrange[200],
            brightness: Brightness.dark),
      ),
    );
  }
}

class Hello extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Hello")),
    );
  }
}
