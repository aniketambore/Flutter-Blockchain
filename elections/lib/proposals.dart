import 'package:flutter/material.dart';

class Proposals extends StatelessWidget {
  List assetsImages = [
    "assets/images/ballerina-portrait-idle.png",
    "assets/images/orangetabby-portrait-idle.png",
    "assets/images/rascal-portrait-idle.png",
    "assets/images/siamese-portrait-idle.png",
    "assets/images/smudge-portrait-idle.png",
  ];

  List catsNames = [
    "Ballerina",
    "Orangetabby",
    "Rascal",
    "Siamese",
    "Smudge",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Election On Blockchain"),
      ),
      body: Container(
        child: ListView.builder(
          // itemCount: contractLink.allAdopters.length,
          itemCount: 4,
          itemBuilder: (context, int index) {
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120.0,
                  margin: EdgeInsets.only(left: 30),
                  child: Card(
                    color: Colors.blueGrey,
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 74.0),
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
//                            Text(
//                              "${contractLink.allAdopters[index].toString()}" ==
//                                  "0x0000000000000000000000000000000000000000"
//                                  ? "Not Adopted"
//                                  : "${contractLink.allAdopters[index].toString().substring(0, 5)}XXXXX",
//                              style: TextStyle(
//                                  fontSize: 20,
//                                  color: Colors.orange,
//                                  textBaseline: TextBaseline.ideographic),
//                            )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20.0,
                  left: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.lightGreenAccent,
                        width: 5,
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(.3),
                            offset: Offset(0, 2),
                            blurRadius: 5)
                      ],
                    ),
                    constraints: BoxConstraints(maxHeight: 100, maxWidth: 100),
                    child: CircleAvatar(
                      maxRadius: 40,
                      backgroundColor: Colors.blueGrey,
                      backgroundImage: AssetImage("${assetsImages[index]}"),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
