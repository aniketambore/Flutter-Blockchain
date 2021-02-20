import 'package:elections/contract_linking.dart';
import 'package:elections/proposals.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ElectionUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Decentralized Election"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: contractLink.isLoading
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(.3),
                                offset: Offset(0, 2),
                                blurRadius: 5)
                          ],
                        ),
                        constraints:
                            BoxConstraints(maxHeight: 240, maxWidth: 240),
                        child: CircleAvatar(
                          maxRadius: 240,
                          backgroundColor: Colors.blueGrey,
                          backgroundImage: NetworkImage(
                              "https://appinventiv.com/wp-content/uploads/sites/1/2020/11/Role-of-blockchain-in-voting.gif"),
                        ),
                      ),
                      Text(
                        "Election On Blockchain",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 50,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                registerVoterDialog(context);
                              },
                              label: Text("Register Voter"),
                              icon: Icon(Icons.app_registration),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 50,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Proposals()));
                              },
                              label: Text("Vote"),
                              icon: Icon(Icons.how_to_vote),
                            )),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  registerVoterDialog(context) {
    var contractLink = Provider.of<ContractLinking>(context, listen: false);
    TextEditingController voterAddress = TextEditingController();
    TextEditingController chairpersonAddress = TextEditingController();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Register Voter",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "(ONLY CHAIRPERSON CAN REGISTER VOTERS!)",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.red),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 18.0, bottom: 8.0),
                  child: TextField(
                    controller: chairpersonAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Chairperson Address",
                        hintText: "Enter Chairperson Address..."),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: voterAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Voter Address",
                        hintText: "Enter Voter Address..."),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
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
                            contractLink.registerVoter(
                                voterAddress.text, chairpersonAddress.text);
                            showToast(
                                "Voter ${voterAddress.text.substring(0, 5)}XXXX Registered.",
                                context);
                            Navigator.pop(context);
                          },
                          child: Text("Register")),
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
