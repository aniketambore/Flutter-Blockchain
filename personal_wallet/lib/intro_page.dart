import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Wallet"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  child: Text("Create new wallet"),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/create");
                  },
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: OutlinedButton(
                    child: Text("Import wallet"),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/import");
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
