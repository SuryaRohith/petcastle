//this is vendor homepage . here the vendors bookings will appear . he can accept/deny here .
//modification:done
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/selectedservicecards.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petcastle/VendorPages/VendorServiceCard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

//var jsonArr;
Map servPrice;
SharedPreferences prefs;
String result = "yes";
String service_type;
String strServ = "";
String strPrice = "";
String strPet = "";
String strDate = "";
var jsonArr = new List();
var jsonStr;
var tempstr;
//var result;
int x;
List<String> services = new List<String>();
List<String> pets = new List<String>();
List<String> prices = new List<String>(); //SharedPreferences prefs;
String _service = "";
String _pet = " ";
int x1 = 0;
String Email;
String Vendor_Email;
class Booking {
 String  Booking_id;
  String Owner_id;
  String Vendor_id;
  String Service_id;
 String  Pet_id;
  String Booking_status;
  String Booking_totalprice;
  String Booking_timestamp;
  String Booking_text;
  String Owner_email;
  String Vendor_email;
  Booking(){
    this.Booking_id = Booking_id;
    this.Owner_id  = Owner_id;
    this.Owner_email = Owner_email;
    this.Vendor_id = Vendor_id;
    this.Vendor_email = Vendor_email;
    this.Service_id = Service_id;
    this.Pet_id = Pet_id;
    this.Booking_status = Booking_status;
    this.Booking_totalprice = Booking_totalprice;
    this.Booking_timestamp = Booking_timestamp;
    this.Booking_text = Booking_text;
  }
 Map<String, dynamic> toJson() {
   return <String, dynamic>{
     'Vendor_email': Vendor_email,
     'Vendor_id': Vendor_id,
     'Service_id': Service_id,
     'Pet_id' : Pet_id,
     'Booking_id': Booking_id,
     'Booking_totalprice': Booking_totalprice,
     'Booking_timestamp' : Booking_timestamp,
     'Booking_text' : Booking_text,
     'Booking_status' : Booking_status,
   };
 }
 Booking.fromJson(Map<String, dynamic> json)
     : Vendor_email = json['Vendor_email'],
        Owner_email = json['Owner_email'],
        Owner_id = json['Owner_id'],
        Vendor_id = json['Vendor_id'],
 Service_id  = json ['Service_id'],
 Pet_id = json['Pet_id'],
 Booking_id = json['Booking_id'],
 Booking_totalprice = json['Booking_totalprice'],
 Booking_timestamp = json['Booking_timestamp'],
 Booking_status = json['Booking_status'],
 Booking_text = json['Booking_text'];


}
List<Booking> DartArr2 = new List<Booking>();
Future<void> _postData() async{
  print("post id starts");
  Vendor_Email = await prefs.getString("vendor_login_email");
  await print(Vendor_Email);

  var body = Vendor_Email;
  var url = Uri.parse("http://192.168.0.9:8090/DispReq");
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


class VendorBookings extends StatefulWidget {
  @override
  _VendorBookingsState createState() => _VendorBookingsState();
}

class _VendorBookingsState extends State<VendorBookings> {


  bool accepted = true;
  bool rejected = true;

  _accepted() {
    setState(() {
      accepted = null;
      rejected = true;
    });
    return accepted;
  }

  _rejected() {
    setState(() {
      accepted = null;
      rejected = null;
    });

    //return rejected;
  }
  @override
  void initState() {
    super.initState();
    //initiatePreferences();
  }

  Future<void> initiatePreferences() async {
    prefs = await SharedPreferences.getInstance();
    print("entered preferenes");
    await DartArr2.clear();

    Email = await prefs.getString("username");
    await _postData();
    return;
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final h = data.size.height;
    final w = data.size.width;
    return Scaffold(
        body: FutureBuilder(
            future: initiatePreferences(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (jsonArr == null) {
                x = 0;
                print(DartArr2);
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
                  Booking b2 = Booking.fromJson(jsonArr[i]);
                  DartArr2.add(b2);
                }
                for (int j = 0; j < DartArr2.length; j++) {
                  print(DartArr2[j].Service_id);
                }
                print(DartArr2);
                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: h * 0.05),
                          child: Text(
                            'My booking requests',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[600],
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Container(
                          width: w * 0.9,
                          child: ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: DartArr2.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    elevation: 10,
                                    color: Colors.blueGrey[100],
                                    shadowColor: Colors.blueGrey[600],
                                    child: Container(
                                      width: w * 0.9,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(w * 0.02),
                                            child: FlatButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) => AlertDialog(
                                                          title:
                                                              Text('Details'),
                                                          content: Container(
                                                            height: h * 0.3,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(
                                                                          'Phone :'),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(
                                                                          DartArr2[index].Owner_email),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(
                                                                          'Email :'),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(
                                                                          DartArr2[index].Owner_email),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(
                                                                          'Pet Type :'),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(
                                                                          'Dog'),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(
                                                                          'Pet Name:'),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(
                                                                          DartArr2[index].Pet_id),
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ));
                                              },
                                              textColor: Colors.blueGrey[600],
                                              child:  Text(DartArr2[index].Owner_email,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      decoration: TextDecoration
                                                          .underline)),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: w * 0.4,
                                                child: Text('Service Type',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .blueGrey[600])),
                                              ),
                                              Container(
                                                width: w * 0.4,
                                                child: Text(DartArr2[index].Service_id,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .blueGrey[600])),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: w * 0.4,
                                                child: Text('Date&Time',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .blueGrey[600])),
                                              ),
                                              Container(
                                                width: w * 0.4,
                                                child: Text(DartArr2[index].Booking_timestamp,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .blueGrey[600])),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: w * 0.4,
                                                child: Text('Addt. Info.',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .blueGrey[600])),
                                              ),
                                              Container(
                                                width: w * 0.4,
                                                child: Text(DartArr2[index].Pet_id,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .blueGrey[600])),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: w * 0.4,
                                                child: Text('Payment Status',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .blueGrey[600])),
                                              ),
                                              Container(
                                                width: w * 0.4,
                                                child: Text('Paid',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .blueGrey[600])),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                RaisedButton(
                                                  onPressed: () async {

                                                    //  setState(()  {
                                                    //
                                                    //    _accepted();
                                                    //
                                                    //  // DartArr2.removeAt(index);
                                                    //
                                                    //   //Navigator.of(context).pop();
                                                    // });


                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (_) => AlertDialog(
                                                                  title: Text(
                                                                      'Accepted, thank you!'),
                                                                  content:
                                                                      Container(
                                                                    height: 130,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              'To deny this request,go to Profile>Upcoming Bookings>status \n Note: This has to be done prior to 24 hrs of the service. ',
                                                                              style: TextStyle(fontSize: 12),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ));
                                                    return await null;
                                                    },
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  textColor: Colors.white,
                                                  color: Colors.blueGrey[600],
                                                  child: const Text('Accept',
                                                      style: TextStyle(
                                                          fontSize: 12)),
                                                ),
                                                RaisedButton(
                                                  onPressed: () {
                                                    _rejected();
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (_) => AlertDialog(
                                                                  title: Text(
                                                                      'Denied!'),
                                                                  content:
                                                                      Container(
                                                                    height: h *
                                                                        0.25,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text(
                                                                              'If by any chance, you want to accept this request later please go to Profile>Upcoming Bookings>status \n Note: This has to be done prior to 24 hrs of the service. ',
                                                                              style: TextStyle(fontSize: 12),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ));
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  disabledColor: Colors.black,
                                                  disabledTextColor:
                                                      Colors.white,
                                                  textColor: Colors.white,
                                                  color: Colors.blueGrey[600],
                                                  child: const Text('Deny',
                                                      style: TextStyle(
                                                          fontSize: 12)),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}
