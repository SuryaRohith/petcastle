//Login page for Vendor
//modification:done
import 'package:flutter/material.dart';

import 'package:petcastle/Login/ForgotPasswordOTP.dart';

import 'package:petcastle/Login/SignUpScreenV.dart';
import 'package:petcastle/VendorPages/VendorHome.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:petcastle/CustomerPages/AfterLogin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login {
  String Email;
  String Password;
  String Type;
  Login() {
    this.Email = Email;
    this.Password = Password;
    this.Type = Type;
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Email': Email,
      'Password': Password,
      'Vendor_service_type': Type
    };
  }

  Login.fromJson(Map<String, dynamic> json)
      : Email = json['Email'],
        Password = json['Password'],
        Type = json['Vendor_service_type'];
}

Login l1 = new Login();
// void  _getData() async {
//   var url ="http://192.168.0.9:8090/login";
//   final response = await http.get(url);
//   result = response.body;
//   //response.body.Close();
//   print("the result is");
//   print(result);
//
//
// }
Future<http.Response> _postData() async {
  await print("post id starts");
  prefs =await SharedPreferences.getInstance();
  var body = l1;

  var url = await Uri.parse("http://192.168.0.9:8090/loginvendor");
  //final response = await http.Client().post("http://192.168.0.9:8080/login",body: json.encode("hello"));
  await http.post(url, body: json.encode(body)).then((http.Response response) {
    if (response.statusCode == 200) {
      print("----------------------------------------------------------");
      print(" jsafjdsfkjdshgkjfdkg " + response.body);

      result = response.body;
      var result2 = result.split(",");
      result = result2[0];
      l1.Type = result2[1];

      prefs.setString("service_type", l1.Type);
      print("post id done");
      return;
    }
  });
}

class VLogIn extends StatefulWidget {
  @override
  _VLogInState createState() => _VLogInState();
}

class _VLogInState extends State<VLogIn> {
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
    initiatePreferences();
  }

  Future<void> initiatePreferences() async {
    prefs = await SharedPreferences.getInstance();
  //   final givenUsername = prefs.getString('username') ?? '';
  //   final givenPassword = prefs.getString('password') ?? '';
    setState(() {
      //username = givenUsername;
      //password = givenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final h = data.size.height;
    final w = data.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pet Castle"),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: h * 1,
            width: w * 1,
            padding:
                EdgeInsets.symmetric(vertical: h * 0.2, horizontal: w * 0.07),
            child: Card(
              shadowColor: Colors.grey,
              elevation: 15,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        //color: Colors.pink,
                        alignment: Alignment.center,
                        height: h * 0.15,
                        child: Text("LOGIN FOR VENDORS",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[600]))),
                    Container(
                      height: h * 0.07,
                      width: w * 0.7,
                      child: TextFormField(
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
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(30.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            hintStyle:
                                new TextStyle(color: Colors.blueGrey[800]),
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: "Enter your username"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.03),
                      child: Container(
                        // color: Colors.blue,
                        height: h * 0.07,
                        width: w * 0.7,
                        child: TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(30.0),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.blueGrey[50],
                                hintStyle:
                                    new TextStyle(color: Colors.blueGrey[800]),
                                prefixIcon: Icon(Icons.lock_outline),
                                hintText: "Enter your Password")),
                      ),
                    ),
                    FlatButton(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Colors.blueGrey[600],
                              decoration: TextDecoration.underline),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FPOTP()),
                          );
                        }),
                    Container(
                      width: w * 0.25,
                      child: RaisedButton(
                        onPressed: () async {
                          l1.Email =await  usernameController.text.toString();
                          l1.Password =await  passwordController.text.toString();

                          await _postData();
                          print(l1.Type);
                          await prefs.setString("service_type", l1.Type);
                          await print("getting" + prefs.get("service_type"));
                          print("entered  post");
                          // _getData();
                          print(result);
                          // print("entered get ");
                          if (result == "yes") {
                            //l1.Email = usernameController.text;
                            //l1.Password = passwordController.text;
                            bool userFound = true;
                            await prefs.setString("vendor_login_email", l1.Email);
                            if (userFound) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyStatefulWidget2()),
                              );
                            }
                          }
                          if (result == "no") {
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
                                      "Invalid username or password. you need to sign up"),
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        color: Colors.blueGrey[600],
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: w * 0.7,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreenV()),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              'Dont have an account ?',
                              style: TextStyle(
                                color: Colors.blueGrey[600],
                              ),
                            ),
                            Text("Sign Up",
                                style: TextStyle(
                                  color: Colors.pink[900],
                                  decoration: TextDecoration.underline,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
