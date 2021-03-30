import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/selectedservicecards.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petcastle/VendorPages/VendorServiceCard.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';
import 'package:petcastle/CustomerPages/Bill.dart';
import 'package:petcastle/CustomerPages/AddService.dart';
import 'dart:async';
var jsonArr;
Map servPrice ;
SharedPreferences prefs;
String result = "yes";
String service_type;
String strServ = "";
String strPrice ="";
String strPet = "";
String strDate = "";

List<String> actservices = new List<String>();
List<String> services = new List<String>();
List<String> pets = new List<String>();
List<String>  prices  = new List<String>();//SharedPreferences prefs;
String _service = "";
String _pet = " ";
int x1=0;
String Email;
String Vendor_Email;
class Books{
  String Vendor_email;
  String Price;
  String Owner_email;
  String Pet_name;
  String Services;

  Books(){
    this.Vendor_email = Vendor_email;
    this.Price = Price;
    this.Owner_email = Owner_email;
    this.Pet_name = Pet_name;
    this.Services =Services;

  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Vendor_email':Vendor_email,
      'Service_Price': Price,
      'Service_name': Services,
      'Pet_name': Pet_name,
      'Owner_email': Owner_email,
    };
  }

  Books.fromJson(Map<String, dynamic> json)
      :
        Vendor_email = json['Vendor_email'],
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


class SSC extends StatefulWidget {
  @override
  _SSCState createState() => _SSCState();
}

class _SSCState extends State<SSC> {
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
  void initState() {
    super.initState();
    initiatePreferences();
  }


  Future<void> initiatePreferences() async {
    prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    await print("entered preferenes");
    //await DartArr.clear();
    Email = await prefs.getString("username");
    Vendor_Email = await prefs.getString("vendor_email");
    strServ = await prefs.getString("selected_services");
    strPet = await prefs.getString("selected_pets");
    strDate = await prefs.getString("date");
    await print("the str serv is ");
    await print(strServ);
    await print(strPet);
    await print(strDate);
    services = await strServ.split(",");
    await services.removeAt(0);
    await print(services);
    pets =  await strPet.split(",");
    await pets.removeAt(0);
    for(int i=0;i<services.length;i++)
    {
      if(servPet.containsKey(services[i])){
        var x = servPet[services[i]];
        x = x + "," + pets[i];
        servPet.update(services[i], (value) => x);
      }
      else{
        servPet.addAll({services[i] : pets[i]});
      }
    }
    // dates =  await strDate.split(",");
    //await dates.removeAt(0);
    //await print(dates);
    await print(pets);
    await print("done with post");



    //await _postData();
    //await print(jsonArr);
    //Books b1 =new Books.fromJson(jsonArr);
    //await print(b1.Vendor_email);
    //await print(b1.Services);
    //services = await b1.Services.split(",");
    //pets = await b1.Pet_name.split(",");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Service'),
        backgroundColor: Colors.blueGrey[600],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddService()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: initiatePreferences(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            //print(DartArr);
            if (services.length == 0 ) {
              x = 0;
              //print(DartArr);
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
            if (services.length > 0) {
              x = services.length;
              print(" the length of servies array is ");
              print(x);

              return SingleChildScrollView(
                child: Column(

                    children:<Widget>[
                      ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: services.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Center(
                              child: new Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical: 28.0),
                                      child: Column(
                                        children: [
                                          //for (int i = 0; i < x; i++)
                                          Padding(
                                            // ignore: missing_return, missing_return
                                            child: new Card(
                                              elevation: 10,
                                              color: Colors.blueGrey[100],
                                              child: Container(
                                                width: 350,
                                                height: 30,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 0,
                                                          horizontal: 20),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text(
                                                              (services[index])
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight.bold),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text(
                                                              pets[index].toString(),
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
                                            padding: const EdgeInsets.all(8.0),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          }),
                      RaisedButton(
                        onPressed: () async {
                          await
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Bill()),
                          );
                        },
                        textColor: Colors.white,
                        color: Colors.blueGrey[600],
                        padding: const EdgeInsets.all(10.0),
                        child: const Text('Proceed',
                            style: TextStyle(fontSize: 15)),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets
                                .all(8.0),
                            child: Text(
                                'Choose a date =>'),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons
                                    .calendar_today),
                                onPressed:
                                    () async {

                                  await _selectDate(
                                      context);
                                  await prefs.setString("date",("${selectedDate.toLocal()}"
                                      .split(' ')[0] ).toString());
                                },
                                color: Colors
                                    .blueGrey[
                                600],
                              ),
                              Text(
                                "${selectedDate.toLocal()}"
                                    .split(
                                    ' ')[0],
                                style:
                                TextStyle(
                                  fontSize: 15,
                                  color: Colors
                                      .blueGrey[
                                  600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),]
                ),
              );
            }
          }),
    );
  }
}
