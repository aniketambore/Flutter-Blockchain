import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:population/contract_linking.dart';
import 'package:provider/provider.dart';

class SetPopulation extends StatefulWidget {
  const SetPopulation({Key? key}) : super(key: key);

  @override
  _SetPopulationState createState() => _SetPopulationState();
}

class _SetPopulationState extends State<SetPopulation> {
  Country _selectedCountry = CountryPickerUtils.getCountryByIsoCode('AF');

  TextEditingController countryNameController =
      TextEditingController(text: "Unknown");
  TextEditingController populationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final contractLink = Provider.of<ContractLinking>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Set Population"),
          actions: [
            TextButton(
                onPressed: () {
                  contractLink.setData(countryNameController.text,
                      BigInt.from(int.parse(populationController.text)));
                  Navigator.pop(context);
                },
                child: const Text(
                  "SAVE",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ))
          ],
        ),
        body: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  stackCard(countryFlagPicker(), countryFlag()),
                  stackCard(populationTextfield(), countryFlag()),
                ],
              ),
            ),
          ),
        ));
  }

  Widget stackCard(Widget widget1, Widget widget2) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 54),
          child: SizedBox(
            height: 120,
            child: Card(
              color: Colors.cyan,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [widget1],
              ),
            ),
          ),
        ),
        widget2
      ],
    );
  }

  Widget countryFlag() {
    return Positioned(
      top: 15,
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: SizedBox(
                width: 80,
                height: 50,
                child:
                    CountryPickerUtils.getDefaultFlagImage(_selectedCountry))),
      ),
    );
  }

  Widget countryFlagPicker() {
    return CountryPickerDropdown(
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onValuePicked: (Country country) {
        print("${country.name}");
        setState(() {
          _selectedCountry = country;
          countryNameController.text = country.isoCode;
        });
      },
      itemBuilder: (Country country) {
        return Row(
          children: <Widget>[
            const SizedBox(width: 48.0),
            CountryPickerUtils.getDefaultFlagImage(country),
            const SizedBox(width: 8.0),
            Expanded(
                child: Text(
              country.name,
              style: const TextStyle(
                  color: Colors.brown,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )),
          ],
        );
      },
      icon: const Icon(
        Icons.arrow_downward,
        color: Colors.white,
        size: 50,
      ),
      itemHeight: null,
      isExpanded: true,
    );
  }

  Widget populationTextfield() {
    return Padding(
      padding: const EdgeInsets.only(left: 48.0, right: 5),
      child: TextField(
        decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.black,
            focusedBorder: OutlineInputBorder(),
            labelText: "Population",
            labelStyle: TextStyle(color: Colors.white),
            hintText: "Enter Population",
            prefixIcon: Icon(Icons.person_pin_outlined)),
        keyboardType: TextInputType.number,
        controller: populationController,
      ),
    );
  }
}
