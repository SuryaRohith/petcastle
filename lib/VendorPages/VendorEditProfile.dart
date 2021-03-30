//editing his profile

//not done
//this is dummy
//dont touch it will become a mess
//just kidding
//oh no i am not
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class VendorEditProfile extends StatefulWidget {
  VendorEditProfile({Key key}) : super(key: key);

  @override
  _VendorEditProfileState createState() => _VendorEditProfileState();
}

class _VendorEditProfileState extends State<VendorEditProfile> {
  SharedPreferences prefs;
  bool _obscureText = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController categoryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController clinicController = TextEditingController();
  String finalClinic;
  String finalEmail;
  String finalPhone;
  String finalName;

  String finalCity;
  String finalCategory;
  Future customerData() async {
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var vendEmail = prefs.getString('vendoremail');
    var vendPhone = prefs.getString('vendorphone');
    var vendName = prefs.getString('vendorname');

    var vendCity = prefs.getString('vendorcity') ?? "Not printing yet";
    var vendCategory = prefs.getString('vendorcategory') ?? "Not printing yet";
    var vendClinic = prefs.getString('vendorclinic');
    setState(() {
      finalEmail = vendEmail;
      finalName = vendName;
      finalPhone = vendPhone;

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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  obscureText: _obscureText,
                  decoration: new InputDecoration(hintText: finalName),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                  obscureText: _obscureText,
                  decoration: new InputDecoration(hintText: finalPhone),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  obscureText: _obscureText,
                  decoration: new InputDecoration(hintText: finalEmail),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: categoryController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please select  category';
                    }
                    return null;
                  },
                  obscureText: _obscureText,
                  decoration: new InputDecoration(hintText: finalCategory),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: cityController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please select city';
                    }
                    return null;
                  },
                  obscureText: _obscureText,
                  decoration: new InputDecoration(hintText: finalCity),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: clinicController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter clinic / center name';
                    }
                    return null;
                  },
                  obscureText: _obscureText,
                  decoration: new InputDecoration(hintText: finalClinic),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
