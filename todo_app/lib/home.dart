import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/custom_widgets/custom_app_bar.dart';
import 'package:todo_app/custom_widgets/task_card.dart';
import 'package:todo_app/linking/contract_linking.dart';
import 'package:todo_app/screens/create_task.dart';
import 'package:todo_app/screens/splash_page.dart';
import 'package:todo_app/utils/colors.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var contractLinking = Provider.of<ContractLinking>(context);
    return contractLinking.taskCount == 0
        ? SplashPage()
        : Scaffold(
            appBar: CustomAppBar(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, left: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Todos",
                            style: TextStyle(
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                                color: black),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateTask()));
              },
            ),
            body: contractLinking.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: contractLinking.taskCount,
                    padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                    itemBuilder: (context, index) {
                      return TaskCard(task: contractLinking.todos[index]);
                    },
                  ),
          );
  }
}