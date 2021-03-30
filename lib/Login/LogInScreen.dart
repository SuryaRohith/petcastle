//Login page for customer
//modification:done
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/AfterLogin.dart';
import 'package:petcastle/Login/ForgotPasswordOTP.dart';
import 'package:petcastle/Login/SignUpScreen.dart';
import 'package:petcastle/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String result;

class Login {
  String Email;
  String Password;
  Login() {
    this.Email = Email;
    this.Password = Password;
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'Email': Email, 'Password': Password};
  }

  Login.fromJson(Map<String, dynamic> json)
      : Email = json['Email'],
        Password = json['Password'];
}

Login l1 = new Login();
// void  _getData() async {
//   var url ="http://192.168.0.9:8090/loginowner";
//   final response = await http.get(url);
//   result = response.body;
//   //response.body.Close();
//   print("the result is");
//   print(result);
//
//
// }
Future<http.Response> _postData() async {
  print("post id starts");

  var body = jsonEncode(l1);
  var url = Uri.parse("http://192.168.0.9:8090/loginowner");
  //final response = await http.Client().post("http://192.168.0.9:8080/login",body: json.encode("hello"));
  await http.post(url, body: body).then((http.Response response) {
    if (response.statusCode == 200) {
      print("----------------------------------------------------------");
      print(" jsafjdsfkjdshgkjfdkg " + response.body);
      result = response.body;
      print("post id done");
      return;
    }
  });
}

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
    initiatePreferences();
  }

  void initiatePreferences() async {
    prefs = await SharedPreferences.getInstance();
    final givenUsername = prefs.getString('username') ?? '';
    final givenPassword = prefs.getString('password') ?? '';
    setState(() {
      username = givenUsername;
      password = givenPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final h = data.size.height;
    final w = data.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pet castle"),
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
                        child: Text("LOGIN FOR PET OWNERS",
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
                          l1.Email = usernameController.text.toString();
                          l1.Password = passwordController.text.toString();

                          await _postData();
                          print("entered post");
                          // _getData();
                          // print("entered get ");
                          if (result == "yes") {
                            //l1.Email = usernameController.text;
                            //l1.Password = passwordController.text;
                            print(l1.Email);
                            prefs.setString("username", l1.Email);
                            print("set usernamw");
                            print(prefs.getString("username"));
                            bool userFound = true;

                            if (userFound) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyStatefulWidget()),
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
                                      "There is no account with this username . Please SignUp"),
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
                                builder: (context) => SignUpScreen()),
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
