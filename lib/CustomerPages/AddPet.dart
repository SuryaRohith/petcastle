//this is the form to add a pet
//it is displayed after the addmorepet page when the user clicks the + icon
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/AddMorePet.dart';
import "package:http/http.dart" as http;
import 'package:petcastle/CustomerPages/ViewProfile.dart';
import 'dart:convert';
import 'package:petcastle/Login/LogInScreen.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

String result = "yes";

//SharedPreferences pref;
class OPet {
  String Pet_name;
  String Owner_email;
  String Pet_DOB;
  String Pet_breed;
  OPet() {
    this.Pet_name = Pet_name;
    this.Pet_DOB = Pet_DOB;
    this.Pet_breed = Pet_breed;
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Owner_email': Owner_email,
      'Pet_name': Pet_name,
      'Pet_DOB': Pet_DOB,
      'Pet_breed': Pet_breed
    };
  }

  OPet.fromJson(Map<String, dynamic> json)
      : Owner_email = json['Owner_email'],
        Pet_name = json['Pet_name'],
        Pet_DOB = json['Pet_DOB'],
        Pet_breed = json['Pet_breed'];
}

OPet o1 = new OPet();
Future<void> _postData() async {
  print("post id starts");
  // v1.Vendor_email = "vendor1@gmail.com";
  var body = jsonEncode(o1);
  var url = Uri.parse("http://192.168.0.9:8090/AddPet");
  await http.post(url, body: body).then((http.Response response) {
    if (response.statusCode == 200) {
      print("----------------------------------------------------------");
      print(" the response " + response.body);
      result = response.body;
      print("post id done");
      return;
    }
  });
}

class AddPet extends StatefulWidget {
  @override
  _AddPetState createState() => _AddPetState();
}

class _AddPetState extends State<AddPet> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  bool _obscureText = false;
  SharedPreferences prefs;
  void _submit() async {
    await _postData();
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      if (result == "yes") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddMorePet()),
        );
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
              content: Text("Pet Already Exists and is Active"),
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
    }
    if (!isValid) {
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
            content: Text("Details not valid"),
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

    _formKey.currentState.save();
  }

  void initState() {
    super.initState();
    initiatePreferences();
  }

  void initiatePreferences() async {
    prefs = await SharedPreferences.getInstance();
    // final givenUsername = prefs.getString('username') ?? '';
    // final givenPassword = prefs.getString('password') ?? '';
    // setState(() {
    //   username = givenUsername;
    //   password = givenPassword;
    // });
    o1.Owner_email = await prefs.getString("username");
    await print(o1.Owner_email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pet Profile'),
          backgroundColor: Colors.blueGrey[600],
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewProfile()),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 300,
                    child: new Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey[600]),
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextFormField(
                                    controller: nameController,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter pet name';
                                      }
                                      return null;
                                    },
                                    decoration: new InputDecoration(
                                        prefixIcon: Icon(Icons.alternate_email),
                                        hintText: "Enter your Pet Name",
                                        hintStyle: TextStyle(fontSize: 13)),
                                  ),
                                  TextFormField(
                                    controller: typeController,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter pet type';
                                      }
                                      return null;
                                    },
                                    obscureText: _obscureText,
                                    decoration: new InputDecoration(
                                        prefixIcon: Icon(Icons.pets),
                                        hintText: "Enter your Pet Type",
                                        hintStyle: TextStyle(fontSize: 13)),
                                  ),
                                  TextFormField(
                                    controller: dobController,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter pets DOB';
                                      }
                                      return null;
                                    },
                                    obscureText: _obscureText,
                                    decoration: new InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.calendar_today_outlined),
                                        hintText: "Enter your Pet's DOB",
                                        hintStyle: TextStyle(fontSize: 13)),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: RaisedButton(
                                    child: Text('Add'),
                                    onPressed: () async {
                                      o1.Pet_name =
                                          nameController.text.toString();
                                      o1.Pet_DOB =
                                          dobController.text.toString();
                                      o1.Pet_breed =
                                          typeController.text.toString();
                                      o1.Owner_email =
                                          await prefs.getString("username");
                                      await _submit();
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          ),
        ));
  }
}
