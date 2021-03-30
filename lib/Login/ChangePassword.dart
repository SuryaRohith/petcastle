//This page appears when the user clicks on forget password and enters the correct OTP that is sent to the mail .He can change his password through this .
//has bugs ., commented those . will work
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/AppHome.dart';
import 'package:petcastle/CustomerPages/MyDoctor(withfuture).dart';
import 'package:petcastle/Login/LogInScreen.dart';
import 'package:petcastle/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  SharedPreferences prefs;

  TextEditingController cpController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pet castle"),
          backgroundColor: Colors.blueGrey[600],
        ),
        body: Center(
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
              child: SingleChildScrollView(
                  child: Form(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          TextFormField(
                              controller: cpController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a text';
                                } else if (value.length < 8) {
                                  return 'Password should contain >= 8 characters';
                                }
                                return null;
                              },
                              decoration: new InputDecoration(
                                  hintText: "Enter your new password")),
                        ],
                      ),
                      Column(children: [
                        Container(
                            width: 100,
                            child: RaisedButton(
                                color: Colors.blueGrey[600],
                                textColor: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LogIn()),
                                  );
                                },
                                child: Text('Change')))
                      ])
                    ]),
              ))),
        ));
  }
}
