//yet to be done
//i copied the loginscreen dont worry
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/AfterLogin.dart';
import 'package:petcastle/Login/ForgotPasswordOTP.dart';
import 'package:petcastle/Login/SignUpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = false;
  SharedPreferences prefs;
  String username = "";
  String password = "";

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
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Login as a customer',
                  style: TextStyle(fontSize: 24, color: Colors.blueGrey[600]),
                ),
                SizedBox(
                  height: 120,
                ),
                Column(
                  children: [
                    TextFormField(
                        controller: usernameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length < 5) {
                            return 'Name should be greater than 5 characters';
                          }
                          return null;
                        },
                        decoration: new InputDecoration(
                            hintText: "Enter your username")),
                    TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        obscureText: _obscureText,
                        decoration: new InputDecoration(
                            hintText: "Enter your password")),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Container(
                      width: 100,
                      color: Colors.blueGrey[600],
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AfterLogin()),
                            );
                          } else {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 50,
                                  ),
                                  content: Text(
                                      "Invalid username or password. you need to sign uppp"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Ok"))
                                  ],
                                );
                              },
                            );
                          }
                        },
                        color: Colors.blueGrey[600],
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    RaisedButton(
                        child: Text('Forgot Password?'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FPOTP()),
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 250.0),
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Don't have an account?",
                            style: TextStyle(color: Colors.blueGrey[600])),
                      ),
                    ),
                    Container(
                      width: 100,
                      color: Colors.blueGrey[600],
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()),
                          );
                        },
                        color: Colors.blueGrey[600],
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-forma
    );
  }
}
