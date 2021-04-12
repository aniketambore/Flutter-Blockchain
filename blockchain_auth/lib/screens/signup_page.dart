import 'dart:async';

import 'package:blockchain_auth/contract_link/contract_linking.dart';
import 'package:blockchain_auth/custom_widgets/button_plain_shadow.dart';
import 'package:blockchain_auth/custom_widgets/head_text.dart';
import 'package:blockchain_auth/screens/home_page.dart';
import 'package:blockchain_auth/screens/login_page.dart';
import 'package:blockchain_auth/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  String _name, _email, _password;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  buildHeadText(),
                  buildDescpText(),
                  buildNameTextField(),
                  buildMailTextField(),
                  buildPasswordTextField(),
                  buildSignupButton(),
                  buildLoginAccount(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _signUp() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      //print("Username: $_name , Email: $_email , Password: $_password");
      _createAccount();
    } else {
      print("Invalid");
    }
  }

  _createAccount() {
    var contractLinking = Provider.of<ContractLinking>(context, listen: false);
    contractLinking.createAccount(_name, _password, _email);
  }

  Widget buildLoginAccount(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextButton(
        child: Align(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: black,
                  )),
              TextSpan(
                  text: "Login",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: flamingo))
            ]),
          ),
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginForm()),
              (route) => false);
        },
      ),
    );
  }

  Widget buildSignupButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 34.0),
      child: ButtonPlainWithShadow(
        text: "Sign up",
        shadowColor: wood_smoke,
        borderColor: wood_smoke,
        callback: _signUp,
        color: lightening_yellow,
      ),
    );
  }

  Widget buildPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: TextFormField(
        validator: (val) => val.length < 6 ? "Password is too short" : null,
        onSaved: (val) => _password = val,
        obscureText: _obscureText,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            child: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.black,
            ),
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          hintText: '\u25CF \u25CF \u25CF \u25CF \u25CF \u25CF',
          hintStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: wood_smoke,
          ),
          contentPadding: EdgeInsets.all(16),
          prefixIcon: Icon(Icons.lock),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: black),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: black),
              borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
      ),
    );
  }

  Widget buildMailTextField() {
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: TextFormField(
        validator: (val) => !val.contains("@") ? "Invalid Email" : null,
        onSaved: (val) => _email = val,
        decoration: InputDecoration(
          hintText: "Email address",
          hintStyle: TextStyle(
              fontSize: 21, fontWeight: FontWeight.w500, color: wood_smoke),
          prefixIcon: Icon(Icons.mail),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: black),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: black),
              borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
      ),
    );
  }

  Widget buildNameTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: TextFormField(
        validator: (val) => val.length < 6 ? "Name is too short" : null,
        onSaved: (val) => _name = val,
        decoration: InputDecoration(
          hintText: "Full Name",
          hintStyle: TextStyle(
              fontSize: 21, fontWeight: FontWeight.w500, color: wood_smoke),
          prefixIcon: Icon(Icons.drive_file_rename_outline),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: black),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: black),
              borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
      ),
    );
  }

  Widget buildDescpText() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Text(
        "You have chance to create new account if you really want to.",
        textAlign: TextAlign.start,
        style:
            TextStyle(fontSize: 21, color: trout, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget buildHeadText() {
    return Padding(
      padding: EdgeInsets.only(top: 44),
      child: HeadText(
        text: "Sign up",
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
