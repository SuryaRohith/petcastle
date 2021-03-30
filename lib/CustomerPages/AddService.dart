//modification:done
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/selectedservicecards.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petcastle/VendorPages/VendorServiceCard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

var jsonArr;
Map servPrice={};
SharedPreferences prefs;
String result = "yes";
String service_type;
String strServ = "";
String strPrice = "";
String strPet = "";
String strDate = "";

List<String> services = new List<String>();
List<String> pets = new List<String>();
List<String> prices = new List<String>(); //SharedPreferences prefs;
String _service = "";
String _pet = " ";
int x1 = 0;
String Email;
String Vendor_Email;

class Books {
  String Vendor_email;
  String Price;
  String Owner_email;
  String Pet_name;
  String Services;

  Books() {
    this.Vendor_email = Vendor_email;
    this.Price = Price;
    this.Owner_email = Owner_email;
    this.Pet_name = Pet_name;
    this.Services = Services;
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Vendor_email': Vendor_email,
      'Service_Price': Price,
      'Service_name': Services,
      'Pet_name': Pet_name,
      'Owner_email': Owner_email,
    };
  }

  Books.fromJson(Map<String, dynamic> json)
      : Vendor_email = json['Vendor_email'],
        Owner_email = json['Owner_email'],
        Pet_name = json['Pet_name'],
        Price = json['Service_price'],
        Services = json['Service_name'];
}

Future<void> _postData() async {
  print("post id starts");
  // v1.Vendor_email = "vendor1@gmail.com";
  //var body = jsonEncode(b1);

  var body = Email + "," + Vendor_Email;
  await print("the body is");
  await print(body);
  var url = Uri.parse("http://192.168.0.9:8090/AddBook");
  await http.post(url, body: json.encode(body)).then((http.Response response) {
    if (response.statusCode == 200) {
      print("----------------------------------------------------------");
      print(" the response " + response.body);
      result = response.body;
      jsonArr = json.decode(result);
      print(jsonArr);
      //jsonArr = json.decode(result);

      print("post id done");
      return;
    }
  });
}

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController priceController = TextEditingController();
  int x = 1;
  DateTime selectedDate = DateTime.now();
  var final_serv;
  var final_pet;
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

  bool _obscureText = false;
  bool status = false;
  //var services = ["Checkup", "Vaccine", "Surgery"];
  //var _service = "Checkup";
  //var pets = ["Bruno", "Lilly"];
  //var _pet = "Bruno";
  void _submit() async {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SSC()),
      );
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
    print("entered preferenes");
    await DartArr.clear();
    Email = await prefs.getString("username");
    Vendor_Email = await prefs.get("vendor_email");
    await print(Email);
    await print(Vendor_Email);
    await _postData();
    //await print(jsonArr);
    await services.clear();
    Books b1 = new Books.fromJson(jsonArr);
    strServ = await prefs.getString("selected_services") ?? "";
    await strServ.trim();

    strPet = await prefs.getString("selected_pets") ?? "";
    await strPet.trim();
    strDate = await prefs.getString("date") ?? "";
    await strDate.trim();
    await print(b1.Vendor_email);
    await print(b1.Services);
    await prefs.setString("prices", b1.Price);
    await prefs.setString("actual_services", b1.Services);
    await prefs.setString("actual_pets", b1.Pet_name);
    services = await b1.Services.split(",");
    services.removeAt(0);
    _service = services[0];
    pets = await b1.Pet_name.split(",");
    pets.removeAt(0);
    prices = await b1.Price.split(",");
    await print(prices);

    prices.removeAt(0);
    for (int i = 0; i < services.length; i++) {
      servPrice.addAll({services[i]: prices[i]});
    }
    _pet = pets[0];
    //await prefs.set
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final h = data.size.height;
    final w = data.size.width;

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

              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey[600]),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Container(
                  child: FutureBuilder(
                    future: initiatePreferences(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      //var services2 = services;
                      //print(services);
                      return Center(
                        child: SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blueGrey[600],
                                width: 1.0,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                            ),
                            width: w * 0.9,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(w * 0.04),
                                    child: Text(
                                      ' Choose your service',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blueGrey[600]),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(w * 0.04),
                                        child: Container(
                                            width: w * 0.25,
                                            child: Text('Service -->')),
                                      ),
                                      Container(
                                        color: Colors.blueGrey[50],
                                        height: 50,
                                        width: w * 0.45,
                                        child: DropdownButtonFormField(
                                          items: services
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) async {
                                            value:
                                            newValue;

                                            setState(() => _service = newValue);
                                            setState(
                                                () => final_serv = newValue);
                                          },
                                          // value: _service,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(w * 0.04),
                                        child: Container(
                                            width: w * 0.25,
                                            child: Text('Pet --> ')),
                                      ),
                                      Container(
                                        color: Colors.blueGrey[50],
                                        height: 50,
                                        width: w * 0.45,
                                        child: DropdownButtonFormField(
                                          items: pets
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) async {
                                            // print(newValue);
                                            //await prefs.setString("selected_pets", strPet + "," + newValue);

                                            setState(() {
                                              x1 = 1;
                                              final_pet = newValue;
                                            });
                                            setState(() => _pet = newValue);
                                          },
                                          //value: _pet,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text('Proceed',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: Colors.blueGrey[600],
                                        onPressed: () async {
                                          await print(
                                              "The pet and service are ");
                                          await print(final_pet);
                                          await print(final_serv);
                                          await prefs.setString("selected_pets",
                                              strPet + "," + final_pet);
                                          await print(strPet + "," + final_pet);
                                          await prefs.setString(
                                              "selected_services",
                                              strServ + "," + final_serv);
                                          await print(
                                              strServ + "," + final_serv);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => SSC()),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
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
