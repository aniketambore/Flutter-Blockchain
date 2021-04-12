import 'dart:async';

import 'package:blockchain_auth/contract_link/contract_linking.dart';
import 'package:blockchain_auth/custom_widgets/button_plain_icon.dart';
import 'package:blockchain_auth/custom_widgets/head_text.dart';
import 'package:blockchain_auth/screens/home_page.dart';
import 'package:blockchain_auth/screens/signup_page.dart';
import 'package:blockchain_auth/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String _email, _password;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    var contractLinking = Provider.of<ContractLinking>(context);
    return Scaffold(
        body: Container(
      color: white,
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                buildHeadLogo(),
                buildHeadText(),
                buildMailTextField(),
                buildPassTextField(),
                buildSigninButton(),
                buildSignUpAccount(context)
              ],
            ),
          ),
        ),
      ),
    ));
  }

  _loginAccount() {
    var contractLinking = Provider.of<ContractLinking>(context, listen: false);

    contractLinking.loginAccount(_email, _password);

    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  _signIn() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print("Mail: $_email , Password: $_password");
      _loginAccount();
    } else {
      print("Invalid");
    }
  }

  Padding buildSignUpAccount(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 26.0),
      child: TextButton(
        child: Align(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Your are new? ",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: black,
                  )),
              TextSpan(
                  text: "Create new",
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
              MaterialPageRoute(builder: (context) => SignUp()),
              (route) => false);
        },
      ),
    );
  }

  Widget buildSigninButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 48.0),
      child: ButtonPlainWithIcon(
        color: wood_smoke,
        textColor: white,
        icon: Icon(Icons.forward),
        isPrefix: false,
        isSuffix: true,
        text: "Sign in",
        callback: _signIn,
      ),
    );
  }

  Widget buildPassTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: TextFormField(
        validator: (val) => val.length < 6 ? "Password is too short" : null,
        onSaved: (val) => _password = val,
        obscureText: _obscureText,
        decoration: InputDecoration(
          suffix: GestureDetector(
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

  Padding buildMailTextField() {
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

  Padding buildHeadText() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: HeadText(
        text: "Login",
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Row buildHeadLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.check_box_outline_blank,
          color: Colors.tealAccent,
          size: 120,
        )
      ],
    );
  }
}
