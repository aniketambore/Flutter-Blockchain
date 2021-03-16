import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/create_task.dart';
import 'package:todo_app/utils/colors.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: white,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Image.network(
                          "https://d2b49nkvtopt1u.cloudfront.net/assets/blockchain/blockchain-0f0293b27cfc716b02e0731e482adfe2.gif",
                          height: 340,
                          width: 310),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, top: 12.0, bottom: 4.0),
                    child: Text(
                      "Todos",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 21,
                          color: santas_gray,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24.0, right: 24.0, top: 4.0, bottom: 12.0),
                    child: Text(
                      "Todos On Blockchain",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 44,
                          color: wood_smoke,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24.0, top: 8, right: 24),
                    child: ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        padding: EdgeInsets.all(16),
                        color: wood_smoke,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateTask()));
                        },
                        textColor: white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Get Started",
                              style: TextStyle(
                                  fontSize: 21.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(16.0)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
