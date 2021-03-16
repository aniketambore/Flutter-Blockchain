import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/custom_widgets/button_plain_with_shadow.dart';
import 'package:todo_app/linking/contract_linking.dart';
import 'package:todo_app/utils/colors.dart';

class CreateTask extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var contractLinking = Provider.of<ContractLinking>(context);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 5,
                child: ListView(
                  padding: EdgeInsets.all(34),
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Create Todo",
                        style: TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                          hintText: "Title",
                          hintStyle: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                              color: wood_smoke),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          contentPadding: EdgeInsets.all(16),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          prefixIcon: Icon(Icons.title)),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextField(
                      controller: descpController,
                      decoration: InputDecoration(
                          hintText: "Description",
                          hintStyle: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                              color: wood_smoke),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          contentPadding: EdgeInsets.all(16),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          prefixIcon: Icon(Icons.description)),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ButtonPlainWithShadow(
                      text: "Save",
                      shadowColor: wood_smoke,
                      borderColor: wood_smoke,
                      callback: () {
                        contractLinking.createTasks(
                            titleController.text, descpController.text);
                        titleController.clear();
                        descpController.clear();
                        Navigator.pop(context);
                      },
                      color: lightening_yellow,
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              left: 24,
              top: 50,
              child: IconButton(
                iconSize: 48,
                color: Colors.black,
                icon: Icon(
                  Icons.cancel,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ))
        ],
      ),
    );
  }
}
