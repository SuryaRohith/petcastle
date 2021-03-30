//This is the page when an unauntenticated user clicks on profile from the bottom navbar .
//This contains login/sign up as a user and login/signup as a vendor .
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/AfterLogin.dart';
import 'package:petcastle/CustomerPages/Notifications.dart';
import 'package:petcastle/Login/LogInScreen.dart';
import 'package:petcastle/Login/LogInScreenV.dart';

import 'package:petcastle/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF546E7A),
        title: const Text('Pet Castle'),
        actions: <Widget>[
          Column(
            children: [
              IconButton(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyStatefulWidget()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/petswelcome2.jpg',
                width: 200,
                height: 200,
              ),
              Container(
                child: (RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
                  },
                  textColor: Colors.white,
                  color: Colors.blueGrey[600],
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Login/sign up as customer',
                      style: TextStyle(fontSize: 15)),
                )),
              ),
              Container(
                child: (RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VLogIn()),
                    );
                  },
                  textColor: Colors.white,
                  color: Colors.blueGrey[600],
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Login/sign up as Vendor',
                      style: TextStyle(fontSize: 15)),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
