//sign up for vendor
//modification:done
import 'package:flutter/material.dart';
import 'package:petcastle/Login/EmailVerifyV.dart';
import 'package:petcastle/Login/EmailVerifyV.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petcastle/Login/LogInScreenV.dart';
import 'package:petcastle/Login/SignUpScreenV.dart';
//import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String result;
SharedPreferences prefs;

class SignupV {
  String Name;
  String Email;
  String Password;
  String Phno;
  String Location;
  String License;
  String Status;
  String Service_type;
  String Clinicname;
  String Device;
  SignupV() {
    this.Name = Name;
    this.Email = Email;
    this.Password = Password;
    this.Phno = Phno;
    this.Location = Location;
    this.License = License;
    this.Status = Status;
    this.Service_type = Service_type;
    this.Device = Device;
    this.Clinicname = Clinicname;
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Vendor_name': Name,
      'Vendor_email': Email,
      'Vendor_password': Password,
      'Vendor_phno': Phno,
      'Vendor_device': Device,
      'Vendor_location': Location,
      'Vendor_status': Status,
      'Vendor_license': License,
      'Vendor_service_type': Service_type,
      'Vendor_clinic_name': Clinicname
    };
  }

  SignupV.fromJson(Map<String, dynamic> json)
      : Name = json['Vendor_name'],
        Email = json['Vendor_email'],
        Password = json['Vendor_password'],
        Phno = json['Vendor_phno'],
        Device = json['Vendor_device'],
        Location = json['Vendor_Location'],
        Service_type = json['Vendor_service_type'],
        License = json['Vendor_license'],
        Clinicname = json['Vendor_clinic_name'],
        Status = json['Vendor_Status'];
}

SignupV s1 = new SignupV();
int test = 0;

Future<void> _postData() async {
  print("post id starts");
  //var cookie;

  //var body = {"Email": "saima@goodgirl ", "Password": "makeup"};
  s1.Device = "samsung";
  // s1.Location = "banglore";
  s1.Status = "active";
  // print("hi");
  //
  //print(s1);
  // var conv = s1.toJson();
  //var x  = s1.toJson();

  //var body2 = jsonEncode(s1);
  print(s1);
  print("=-------------------------------------------------------");
  print("values");
  print(s1.Name);
  print(s1.Password);
  //print(s1.Email);
  //print(s1.Password);
  //var tosend = s1.toJson();
  var body = jsonEncode(s1);
  var url = Uri.parse("http://192.168.0.9:8090/signupvendor");
  print(s1.Location);
  print(s1.Service_type);
  //final response = await http.Client().post("http://192.168.0.9:8080/getur2",body: json.encode("hello"));
  await http.post(url, body: body).then((http.Response response) {
    if (response.statusCode == 200) {
      result = response.body;
      print("post id done");
      return;
    }
  });
}

class SignUpScreenV extends StatefulWidget {
  SignUpScreenV({Key key}) : super(key: key);

  @override
  _SignUpScreenVState createState() => _SignUpScreenVState();
}

class _SignUpScreenVState extends State<SignUpScreenV> {
  final _formKey = GlobalKey<FormState>();
  void _submit() async {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      test = 1;
      //await _postData();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => LogIn()),
      // );
    }
    _formKey.currentState.save();
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  TextEditingController clinicController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController address2Controller  = TextEditingController();
  TextEditingController pinController = TextEditingController();
  bool _obscureText = false;
  SharedPreferences prefs;
  var categories = [
    "Doctor",
    "Trainer",
    "Groomer",
    "Hostel",
  ];
  var _category = "Doctor";

  var cities = [
    "Bangalore",
    "Hyderabad",
    "Chennai",
  ];
  var _city = "Bangalore";

  @override
  void initState() {
    super.initState();
    saveDetails();
  }

  void saveDetails() async {
    prefs = await SharedPreferences.getInstance();
    //prefs.setString('username', username);
    //prefs.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final h = data.size.height;
    final w = data.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up as a vendor'),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: w * 0.08),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    TextFormField(
                        controller: fullNameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length < 5) {
                            return 'Name should be greater than 5 characters';
                          }
                          return null;
                        },
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.person_pin_outlined),
                            hintText: "Enter your full name")),
                    TextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length != 10) {
                            return 'Phone number should be 10 digits only';
                          }
                          return null;
                        },
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: "Enter your phone number")),
                    TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                          final regExp = RegExp(pattern);

                          if (!regExp.hasMatch(value)) {
                            return 'Please enter valid email';
                          } else if (value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length < 5) {
                            return 'Email should be greater than 5 characters';
                          }
                          s1.Email = value;
                          return null;
                        },
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: "Enter your email address")),
                    TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length < 8) {
                            return 'Password should be greater than 8 characters';
                          } else if (value != confirmPasswordController.text) {
                            return 'Password and confirm password are not same';
                          }
                          return null;
                        },
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: "Enter your password")),
                    TextFormField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter password';
                        } else if (value.length < 8) {
                          return 'Password should be greater than 8 characters';
                        } else if (value != passwordController.text) {
                          return 'Password and confirm password are not same';
                        }
                        return null;
                      },
                      obscureText: _obscureText,
                      decoration: new InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Confirm your Password"),
                    ),
                    TextFormField(
                      controller: licenseController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter license number';
                        }

                        return null;
                      },
                      obscureText: _obscureText,
                      decoration: new InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key_outlined),
                          hintText: "Enter license number"),
                    ),
                    TextFormField(
                      controller: clinicController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your clinic name';
                        }

                        return null;
                      },
                      obscureText: _obscureText,
                      decoration: new InputDecoration(
                          prefixIcon: Icon(Icons.home_work_outlined),
                          hintText: "Enter your clinic name "),
                    ),
                    DropdownButtonFormField(
                      items: categories.map((String category) {
                        return new DropdownMenuItem(
                            value: category,
                            child: Row(
                              children: <Widget>[
                                Text(category),
                              ],
                            ));
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with _category
                        setState(() => _category = newValue);
                      },
                      value: _category,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                        prefixIcon: Icon(Icons.miscellaneous_services),
                        hintText: "Choose category",
                      ),
                    ),
                    DropdownButtonFormField(
                      items: cities.map((String city) {
                        return new DropdownMenuItem(
                            value: city,
                            child: Row(
                              children: <Widget>[
                                Text(city),
                              ],
                            ));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() => _city = newValue);
                      },
                      value: _city,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                        prefixIcon: Icon(Icons.location_on_outlined),
                        hintText: "Choose city",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: w * 0.1),
                      child: Container(
                          width: w * 0.8,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Address :",
                            style: TextStyle(
                                color: Colors.blueGrey[600],
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Container(
                      width: w * 0.6,
                      child: TextFormField(
                        controller: addressController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter an address';
                          }
                          return null;
                        },
                        obscureText: _obscureText,
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.location_city),
                            hintText: "Address line1"),
                      ),
                    ),
                    Container(
                      width: w * 0.6,
                      child: TextFormField(
                        controller: address2Controller,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter an address';
                          }
                          return null;
                        },
                        obscureText: _obscureText,
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.location_city),
                            hintText: "Address line 2"),
                      ),
                    ),
                    Container(
                      width: w * 0.6,
                      child: TextFormField(
                        controller: pinController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter an address';
                          }
                          return null;
                        },
                        obscureText: _obscureText,
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.nature_outlined),
                            hintText: "Pincode"),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: w * 0.3,
                      padding: EdgeInsets.only(top: 20),
                      child: RaisedButton(
                        onPressed: () async {
                          s1.Name = fullNameController.text.toString();
                          s1.Phno = phoneNumberController.text.toString();
                          s1.Email = emailController.text.toString();
                          s1.License = licenseController.text.toString();
                          s1.Password = passwordController.text.toString();
                          s1.Clinicname = clinicController.text.toString();
                          s1.Service_type = _category;
                          s1.Location = _city;
                          await _submit();
                          if (test == 1) {
                            await _postData();

                            print("entered post");
                            // _getData();
                            // print("entered get ");
                            if (result == "yes") {
                              //prefs.setString(
                                  //"service_type", s1.Service_type.toString());
                              //l//1.Email = usernameController.text;
                              //l1.Password = passwordController.text;
                              bool userFound = true;

                              if (userFound) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EmailV()),
                                );
                              }
                            }
                            if (test == 1) {
                              if (result == "no") {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                        size: 50,
                                      ),
                                      content: Text(
                                          "Already Exists so get out and login people like you should learn to see the entire screen"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Ok"))
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          }
                        },
                        color: Colors.blueGrey[600],
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: w * 0.8,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VLogIn()),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              'Already have an account ?',
                              style: TextStyle(
                                color: Colors.blueGrey[600],
                              ),
                            ),
                            Text("Login",
                                style: TextStyle(
                                  color: Colors.pink[900],
                                  decoration: TextDecoration.underline,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
