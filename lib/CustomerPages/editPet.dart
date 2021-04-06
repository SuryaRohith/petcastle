//this is the form to add a pet
//it is displayed after the addmorepet page when the user clicks the + icon
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/AddPet.dart';
import 'package:petcastle/CustomerPages/AddMorePet.dart';
import "package:http/http.dart" as http;
import 'package:petcastle/CustomerPages/ViewProfile.dart';
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';

String result = "yes";
String Email;
String petid;
//String Name;
String newPetName;
String newBreed;
String newDob;
//SharedPreferences pref;
class editPet {
  String Pet_id;
  String Pet_name;
  String Owner_email;
  String Pet_DOB;
  String Pet_breed;
  editPet() {
    this.Pet_id = Pet_id;
    this.Pet_name = Pet_name;
    this.Pet_DOB = Pet_DOB;
    this.Pet_breed = Pet_breed;
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Pet_id': Pet_id,
      'Owner_email': Owner_email,
      'Pet_name': Pet_name,
      'Pet_DOB': Pet_DOB,
      'Pet_breed': Pet_breed
    };
  }

  editPet.fromJson(Map<String, dynamic> json)
      : Pet_id = json['Pet_id'],
        Owner_email = json['Owner_email'],
        Pet_name = json['Pet_name'],
        Pet_DOB = json['Pet_DOB'],
        Pet_breed = json['Pet_breed'];
}

editPet ep1 = new editPet();
Future<void> _editData() async {
  print("post id starts");
  // v1.Vendor_email = "vendor1@gmail.com";
  var body = jsonEncode(ep1);
  var url = Uri.parse("http://192.168.0.156:8090/editPet");
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



class EditPet extends StatefulWidget {
  @override
  _EditPetState createState() => _EditPetState();
}

class _EditPetState extends State<EditPet> {
  SharedPreferences prefs;
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = false;
  bool _isEditingText = false;
  bool _isEditingText1 = false;
   bool _isEditingText2 = false;
  TextEditingController _editingController;
  TextEditingController _editingController1;
  TextEditingController _editingController2;
  String initialText;
  String initialText1;
  String initialText2;

  void _submit() async {
    await _editData();
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
  Future<void> preData() async{

    print("hello");
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var P = await prefs.getString('Name');
    var Q = await prefs.getString('Breed');
    var R= await prefs.getString('DOB');
    setState(() {
      initialText = P;
      initialText1 = Q;
      initialText2 = R;
    });
    print(initialText);
    print(initialText1);
    print(initialText2);
  }
  //@override
  void initState() {
    saveDetails();
    preData().whenComplete(() async {
      _editingController = TextEditingController(text: initialText);
      _editingController1 = TextEditingController(text: initialText1);
      _editingController2 = TextEditingController(text: initialText2);
    });
    super.initState();
    //print(initialText);


  }

  @override
  void dispose() {
    _editingController.dispose();
    _editingController1.dispose();
    _editingController2.dispose();
    super.dispose();
  }

  void saveDetails() async {
    prefs = await SharedPreferences.getInstance();
    //prefs.setString('username', username);
    //prefs.setString('password', password);
    Email = await prefs.getString("username");
    petid = await prefs.getString('petid');
    //newPetName = await prefs.getString("Name");
  }

  Widget _editTitleTextField() {
    if (_isEditingText)
      return Center(
        child: TextField(
          onSubmitted: (newValue){
            setState(() {
              initialText = newValue;
              _isEditingText =false;
            });
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Text(
          initialText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        )
    );
  }

  Widget _editTitleTextField1() {
    if (_isEditingText1)
      return Center(
        child: TextField(
          onSubmitted: (newValue){
            setState(() {
              initialText1 = newValue;
              _isEditingText1 =false;
            });
          },
          autofocus: true,
          controller: _editingController1,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText1 = true;
          });
        },
        child: Text(
          initialText1,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        )
    );
  }


  Widget _editTitleTextField2() {
    if (_isEditingText2)
      return Center(
        child: TextField(
          onSubmitted: (newValue){
            setState(() {
              initialText2 = newValue;
              _isEditingText2 =false;
            });
          },
          autofocus: true,
          controller: _editingController2,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText2 = true;
          });
        },
        child: Text(
          initialText2,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        )
    );
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
                                    controller: _editingController,
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
                                    controller: _editingController1,
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
                                    controller: _editingController2,
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
                                    child: Text('Edit'),
                                    onPressed: () async {
                                      ep1.Pet_name = _editingController.text.toString();
                                      print(ep1.Pet_name);
                                      ep1.Pet_DOB = _editingController1.text.toString();
                                      ep1.Pet_breed = _editingController2.text.toString();
                                      ep1.Owner_email = await prefs.getString("username");
                                      ep1.Pet_id = await prefs.getString("petid");
                                      print(ep1.Pet_id);
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
