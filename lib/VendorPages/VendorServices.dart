//contains a form to add a service

import 'package:flutter/material.dart';

import 'package:petcastle/VendorPages/VendorServiceCard.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:petcastle/Login/LogInScreen.dart';

import 'package:shared_preferences/shared_preferences.dart';

String result = "yes";
String service_type;
List<String> services = new List<String>();
SharedPreferences prefs;
String tempserv;
String _service;

// The Constuctor needs to be optimized
class VService {
  String Service_name;
  String Vendor_email;
  String Price;
  VService() {
    this.Service_name = Service_name;
    this.Price = Price;
    this.Vendor_email = Vendor_email;
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

VService v1 = new VService();

Future<void> _postData() async {
  print("post id starts");
  prefs = await SharedPreferences.getInstance();
  // v1.Vendor_email = "vendor1@gmail.com";
  var body = v1;
  v1.Vendor_email = prefs.getString("vendor_login_email");

  await print(v1.Service_name);

  await print(v1.Price);
  //print("frim the post");

  //print(v1.Vendor_email);
  var url = Uri.parse("http://192.168.0.9:8090/AddService");
  await http.post(url, body: json.encode(body)).then((http.Response response) {
    if (response.statusCode == 200) {
      print("----------------------------------------------------------");
      print(" the response " + response.body);
      result = response.body;
      print("post id done");
      return;
    }
  });
}

class VendorServices extends StatefulWidget {
  @override
  _VendorServicesState createState() => _VendorServicesState();
}

class _VendorServicesState extends State<VendorServices> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController priceController = TextEditingController();

  bool _obscureText = false;
  SharedPreferences prefs;
  bool status = false;
  //var services = ["Checkup", "Vaccine", "Surgery"];
  //var _service = "Checkup";
  void _submit() async {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      await _postData();
      await print(result);
      //if(result == "yes") {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => VSC()),
      //   );
      // }
      // if(result == "no")
      // {
      //   showDialog(
      //     context: context,
      //     barrierDismissible: true,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         title: Icon(
      //           Icons.error,
      //           color: Colors.red,
      //           size: 50,
      //         ),
      //         content: Text(
      //             "Service Already Exists and is Active"),
      //         actions: [
      //           TextButton(
      //               onPressed: () {
      //                 Navigator.pop(context);
      //               },
      //               child: Text("Ok"))
      //         ],
      //       );
      //     },
      //   );
      // }
    }
    _formKey.currentState.save();
  }

  @override
  void initState() {
    super.initState();
    initiatePreferences();
  }

  Future<void> initiatePreferences() async {
    prefs = await SharedPreferences.getInstance();
    // final givenUsername = prefs.getString('username') ?? '';
    // final givenPassword = prefs.getString('password') ?? '';
    // setState(() {
    //   username = givenUsername;
    //   password = givenPassword;
    // });
    v1.Vendor_email = await prefs.getString("vendor_login_email");
    service_type = await prefs.getString("service_type");
    //await print(service_type);
    if (service_type == "Doctor") {
      await setState(() {
        services = ["Checkup", "Vaccine", "Surgery"];
      });
      //_service = "Checkup";

    }
    if (service_type == "Groomer") {
      await setState(() {
        services = ["Haircut", "Bathing", "Spa"];
        //_service = "Haircut";
      });
    }
    if (service_type == "Trainer") {
      await setState(() {
        services = ["Vocal training", "Running", "Playing"];
        //_service = "Vocal Training";
      });
      //services = ["Tricks","Vocal Training","Potty Training"];
    }
    if (service_type == "Hostels") {
      setState(() {
        services = ["One Day", "One week", "One Month"];
        //_service = "One Day";
      });
    }
   // await print(v1.Vendor_email);
  }

  //DateTime selectedDate = DateTime.now();

  /*_selectDate(BuildContext context) async {
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
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Castle'),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // padding: const EdgeInsets.all(10),
              Image.asset('assets/images/dogpeek.png', height: 200, width: 200),

              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey[600]),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Container(
                  child: FutureBuilder(
                    //future: initiatePreferences(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      var services2 = services;
                      //print(services);
                      return new Container(
                        child: SingleChildScrollView(
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Form(
                                          key: _formKey,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      18.0),
                                                  child: Text(
                                                    ' New Service Details',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors
                                                            .blueGrey[600]),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(18.0),
                                                          child: Text(
                                                              ' Service Name --> '),
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          width: 120,
                                                          child:
                                                              DropdownButtonFormField(
                                                            items: services.map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                              );
                                                            }).toList(),
                                                            onChanged:
                                                                (newValue) async {
                                                              print(newValue);
                                                              tempserv = await newValue;
                                                              await setState(() =>
                                                                  _service =
                                                                      newValue);
                                                            },
                                                            value: _service,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          10,
                                                                          10,
                                                                          10),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(18.0),
                                                          child: Text(
                                                              'Price per pet -->  '),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          child: TextFormField(
                                                            controller:
                                                                priceController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            validator: (value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return 'Please enter Enter price';
                                                              }

                                                              return null;
                                                            },
                                                            obscureText:
                                                                _obscureText,
                                                            decoration:
                                                                new InputDecoration(
                                                                    hintText:
                                                                        ""),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    /* Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(18.0),
                                                    child:
                                                        Text('Choose feasible dates=>'),
                                                  ),
                                                  Column(
                                                    children: [
                                                      IconButton(
                                                        icon:
                                                            Icon(Icons.calendar_today),
                                                        onPressed: () =>
                                                            _selectDate(context),
                                                        color: Colors.blueGrey[600],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),*/
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: RaisedButton(
                                                      child: Text('Add'),
                                                      onPressed: () async {
                                                        v1.Service_name = await tempserv;
                                                           v1.Price=  await priceController.text
                                                                .toString();
                                                        v1.Vendor_email =
                                                            await prefs
                                                                .getString(
                                                                    "vendor_login_email");
                                                        await _submit();
                                                        if (result == "yes") {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        VSC()),
                                                          );
                                                        }
                                                        if (result == "no") {
                                                          showDialog(
                                                            context: context,
                                                            barrierDismissible:
                                                                true,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: Icon(
                                                                  Icons.error,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 50,
                                                                ),
                                                                content: Text(
                                                                    "Service Already Exists and is Active"),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "Ok"))
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        }
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
