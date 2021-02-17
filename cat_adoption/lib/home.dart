import 'package:cat_adoption/contract_linking.dart';
import 'package:cat_adoption/statusList.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tcard/tcard.dart';

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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TCardController _controller = TCardController();

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cat Adoption"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.pets),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StatusList()));
              })
        ],
      ),
      body: Container(
        child: Center(
          child: contractLink.isLoading
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 490,
                        child: TCard(
                          //cards: cards,
                          cards: List.generate(assetsImages.length,
                              (index) => catCard(index, context)),
                          controller: _controller,
                          onForward: (index, info) {
                            _index = index;
                            //print(info.direction);
                            setState(() {});
                          },
                          onBack: (index) {
                            _index = index;
                            setState(() {});
                          },
                          onEnd: () {
                            print('end');
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                              iconSize: 40,
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                _controller.back();
                              }),
                          IconButton(
                              iconSize: 40,
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                _controller.forward();
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            _index == catsNames.length ? Colors.green : Colors.cyan,
        onPressed: () {
          _controller.reset();
        },
        //child: Text(_index.toString()),
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget catCard(int index, context) {
    var contractLink = Provider.of<ContractLinking>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepOrange[200],
        borderRadius: BorderRadius.circular(26.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 17),
            blurRadius: 23.0,
            spreadRadius: -13.0,
            color: Colors.black54,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Name - ${catsNames[index]}",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Image(image: AssetImage(assetsImages[index])),
          ElevatedButton(
              onPressed: () async {
                var adopter = "${await contractLink.getAdopter(index)}";
                adopter == "0x0000000000000000000000000000000000000000"
                    ? adoptCatDialog(context, index, "${catsNames[index]}")
                    : showToast("It is already adopted.", context);
              },
              child: Text("Adopt"))
        ],
      ),
    );
  }

  adoptCatDialog(context, int index, String catName) {
    var contractLink = Provider.of<ContractLinking>(context, listen: false);
    TextEditingController accountAddr = TextEditingController();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Adopt $catName",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 18.0, bottom: 8.0),
                  child: TextField(
                    controller: accountAddr,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Account Address",
                        hintText: "Enter Account Address..."),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel")),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            contractLink.adoptFunc(index, accountAddr.text);
                            Navigator.pop(context);
                          },
                          child: Text("Adopt")),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  showToast(String message, BuildContext context) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.teal,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      textColor: Colors.white,
      fontSize: 20,
    );
  }
}
