//modification :done
//after selecting services and proceeding , this bill will appear
//this is displayed when user clicks on proceed button in selectedservicecards.dart
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/UPIMethod.dart';

import 'package:petcastle/CustomerPages/selectedservicecards.dart';
import 'package:petcastle/CustomerPages/AddService.dart';
import 'package:petcastle/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

SharedPreferences prefs;
String result;
String Email;
String Vendor_email;
Map servPet = {};
Map servPrice = {};
String date;
String strServ;
String strPet;
List<String> services = new List<String>();
List<String> actual_services = new List<String>();
List<String> prices = prices;
List<String> pets = new List<String>();
List<String> dates = new List<String>();

class Billing {
  String Email;
  String Vendor_email;
  String Booking_date;
  String Service_name;
  String Pet_name;
  String Total_price;
  String Date;
  Billing() {
    this.Email = Email;
    this.Vendor_email = Vendor_email;
    this.Booking_date = Booking_date;
    this.Service_name = Service_name;
    this.Pet_name = Pet_name;
    this.Total_price = Total_price;
    this.Date = Date;
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Vendor_email': Vendor_email,
      'Service_name': Service_name,
      'Total_price': Total_price,
      'Pet_name': Pet_name,
      'Owner_email': Email,
      'Date': Date,
    };
  }

  Billing.fromJson(Map<String, dynamic> json)
      : Vendor_email = json['Vendor_email'],
        Email = json['Owner_email'],
        Pet_name = json['Pet_name'],
        Total_price = json['Total_price'],
        Service_name = json['Service_name'],
        Date = json['Date'];
}

Billing b1 = new Billing();
Future<void> _postData() async {
  var body = b1;
  b1.Vendor_email = await prefs.getString("vendor_login_email");
  var url = Uri.parse("http://192.168.0.9:8090/AddBooking");
  await http.post(url, body: json.encode(body)).then((http.Response response) {
    if (response.statusCode == 200) {
      print("----------------------------------------------------------");
      print(" the response " + response.body);
      result = response.body;
      //jsonArr = json.decode(result);
      //print(jsonArr);
      //jsonArr = json.decode(result);

      print("post id done");
      return;
    }
  });
}

class Bill extends StatefulWidget {
  @override
  _BillState createState() => _BillState();
}

class _BillState extends State<Bill> {

  @override
  void initState() {
    super.initState();
    // initiatePreferences();
  }

  Future<void> initiatePreferences() async {
    prefs = await SharedPreferences.getInstance();
    //await Future.delayed(const Duration(seconds: ));


    b1.Email = await prefs.getString("username");
    b1.Vendor_email = await prefs.getString("vendor_email");

    b1.Date = prefs.getString("date");

    //int total_price = await 0;
    await print(
        "entering the post -------------------------------------------------");
    date = await prefs.getString("date");

    strServ = await prefs.getString("selected_services");
    b1.Service_name = await strServ;

    await print("the slected servo ");
    await print(strServ);

    services = await strServ.split(",");
    await print("before split");
    var total_price = 0;
    await print(services);
    await services.removeAt(0);
    var x = await prefs.getString("prices");
    prices = await x.split(",");
    await print(prices);
    await prices.removeAt(0);
    //await print()
    await print(prices);
    var y = await prefs.getString("actual_services");
    strPet = await prefs.getString("selected_pets");
    b1.Pet_name = strPet;
    pets = await strPet.split(",");
    actservices = await y.split(",");
    await actservices.removeAt(0);
    await print(actservices);
    var z = await prefs.getString("selected_services");
    //await services.removeAt(0);
    await pets.removeAt(0);
    for (int i = 0; i < actservices.length; i++) {
      servPrice.addAll({actservices[i]: prices[i]});
    }
    // for (int l=0;l<services.length;l++)
    //   {
    //     servPet.addAll({services[l] : pets[l]});
    //   }
    String z1 = "";
    await print("The services are");
    await print(services);
    await print("The pets are");
    await print(pets);
    for (var l in actservices) {
      servPet.addAll({l: ""});
    }
    //print(servPet);
    //z1= "";
    for (int p = 0; p < services.length; p++) {
      z1 = await servPet[services[p]];
      z1 =await  z1 + "," + pets[p];
      await servPet.update(services[p], (value) => z1);
      z1 = "";
    }
    await print("the serv pet is ");
    await print(servPet);
    //var pets_count = .toSet().toList();
    await print(servPet);
    await print(servPrice);
    for (var x in actservices) {
      if(servPet[x] != "") {
        var z1 = await servPet[x].split(",");
        await z1.removeAt(0);
        await print("the z1 is");
        await print(z1);
        await print("the service is ");
        await print(x);


        var petcount = (z1.toSet().toList()).length;
        print(petcount);
        //print(servPrice[x]);
        total_price = total_price + int.parse(servPrice[x]) * petcount;
        print(servPrice[x]);
        print(total_price);
      }
    }
    b1.Total_price = total_price.toString();
    total_price = 0;

    await print(servPrice);
    // await prefs.setString("selected_services", "");
    // await prefs.setString("selected_pets", "");
    await print(servPet);
    for (int k = 0; k < actservices.length; k++) {
      var temp = servPet[actservices[k]];
      var temp2 = await temp.split(",");
      await print(temp2.length);
      temp2.removeAt(0);
      total_price =
          await total_price + (int.parse(prices[k])) * ((temp2.length));
      await print(total_price);
    }
    await print(
        "done -------------------------------------------------------------------------------");
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final h = data.size.height;
    final w = data.size.width;
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyStatefulWidget()),
                );
              },
            ),
          ],
          title: Text('Your Bill'),
          backgroundColor: Colors.blueGrey[600],
        ),
        body: SingleChildScrollView(
          child: Center(
              child: FutureBuilder(
                  future: initiatePreferences(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              children: [
                                new Card(
                                  elevation: 10,
                                  color: Colors.blueGrey[100],
                                  child: Container(
                                    width: w * 0.8,
                                    height: 50,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Service',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Pet',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Date',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Price',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold),
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
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: services.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return new Card(
                                        elevation: 10,
                                        child: Container(
                                          width: w * 0.8,
                                          height: 50,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 0),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                      child:
                                                      Text(services[index]),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                      child: Text(pets[index]),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                      child: Text(b1.Date),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                      child: Text(servPrice[
                                                      services[index]]),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Container(
                                    width: w * 0.8,
                                    child: RaisedButton(
                                      onPressed: () {},
                                      color: Colors.blueGrey[600],
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Total',
                                            style:
                                            TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            b1.Total_price,
                                            style:
                                            TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: h * 0.05),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      await _postData();
                                      await prefs.setString("selected_services", "");
                                      await prefs.setString("selected_pets", "");
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: Text(
                                                'Your Booking has been Confirmed . Thank you !'),
                                            content: Container(
                                              height: 15,
                                            ),
                                          ));
                                    },
                                    textColor: Colors.white,
                                    color: Colors.blueGrey[600],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    padding: const EdgeInsets.all(10.0),
                                    child: const Text(
                                      'Pay by cash',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UPIMethod()),
                                      );
                                    },
                                    textColor: Colors.white,
                                    color: Colors.blueGrey[600],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    padding: const EdgeInsets.all(10.0),
                                    child: const Text(
                                      'Pay using  UPI',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  })),
        ));
  }
}
