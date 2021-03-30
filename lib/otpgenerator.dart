//verify otp page
//works after emailverify
//to be done
import 'dart:async';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:petcastle/Login/ChangePassword.dart';
import 'package:petcastle/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('flutter_devs');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);


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
  Future onSelectNotification(String payload) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return vOTP();
    }));
  }
  showNotification() async {
    var android = AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.High, importance: Importance.Max);
    var iOS = IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Flutter devs', 'Flutter Local Notification Demo', platform,
        payload: 'Welcome to the Local Notification demo');
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
