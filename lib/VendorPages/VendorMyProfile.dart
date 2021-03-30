//on clicking profile from profile icon , this page is opened .This contains vendor profile , his details and his clinic details etc .
//yet to be done
import 'package:petcastle/VendorPages/VendorEditProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class VendorMyProfile extends StatefulWidget {
  VendorMyProfile({Key key}) : super(key: key);

  @override
  _VendorMyProfileState createState() => _VendorMyProfileState();
}

class _VendorMyProfileState extends State<VendorMyProfile> {
  SharedPreferences prefs;
  final _formKey = GlobalKey<FormState>();
  TextEditingController infoController = TextEditingController();
  String finalClinic;
  String finalEmail;
  String finalPhone;
  String finalName;
  String finalLicense;
  String finalCity;
  String finalCategory;
  Future customerData() async {
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var vendEmail = prefs.getString('vendoremail');
    var vendPhone = prefs.getString('vendorphone');
    var vendName = prefs.getString('vendorname');
    var vendLicense = prefs.getString('vendorlicense');
    var vendCity = prefs.getString('vendorcity') ?? "Not printing yet";
    var vendCategory = prefs.getString('vendorcategory') ?? "Not printing yet";
    var vendClinic = prefs.getString('vendorclinic');
    setState(() {
      finalEmail = vendEmail;
      finalName = vendName;
      finalPhone = vendPhone;
      finalLicense = vendLicense;
      finalCity = vendCity;
      finalCategory = vendCategory;
      finalClinic = vendClinic;
    });
    print(finalCategory);
    print(finalEmail);
    print(finalCity);
  }

  @override
  void initState() {
    customerData().whenComplete(() async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF546E7A),
        title: Text('My Profile', style: TextStyle(fontSize: 15)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Card(
              elevation: 10,
              color: Colors.blueGrey[100],
              child: Container(
                width: 380,
                height: 250,
                //child: Row(
                //children: [
                // Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Name =>  '),
                          Text(
                            finalName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Phone no. =>  '),
                          Text(
                            finalPhone,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Email =>  '),
                          Text(
                            finalEmail,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('License no. =>  '),
                          Text(
                            finalLicense,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Category =>  '),
                          Text(
                            finalCategory,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('City =>  '),
                          Text(
                            finalCity,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Center Name =>  '),
                          Text(
                            finalClinic,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //),
                //],
                // ),
              ),
            ),
          ),
          FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VendorEditProfile()),
                );
              },
              child: Text(
                'Edit',
                style: TextStyle(decoration: TextDecoration.underline),
              )),
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Any additional info about your services ? "),
                  ),
                  Container(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: infoController,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                          hintText: ("Type here.."),
                        ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text('Add'),
                    color: Colors.blueGrey[600],
                    textColor: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
