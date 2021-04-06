import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/MyDoctor(withfuture).dart';
//import 'package:petcastle/CustomerPages/MyDoctorFilter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:petcastle/main.dart';

SharedPreferences prefs;
String Email;
var resultfil;
String s = "";
var jsonArr = new List();

class FilterList {
  String Vendor_email;
  String Vendor_name;
  String Service_name;
  String Vendor_location;
  String Service_type;
  String Service_price;
  FilterList() {
    this.Vendor_email = Vendor_email;
    this.Vendor_name = Vendor_name;
    this.Service_name = Service_name;
    this.Vendor_location = Vendor_location;
    this.Service_type = Service_type;
    this.Service_price = Service_price;
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Vendor_email': Vendor_email,
      'Vendor_name': Vendor_name,
      'Service_name': Service_name,
      'Vendor_location': Vendor_location,
      'Vendor_service_type': Service_type,
      'Service_Price': Service_price,
    };
  }

  FilterList.fromJson(Map<String, dynamic> json)
      : Vendor_email = json['Vendor_email'],
        Vendor_name = json['Vendor_name'],
        Service_name = json['Service_name'],
        Vendor_location = json['Vendor_location'],
        Service_type= json['Vendor_service_type'],
        Service_price= json['Service_Price'];
}

FilterList f = new FilterList();
List<FilterList> DartArrF = new List<FilterList>();


Future<void> _postData() async {
  print("post id starts");
  Email = await prefs.getString("username");
  var body = f;
  var url = Uri.parse("http://192.168.1.7:8090/filter");
  //final response = await http.Client().post("http://192.168.0.9:8080/login",body: json.encode("hello"));
  await http.post(url, body: json.encode(body)).then((http.Response response) {
    if (response.statusCode == 200) {
      print("----------------------FILTER------------------------------------");
      print(" The response is " + response.body);
      resultfil = response.body;

      jsonArr = json.decode(resultfil);
      print("the json array");
      print(jsonArr);
    }
  });
  return jsonArr;
}



class Filters extends StatefulWidget {
  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  String _rating;
  String _arealoc;
  String _area;
  var _controller = ScrollController();
  void initState() {
    super.initState();
    initiatePreferences();
  }
  Future<void> initiatePreferences() async {

    prefs = await SharedPreferences.getInstance();
    Email = await prefs.getString("username");
    //await _postData();
  }

  Map<String, bool> service_type = {
    'Checkup': true,
    'Haircut': false,
    'Vaccination': false,
    'Hostels': false,
    'others': false,
  };
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 1, //
      ),
    );
  }

  RangeValues _currentRangeValues = const RangeValues(80, 500);
  bool value = false;
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final h = data.size.height;
    final w = data.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: RawScrollbar(
        thumbColor: Colors.blueGrey[200],
        radius: Radius.circular(50),
        thickness: 6,
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                children: [
                  //price range
                  Container(
                    margin:
                    EdgeInsets.symmetric(vertical: 8, horizontal: w * 0.03),
                    padding: EdgeInsets.all(w * 0.025),
                    decoration: myBoxDecoration(), //
                    child: Column(
                      children: [
                        Container(
                            width: w * 0.9,
                            alignment: Alignment.center,
                            child: Text(
                              "Selected Price Range",
                              style: TextStyle(fontSize: 15),
                            )),
                        Container(
                          width: w * 0.9,
                          alignment: Alignment.center,
                          child: Text(
                            "Rs" +
                                _currentRangeValues.start.round().toString() +
                                "-" +
                                "Rs" +
                                _currentRangeValues.end.round().toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          width: w * 0.9,
                          child: RangeSlider(
                            activeColor: Colors.pink[200],
                            values: _currentRangeValues,
                            min: 10,
                            max: 1000,
                            divisions: 10,
                            labels: RangeLabels(
                              _currentRangeValues.start.round().toString(),
                              _currentRangeValues.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentRangeValues = values;
                                String p = _currentRangeValues.start.round().toString()+","+_currentRangeValues.end.round().toString();
                                f.Service_price = p;
                                print("Service Price");
                                print(f.Service_price );
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  //price range-end

                  //city
                  Container(
                    margin:
                    EdgeInsets.symmetric(vertical: 8, horizontal: w * 0.03),
                    padding: EdgeInsets.all(w * 0.025),
                    decoration: myBoxDecoration(), //
                    child: Column(
                      children: [
                        Text("Area of city"),
                        DropdownButton<String>(
                          focusColor: Colors.white,
                          value: _arealoc,
                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.black,
                          items: <String>[
                            'Bangalore',
                            'Hyderabad',
                            'Chennai',
                            ' Delhi',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "Choose city",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _arealoc = value;
                              f.Vendor_location = _arealoc.toString();
                              print("Vendor Location");
                              print(f.Vendor_location);
                            });
                          },
                        ),
                      ],
                    ),
                  ), //area-end
                  //city-end
                  //service
                  Container(
                    margin:
                    EdgeInsets.symmetric(vertical: 8, horizontal: w * 0.03),
                    padding: EdgeInsets.all(w * 0.025),
                    decoration: myBoxDecoration(), //
                    child: Column(
                      children: [
                        Text("Type of Service"),
                        Container(
                          height: h * 0.2,
                          width: w * 0.8,
                          child: Scrollbar(
                            controller: _controller,
                            isAlwaysShown: true,
                            child: ListView(
                              children: service_type.keys.map((String key) {
                                return new CheckboxListTile(
                                  checkColor: Colors.blueGrey[600],
                                  selectedTileColor: Colors.yellow,
                                  title: new Text(key),
                                  value: service_type[key],
                                  onChanged: (bool value) {
                                    setState(() {
                                      service_type[key] = value;
                                      int i;
                                      //String s="";
                                      //   service_type.values.toString();
                                      for(i=0;i<5;i++) {
                                        if (service_type.values.elementAt(i) == true) {
                                          if(s==""){
                                            s=s+service_type.keys.elementAt(i);
                                          }
                                          else {
                                            s = s + "," +
                                                service_type.keys.elementAt(i);
                                          }
                                        }
                                      }
                                      // String key = values.keys.elementAt(index);
                                      // print(service_type.values.elementAt(0));
                                      // print(service_type.values.elementAt(4));
                                      f.Service_name = s;
                                      print("Service Name");
                                      print( f.Service_name);



                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //service-end
                  //area
                  Container(
                    margin:
                    EdgeInsets.symmetric(vertical: 8, horizontal: w * 0.03),
                    padding: EdgeInsets.all(w * 0.025),
                    decoration: myBoxDecoration(), //
                    child: Column(
                      children: [
                        Text("Area of residence (dropdown)"),
                        DropdownButton<String>(
                          focusColor: Colors.white,
                          value: _area,
                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.black,
                          items: <String>[
                            'Area 1',
                            'Area 2',
                            'Area 3',
                            ' Area 4',
                            'Area 5',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "Choose location",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _area = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ), //area-end
                  //rating
                  Container(
                    margin:
                    EdgeInsets.symmetric(vertical: 8, horizontal: w * 0.03),
                    padding: EdgeInsets.all(w * 0.025),
                    decoration: myBoxDecoration(), //
                    child: Column(
                      children: [
                        Text("Rating of clinic (dropdown)"),
                        DropdownButton<String>(
                          focusColor: Colors.white,
                          value: _rating,
                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.black,
                          items: <String>[
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "Rating",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _rating = value;

                            });
                          },
                        ),
                        RaisedButton(
                          onPressed: () async {
                            await _postData();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyDoctorFilter()));
                          },
                          textColor: Colors.white,
                          color: Colors.blueGrey[600],
                          padding: const EdgeInsets.all(8.0),
                          child: const Text('Apply',
                              style: TextStyle(fontSize: 10)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ],

                    ),
                  ),

                  //rating -end
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
