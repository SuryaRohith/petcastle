//verify otp page
//works after emailverify
//to be done
import 'package:flutter/material.dart';
import 'package:petcastle/Login/ChangePassword.dart';
import 'package:petcastle/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class vOTP extends StatefulWidget {
  @override
  _vOTPState createState() => _vOTPState();
}

class _vOTPState extends State<vOTP> {
  String finalGeneratedOTP;
  String finalEnteredOTP;
  Future verifyOTP() async {
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var enteredOTP = prefs.getString('enteredotp');
    var generatedOTP = prefs.getString('generatedotp');
    setState(() {
      finalGeneratedOTP = generatedOTP;
      finalEnteredOTP = enteredOTP;
    });
    print(finalGeneratedOTP);
    print(finalEnteredOTP);
  }

  SharedPreferences prefs;

  TextEditingController otpController = TextEditingController();
  @override
  void initState() {
    verifyOTP().whenComplete(() async {
      if (finalGeneratedOTP == finalEnteredOTP) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangePassword(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyStatefulWidget(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pet castle"),
          backgroundColor: Colors.blueGrey[600],
        ),
        body: Center(child: Text("hello")));
  }
}
