//this page appears when the user clicks on profile from the file customerlist.dart
//this contains the pet details and profile in appbar
//he can click on + to addd a pet , which can be done in addpet.dart
//if there are no pets it shows an image and a text saying to add
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/AddMorePet.dart';
import "package:http/http.dart" as http;
import 'package:petcastle/CustomerPages/ViewProfile.dart';
import 'dart:convert';
import 'package:petcastle/Login/LogInScreen.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petcastle/CustomerPages/AddPet.dart';

SharedPreferences prefs;
String Email;
var jsonArr = new List();
var jsonStr;
var result;
int x;
Map<String, dynamic> decoded;
List<OPet> DartArr = new List<OPet>();
//VService v1 = new VService();
var VserArr = new List<OPet>();

// SharedPreferences prefs;
// String Email;
// var jsonArr = new List();
// var jsonStr;
// var result;
// int x;
// Map<String, dynamic> decoded;
// List<VService> DartArr = new List<VService>();
// //VService v1 = new VService();
// var VserArr = new List<VService>();
//

class OPet {
  String Pet_name;
  String Owner_email;
  String Owner_phno;
  String Owner_name;
  String Pet_DOB;
  String Pet_breed;
  OPet() {
    this.Owner_email = Owner_email;
    this.Owner_name = Owner_name;
    this.Owner_phno = Owner_phno;
    this.Pet_name = Pet_name;
    this.Pet_DOB = Pet_DOB;
    this.Pet_breed = Pet_breed;
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Owner_email': Owner_email,
      'Owner_name': Owner_name,
      'Onwer_phno': Owner_phno,
      'Pet_name': Pet_name,
      'Pet_DOB': Pet_DOB,
      'Pet_breed': Pet_breed
    };
  }

  OPet.fromJson(Map<String, dynamic> json)
      : Owner_email = json['Owner_email'],
        Owner_phno = json['Owner_phno'],
        Owner_name = json['Owner_name'],
        Pet_name = json['Pet_name'],
        Pet_DOB = json['Pet_DOB'],
        Pet_breed = json['Pet_breed'];
}

Future<List<String>> _postData() async {
  print("post id starts");
  Email = await prefs.getString("username");
  var body = Email;
  var url = Uri.parse("http://192.168.0.9:8090/disppet");
  await http.post(url, body: json.encode(body)).then((http.Response response) {
    if (response.statusCode == 200) {
      print("----------------------------------------------------------");
      print(" The Response is " + response.body);
      result = response.body;
      jsonArr = json.decode(result);
    }
  });
  return jsonArr;
}

class AddMorePet extends StatefulWidget {
  @override
  _AddMorePetState createState() => _AddMorePetState();
}

class _AddMorePetState extends State<AddMorePet> {
  int x = 2;
  @override
  void initState() {
    super.initState();
    initiatePreferences();
  }

  void initiatePreferences() async {
    prefs = await SharedPreferences.getInstance();
    print("entered preferenes");
    await DartArr.clear();
    Email = await prefs.getString("username");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Castle'),
        backgroundColor: Colors.blueGrey[600],
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewProfile()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddPet()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
              future: _postData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (jsonArr == null) {
                  return SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 120.0),
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                  child: Image.asset(
                                'assets/images/mypets.jpeg',
                                height: 200,
                                width: 200,
                              )),
                              Text(
                                'Let us know about your Pet !',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blueGrey[600],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '(Note : Please click the + icon in the \ntop right corner to add the details)',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  if (jsonArr != null) {
                    x = jsonArr.length;
                    print(" the length of json array is ");
                    // print(x);
                    for (int i = 0; i < jsonArr.length; i++) {
                      OPet o1 = OPet.fromJson(jsonArr[i]);
                      DartArr.add(o1);
                    }
                    return ListView.builder(
                        physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: DartArr.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Card(
                              elevation: 10,
                              color: Colors.blueGrey[100],
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Container(
                                  height: 160,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          //crossAxisAlignment:
                                          //    CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Name  :   ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                  Text(
                                                    DartArr[index].Pet_name,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Type   :    ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                  Text(
                                                    DartArr[index].Pet_breed,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'DOB   :    ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                  Text(
                                                    DartArr[index].Pet_DOB,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                              child: Row(
                                                children: [
                                                  new IconButton(
                                                    icon: new Icon(Icons.edit,
                                                        size: 15.0),
                                                    onPressed: () {},
                                                  ),
                                                  new IconButton(
                                                    icon: new Icon(
                                                        Icons.delete_outline,
                                                        size: 15.0),
                                                    onPressed: () {},
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }
                }
              }),
        ),
      ),
    );
  }
}
