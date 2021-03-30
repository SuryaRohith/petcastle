//this is just a navigating page
//there is a glitch , this needs to be resolved
//for now , when landed on this page(which we should not ), we should click on the button to go back to the services page
import 'package:flutter/material.dart';

import 'package:petcastle/CustomerPages/AddService.dart';
import 'package:petcastle/CustomerPages/Bill.dart';
import 'package:petcastle/CustomerPages/MyProfile.dart';
import 'package:petcastle/CustomerPages/SelectedService.dart';
import 'package:petcastle/Login/LogInScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Book extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  int x = 2;
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  String finalEmail;

  Future getValidationData() async {
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtainedEmail = prefs.getString('username');
    setState(() {
      finalEmail = obtainedEmail;
    });
    print(finalEmail);
  }

  @override
  void initState() {
    getValidationData().whenComplete(() async {
      if (finalEmail == null) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Please Login to use this feature!'),
                  content: Container(
                    child: FlatButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LogIn(),
                            ),
                          );
                        },
                        child: Text("Login")),
                    height: 15,
                  ),
                ));
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddService(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select a Date'),
          backgroundColor: Colors.blueGrey[600],
        ),
        body: Center(
            child: RaisedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SelectedService(),
              ),
            );
          },
          child: Text('Go back to services'),
        )));
  }
}
