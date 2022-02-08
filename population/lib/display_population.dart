import 'package:flutter/material.dart';
import 'package:population/contract_linking.dart';
import 'package:population/set_population.dart';
import 'package:provider/provider.dart';
import 'package:country_pickers/country_pickers.dart';

class DisplayPopulation extends StatelessWidget {
  const DisplayPopulation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Population On Blockchain"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SetPopulation(),
                  fullscreenDialog: true));
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: contractLink.isLoading
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      contractLink.countryName == "Unknown"
                          ? const Icon(
                              Icons.error,
                              size: 100,
                            )
                          : SizedBox(
                              child: CountryPickerUtils.getDefaultFlagImage(
                                  CountryPickerUtils.getCountryByIsoCode(
                                      contractLink.countryName)),
                              width: 250,
                              height: 150,
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Country - ${contractLink.countryName}",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Population - ${contractLink.currentPopulation}",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                      contractLink.countryName == "Unknown"
                          ? const Text("")
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      dialog(context, "Increase");
                                    },
                                    icon: const Icon(Icons.person_add_alt_1,
                                        size: 18),
                                    label: const Text("Increase"),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      if (contractLink.currentPopulation !=
                                          "0") {
                                        dialog(context, "Decrease");
                                      }
//                                      contractLink.currentPopulation == "0"
//                                          ? null
//                                          : dialog(context, "Decrease");
                                    },
                                    icon: const Icon(Icons.person_remove_alt_1,
                                        size: 18),
                                    label: const Text("Decrease"),
                                  )
                                ],
                              ),
                            )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  dialog(context, method) {
    final contractLink = Provider.of<ContractLinking>(context, listen: false);
    TextEditingController countController = TextEditingController();
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: method == "Increase"
                  ? const Text("Increase Population")
                  : const Text("Decrease Population"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Current Population is ${contractLink.currentPopulation}"),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextField(
                      controller: countController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: method == "Increase"
                            ? "Increase Population By ..."
                            : "Decrease Population By ...",
                      ),
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                Row(
                  children: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: method == "Increase"
                          ? const Text("Increase")
                          : const Text("Decrease"),
                      onPressed: () {
                        method == "Increase"
                            ? contractLink.increasePopulation(
                                int.parse(countController.text))
                            : contractLink.decreasePopulation(
                                int.parse(countController.text));
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ));
  }
}
