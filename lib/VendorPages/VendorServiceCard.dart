import 'dart:io';

import 'package:flutter/material.dart';

import 'dart:async';
import 'package:petcastle/VendorPages/VendorServices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

SharedPreferences prefs;
String Email;
var jsonArr = new List();
var jsonStr;
String tempserv;
var result;
int x;
Map<String, dynamic> decoded;
List<VService> DartArr = new List<VService>();
//VService v1 = new VService();
var VserArr = new List<VService>();

class VService {
  String Service_name;
  String Vendor_email;
  String Price;
  //VService(this.Vendor_email, this.Service_name, this.Price);
  VService() {
    this.Vendor_email = Vendor_email;
    this.Service_name = Service_name;
    this.Price = Price;
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Vendor_email': Vendor_email,
      'Service_name': Service_name,
      'Service_price': Price
    };
  }

  VService.fromJson(Map<String, dynamic> json)
      : Vendor_email = json['Vendor_email'],
        Service_name = json['Service_name'],
        Price = json['Service_price'];
}

Future<List<String>> _postData() async {
  print("post id starts");
 // Email = await prefs.getString("username");
  var body = Email;
  var url = Uri.parse("http://192.168.0.9:8090/dispserv");

  //final response = await http.Client().post("http://192.168.0.9:8080/login",body: json.encode("hello"));
  await http.post(url, body: json.encode(body)).then((http.Response response) {
    if (response.statusCode == 200) {
      print("----------------------------------------------------------");
      print(" jsafjdsfkjdshgkjfdkg " + response.body);
      result = response.body;
      jsonArr = json.decode(result);
    }
  });
  return jsonArr;
}

class VSC extends StatefulWidget {
  @override
  _VSCState createState() => _VSCState();
}

class _VSCState extends State<VSC> {
  int x = 1;

  @override
  void initState() {
    super.initState();
    //initiatePreferences();
  }

  Future<void> initiatePreferences() async {
    prefs = await SharedPreferences.getInstance();
    print("entered preferenes");
    await DartArr.clear();
    Email = await prefs.getString("vendor_login_email");
    await _postData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF546E7A),
          title: const Text('Pet Castle'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VendorServices()),
                );
              },
            ),
          ],
        ),
        body: Container(
            child: FutureBuilder(
                future: initiatePreferences(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // print("entering snapshot");
                  // print("sanp shot is ");
                  // print(snapshot.data);
                  // print(DartArr);
                  if (jsonArr == null) {
                    x = 0;
                    print(DartArr);
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 120.0),
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                  child: Image.asset(
                                'assets/images/mypets.jpeg',
                                height: 150,
                                width: 200,
                              )),
                              Text(
                                'Let us know about your services !',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueGrey[600],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  '(Note : Please click the + icon in the \ntop right corner to add your service.)',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  if (jsonArr != null) {
                    x = jsonArr.length;
                    print(" the length of json array is ");
                    // print(x);
                    for (int i = 0; i < jsonArr.length; i++) {
                      VService v1 = VService.fromJson(jsonArr[i]);
                      DartArr.add(v1);
                    }
                    // for(int j=0;j<DartArr.length;j++)
                    // {
                    //   //print(DartArr[j].Service_name);
                    // }

                    //print(DartArr);
                    return ListView.builder(
                        itemCount: x,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Card(
                              elevation: 10,
                              color: Colors.blueGrey[100],
                              child: Container(
                                width: 380,
                                height: 120,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              (DartArr[index].Service_name)
                                                  .toString(),
                                              //jsonArr[i].['Vendor_email'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              (DartArr[index].Price).toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
                  DartArr.clear();
                })));
  }
}
