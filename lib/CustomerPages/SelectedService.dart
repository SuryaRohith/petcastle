//when user selects a particular clinic or center the details of the services price etsc will be displayed with a +icon to procced to selcting a service
// this will services and prices
//modification:done
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/AddService.dart';
import 'package:petcastle/CustomerPages/AppHome.dart';
import 'package:petcastle/CustomerPages/Book.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

String result;
//SharedPreferences prefs;
var jsonArr2;
Map servPrice = {};
SharedPreferences prefs;
//String result = "yes";
String service_type;
String strServ = "";
String strPrice = "";
String strPet = "";
String strDate = "";

List<String> services = new List<String>();
List<String> pets = new List<String>();
List<String> prices = new List<String>(); //SharedPreferences prefs;

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
      //'Pet_name': Pet_name,
      'Owner_email': Owner_email,
    };
  }

  Books.fromJson(Map<String, dynamic> json)
      : Vendor_email = json['Vendor_email'],
        Owner_email = json['Owner_email'],
        //Pet_name = json['Pet_name'],
        Price = json['Service_price'],
        Services = json['Service_name'];
}

Books b1 = new Books();
List<Books> DartArr = new List<Books>();
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
      jsonArr2 = json.decode(result);
      print(jsonArr2);
      //jsonArr = json.decode(result);

      print("post id done");
      return;
    }
  });
}

class SelectedService extends StatefulWidget {
  @override
  _SelectedServiceState createState() => _SelectedServiceState();
}

class _SelectedServiceState extends State<SelectedService> {
  int x = 2;

  DateTime selectedDate = DateTime.now();

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

  String dropdownValue = 'Checkup';
  String dropdownValue2 = 'Bruno';
  bool valuefirst = false;
  bool valuesecond = false;
  bool value = false;
  @override
  void initState() {
    super.initState();
    //initiatePreferences();
  }

  Future<void> initiatePreferences() async {
    prefs = await SharedPreferences.getInstance();
    Email = await prefs.getString("username");
    Vendor_Email = await prefs.getString("vendor_email");
    await _postData();
    Books b1 = await new Books.fromJson(jsonArr2);


    prices = await b1.Price.split(",");
    await print("The prices are ");

    // print("entered preferenes");
    // await DartArr.clear();
    // Email = await prefs.getString("username");
    // Vendor_Email = await prefs.get("vendor_email");
    // await _postData();
    // //await print(jsonArr);
    // await services.clear();
    // Books b1 = new Books.fromJson(jsonArr);
    // strServ = await prefs.getString("selected_services")??"";
    // await strServ.trim();
    //
    // strPet = await prefs.getString("selected_pets")??"";
    // await strPet.trim();
    // strDate = await prefs.getString("date")??"";
    // await strDate.trim();
    // await print(b1.Vendor_email);
    // await print(b1.Services);
    // await prefs.setString("prices", b1.Price);
    // await prefs.setString("actual_services", b1.Services);
    // await prefs.setString("actual_pets", b1.Pet_name);
    // services = await b1.Services.split(",");
    // services.removeAt(0);
    // //_service = services[0];
    // pets = await b1.Pet_name.split(",");
    // pets.removeAt(0);
    // prices = await b1.Price.split(",");
    // await print(prices);
    services = await b1.Services.split(",");
    services.removeAt(0);
    await print("the services are ");
    await print(services);

    await prices.removeAt(0);
    await print(prices);
    Map serVPrice = new Map();
    for (int i = 0; i < services.length; i++) {
      await servPrice.addAll({services[i]: prices[i]});
    }
    await print(servPrice);

    //_pet = pets[0];

    // print("entered preferenes");
    // await DartArr.clear();
    // Email = await prefs.getString("username");
    // Vendor_Email = await prefs.get("vendor_email");
    // await _postData();
    // Books b1 =new Books.fromJson(jsonArr[0]);
    // await print(b1.Vendor_email);
    // await print(b1.Services);
    // services = await b1.Services.split(",");
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final h = data.size.height;
    final w = data.size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Select services'),
          backgroundColor: Colors.blueGrey[600],
        ),
        body: FutureBuilder(
            future: initiatePreferences(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(snapshot.data);
              print(DartArr);
              if (services == null) {
                x = 0;
                print(DartArr);
                return Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: Colors.blueGrey)),
                  child: IconButton(
                    icon: Icon(
                      Icons.rotate_right,
                    ),
                    color: Colors.green,
                    onPressed: () {},
                  ),
                );
              }
              if (services != null) {
                x = services.length;
                // print(" the length of json array is ");
                // print(x);
                // for (int i = 0; i < jsonArr.length; i++) {
                //   SerList v1 = SerList.fromJson(jsonArr[i]);
                //   DartArr.add(v1);
                // }
                // for (int j = 0; j < DartArr.length; j++) {
                //   print(DartArr[j].Service_name);
                // }
                print(DartArr);
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            color: Colors.pink[50],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            elevation: 5,
                            child: Container(
                              width: w * 0.6,
                              height: h * 0.08,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                                title: Text('Contact info'),
                                                content: Container(
                                                  height: 130,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            ' Flat 102,\nElegant elite,\nBeside Global Village Tech Park,\nBangalore- 560059\n+91 8987678954\nabcpetclinic@gmail.com',
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ));
                                    },
                                    child: Text(
                                      Vendor_Email,
                                      style: TextStyle(
                                        fontSize: w * 0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey[600],
                                      ),
                                    ),
                                    /* Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.location_on_outlined),
                                Container(
                                  width: w * 0.6,
                                  height: h * 0.15,
                                  child: Text(
                                      'Flat 102,\nElegant elite,\nBeside Global Village Tech Park,\nBangalore- 560059\n+91 8987678954\nabcpetclinic@gmail.com'),
                                ),
                              ],
                            ),*/
                                  )
                                ],
                              ),
                            )),
                      ),
                      Card(
                        elevation: 10,
                        color: Colors.blueGrey[100],
                        child: Container(
                          alignment: Alignment.center,
                          width: w * 0.8,
                          height: 50,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      width: w * 0.3,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Service name',
                                        style: TextStyle(fontSize: w * 0.048),
                                      ),
                                    ),
                                    Container(
                                      width: w * 0.3,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Price',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: w * 0.05),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: services.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              elevation: 5,
                              child: Container(
                                // color: Colors.pink,
                                height: 50,
                                width: data.size.width * 0.8,
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: w * 0.3,
                                          alignment: Alignment.centerRight,
                                          //color: Colors.pink,
                                          child: Text(
                                            services[index],
                                            style:
                                                TextStyle(fontSize: w * 0.04),
                                          ),
                                        ),
                                        Container(
                                          width: w * 0.3,
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            servPrice[services[index]],
                                            textAlign: TextAlign.right,
                                            style:
                                                TextStyle(fontSize: w * 0.04),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 2, color: Colors.blueGrey[600])),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                ),
                                color: Colors.brown[600],
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Book()),
                                  );
                                },
                              ),
                            ),
                            Text('Tap the + to book a service',
                                style: TextStyle(
                                    color: Colors.blueGrey[600],
                                    decoration: TextDecoration.underline)),
                          ],
                        ),
                      ),
                      Container(
                        width: w * 0.3,
                        height: h * 0.06,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AppHome()),
                            );
                          },
                          textColor: Colors.white,
                          color: Colors.blueGrey[600],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            'View Reviews',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}
