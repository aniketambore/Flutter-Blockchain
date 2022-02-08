import 'package:bidder/contract_linking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BidderUI extends StatelessWidget {
  const BidderUI({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bidder"),
        centerTitle: true,
      ),
      body: Center(
        child: contractLink.isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Theme.of(context).accentColor,
                          width: 10,
                        ),
                      ),
                      child: Image.network(
                          'https://www.businessinsider.in/thumb/msid-64194010,width-640,resizemode-4,imgsize-842610/3-Paul-Czannes-The-Card-Players-250-million.jpg'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Paul Cézanne's " "The Card Players",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.tealAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Price - \$${contractLink.minAmount}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              contractLink.displayEligibility!
                                  ? showInSnackBar(
                                      "This portrait is already sold !",
                                      context)
                                  : dialog(context);
                            },
                            child: const Text("Buy it!"))
                      ],
                    ),
                    contractLink.displayEligibility!
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Sold To ${contractLink.bidderName} at \$${contractLink.bidAmount}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 18),
                            ),
                          )
                        : const Text("")
                  ],
                ),
              ),
      ),
    );
  }

  dialog(context) {
    var contractLink = Provider.of<ContractLinking>(context, listen: false);
    TextEditingController nameController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Buy It !",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                      fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Name",
                        hintText: "Enter your name..."),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Bid Amount",
                        hintText: "Enter your Bid Amount...",
                        prefixIcon: Icon(Icons.monetization_on_outlined)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    ElevatedButton(
                        onPressed: () {
                          contractLink.setBidder(nameController.text,
                              int.parse(amountController.text));

                          contractLink.minAmount! >
                                  BigInt.from(int.parse(amountController.text))
                              ? showInSnackBar("Amount is less !", context)
                              : null;

                          Navigator.pop(context);
                        },
                        child: const Text("Buy")),
                  ],
                )
              ],
            ),
          );
        });
  }

  showInSnackBar(String value, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        value,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ));
  }
}
