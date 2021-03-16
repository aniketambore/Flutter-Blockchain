import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/custom_widgets/button_plain_with_shadow.dart';
import 'package:todo_app/home.dart';
import 'package:todo_app/linking/contract_linking.dart';
import 'package:todo_app/screens/edit_task.dart';
import 'package:todo_app/utils/colors.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({this.task});

  @override
  Widget build(BuildContext context) {
    var contractLinking = Provider.of<ContractLinking>(context);
    return Container(
      margin: EdgeInsets.only(top: 24),
      padding: EdgeInsets.all(24),
      decoration: ShapeDecoration(
          //color: task.bgColor,
          color: Colors.cyan,
          shadows: [
            BoxShadow(
              color: wood_smoke,
              offset: Offset(
                0.0, // Move to right 10  horizontally
                6.0, // Move to bottom 5 Vertically
              ),
            )
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              side: BorderSide(color: wood_smoke, width: 2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.person_pin_outlined,
                size: 48,
                color: Colors.black,
              ),
              IconButton(
                  iconSize: 48,
                  color: Colors.red,
                  icon: Icon(Icons.delete_forever_outlined),
                  onPressed: () {
                    contractLinking.deleteTask(task.id);
                  }),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          task.taskDescription == ""
              ? Icon(
                  Icons.error,
                  size: 40,
                )
              : Text(
                  task.taskDescription,
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: wood_smoke),
                ),
          SizedBox(
            height: 48,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    task.taskTitle,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: wood_smoke),
                  ),
                  Text(
                    //task.time,
                    "${task.id}",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: wood_smoke),
                  )
                ],
              ),
              ButtonPlainWithShadow(
                borderColor: wood_smoke,
                color: lightening_yellow,
                text: "Edit",
                height: 48,
                size: 120,
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditTask(task: task)));
                },
                shadowColor: wood_smoke,
              ),
            ],
          )
        ],
      ),
    );
  }
}
