// This is the list of cards containing Clinics for the service Pet DOctors
// THis contains a sort button , a fliter by button and a list of cards
//mofication:done

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:petcastle/CustomerPages/selectedservicecards.dart';
import 'package:petcastle/CustomerPages/SelectedService.dart';
import 'package:petcastle/CustomerPages/SortBy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';

// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEna
SharedPreferences prefs;
String Email;
var jsonArr = new List();
var jsonStr;
var tempstr;
var result;
int x;
Map<String, dynamic> decoded;

//VService v1 = new VService();
//var VserArr = new List<SerList>();

class SerList {
  String Vendor_email;
  String Vendor_name;
  String Service_name;
  String Service_reviews;
  String Service_ratings;
  SerList() {
    this.Vendor_email = Vendor_email;
    this.Vendor_name = Vendor_name;
    this.Service_name = Service_name;
    this.Service_reviews = Service_reviews;
    this.Service_ratings = Service_ratings;
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Vendor_email': Vendor_email,
      'Vendor_name': Vendor_name,
      'Service_name': Service_name,
      'Service_reviews': Service_reviews,
      'Service_stars': Service_ratings,
    };
  }

  SerList.fromJson(Map<String, dynamic> json)
      : Vendor_email = json['Vendor_email'],
        Vendor_name = json['Vendor_name'],
        Service_name = json['Service_name'],
        Service_reviews = json['Service_reviews'],
        Service_ratings = json['Service_ratings'];
}

List<SerList> DartArr = new List<SerList>();
Future<List<String>> _postData() async {
  print("post id starts");
  Email = await prefs.getString("username");
  var body = Email;
  var url = Uri.parse("http://192.168.0.9:8090/dispdoc");
  //final response = await http.Client().post("http://192.168.0.9:8080/login",body: json.encode("hello"));
  await http.post(url, body: json.encode(body)).then((http.Response response) {
    if (response.statusCode == 200) {
      print("----------------------------------------------------------");
      print(" The response is " + response.body);
      result = response.body;

      jsonArr = json.decode(result);
      print("the json array");
      print(jsonArr);
    }
  });
  return jsonArr;
}

class MyDoctor extends StatefulWidget {
  @override
  _State createState() => new _State();
}

//State is information of the application that can change over time or when some actions are taken.
class _State extends State<MyDoctor> {
  int x = 4;
  int y = 5;
  @override
  void initState() {
    super.initState();
    //initiatePreferences();
  }

  Future<void> initiatePreferences() async {
    prefs = await SharedPreferences.getInstance();
    print("entered preferenes");
    await DartArr.clear();

    Email = await prefs.getString("username");
    await _postData();
    return;
  }

  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Pet clinics '),
          backgroundColor: Colors.blueGrey[600],
        ),
        //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: initiatePreferences(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                print(DartArr);
                if (jsonArr == null) {
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
                if (jsonArr != null) {
                  x = jsonArr.length;
                  print(" the length of json array is ");
                  print(x);
                  for (int i = 0; i < jsonArr.length; i++) {
                    SerList v1 = SerList.fromJson(jsonArr[i]);
                    DartArr.add(v1);
                  }
                  for (int j = 0; j < DartArr.length; j++) {
                    print(DartArr[j].Service_name);
                  }
                  print(DartArr);
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          //color: Colors.pink,
                          height: data.size.height * 0.08,
                          width: data.size.width * 0.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SortBy()));
                                },
                                textColor: Colors.white,
                                color: Colors.blueGrey[600],
                                padding: const EdgeInsets.all(8.0),
                                child: const Text('Sortby',
                                    style: TextStyle(fontSize: 10)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SortBy()));
                                },
                                textColor: Colors.white,
                                color: Colors.blueGrey[600],
                                padding: const EdgeInsets.all(8.0),
                                child: const Text('Filterby',
                                    style: TextStyle(fontSize: 10)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: DartArr.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              //color: Color(0XFFfaebf8),
                              padding: new EdgeInsets.symmetric(vertical: 12.0),
                              child: new Center(
                                child: new Column(
                                  children: <Widget>[
                                    new Card(
                                      //color: Color(0XFFfaebf8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      elevation: 10,
                                      shadowColor: Colors.blueGrey[300],
                                      child: new Container(
                                        //color: Colors.pink,
                                        height: 150,
                                        width: data.size.width * 0.9,
                                        padding: new EdgeInsets.all(8.0),
                                        child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'assets/images/doctor3.jpeg',
                                              //height: 300,
                                              width: data.size.width * 0.4,
                                            ),
                                            Container(
                                              // color: Colors.pink,
                                              width: data.size.width * 0.4,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    //color: Colors.blue,
                                                    height: 30,
                                                    width:
                                                        data.size.width * 0.4,
                                                    child: TextButton(
                                                      //color: Colors.amber,
                                                      child: Text(
                                                          DartArr[index].Vendor_email,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                      .blueGrey[
                                                                  600])),
                                                      onPressed: () async {
                                                        await prefs.setString("vendor_email", DartArr[index].Vendor_email);
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SelectedService()),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Container(
                                                    //color: Colors.blueGrey,
                                                    // height: 20,
                                                    width:
                                                        data.size.width * 0.4,
                                                    alignment:
                                                        Alignment.centerRight,
                                                    //color: Colors.blue[100],
                                                    child: Row(
                                                      children: <Widget>[
                                                        for (int i = 0;
                                                            i < y;
                                                            i++)
                                                          Icon(Icons.star,
                                                              color: Colors
                                                                  .yellow[700],
                                                              size: data.size
                                                                      .width *
                                                                  0.05),
                                                        for (int j = 0;
                                                            j < 5 - y;
                                                            j++)
                                                          Icon(
                                                              Icons
                                                                  .star_border_purple500_outlined,
                                                              size: data.size
                                                                      .width *
                                                                  0.05),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        data.size.width * 0.4,
                                                    //color: Colors.pink[100],
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.pin_drop,
                                                            size: data.size
                                                                    .width *
                                                                0.04,
                                                            color: Colors
                                                                .blueGrey[600],
                                                          ),
                                                          Text(
                                                              'RR Nagar,Bangalore',
                                                              style: TextStyle(
                                                                  fontSize: data
                                                                          .size
                                                                          .width *
                                                                      0.025,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                          .blueGrey[
                                                                      600])),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        data.size.width * 0.4,
                                                    //  color: Colors.purple,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                          child: Text('Vaccine',
                                                              style:
                                                                  TextStyle()),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3.0),
                                                          child: Text('Checkup',
                                                              style:
                                                                  TextStyle()),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
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
                      ],
                    ),
                  );
                }
              }),
        ));
  }
}
