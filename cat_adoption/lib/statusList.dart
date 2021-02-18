import 'package:cat_adoption/contract_linking.dart';
import 'package:cat_adoption/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Status"),
      ),
      body: contractLink.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: createListView(context),
            ),
    );
  }

  Widget createListView(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);
    return Container(
      child: ListView.builder(
        itemCount: contractLink.allAdopters.length,
        itemBuilder: (context, int index) {
          return Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 120.0,
                margin: EdgeInsets.only(left: 30),
                child: Card(
                  color: Colors.black54,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 54.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: Text(
                            "Name - ${catsNames[index]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                textBaseline: TextBaseline.ideographic),
                          ),
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Adopted By :- ",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.tealAccent),
                            ),
                            Text(
                              "${contractLink.allAdopters[index].toString()}" ==
                                      "0x0000000000000000000000000000000000000000"
                                  ? "Not Adopted"
                                  : "${contractLink.allAdopters[index].toString().substring(0, 5)}XXXXX",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.orange,
                                  textBaseline: TextBaseline.ideographic),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30.0,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.yellow,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          offset: Offset(0, 2),
                          blurRadius: 5)
                    ],
                  ),
                  constraints: BoxConstraints(maxHeight: 80, maxWidth: 80),
                  child: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.blueGrey,
                    backgroundImage: AssetImage("${assetsImages[index]}"),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
