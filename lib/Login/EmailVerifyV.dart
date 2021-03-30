//forgot password from login
//bugs are there , commented those , willl work
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/AppHome.dart';
import 'package:petcastle/Login/ChangePassword.dart';
import 'package:petcastle/Login/SignUpScreen.dart';
import 'package:petcastle/Login/verifyotp.dart';
import 'package:petcastle/VendorPages/VendorHome.dart';
import 'package:petcastle/main.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class EmailV extends StatefulWidget {
  @override
  _EmailVState createState() => _EmailVState();
}

class _EmailVState extends State<EmailV> {
  SharedPreferences prefs;

  //SharedPreferences prefs;


  TextEditingController otpController = TextEditingController();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    //prefs = SharedPreferences.getInstance();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOs);

    var x =flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    print(x);
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }
  showNotification() async {
    prefs = await SharedPreferences.getInstance();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOs);

    var x =flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    var rndnumber="";
    var rnd= new Random();
    for (var i = 0; i < 4; i++) {
      rndnumber = await rndnumber + rnd.nextInt(9).toString();
    }
    // var initializationSettingsAndroid =
    // new AndroidInitializationSettings('@mipmap/ic_launcher');
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        "1", 'channel1', 'notificationsender',
        playSound: false, importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'OTP',
      rndnumber,
          platformChannelSpecifics,
      payload: 'No_Sound',
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pet castle"),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      'OTP VERIFICATION',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[600]),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          'We have sent the OTP to your email , please enter it below '),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: PinEntryTextField(
                      showFieldAsBox: true,
                      onSubmit: (String pin) async {
                        print('this is entered otp $pin');

                        prefs.setString('enteredotp', pin.toString());
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => vOTP()));
                      }, // end onSubmit
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: RaisedButton(
                      child: Text('Continue'),
                      textColor: Colors.white,
                      color: Colors.blueGrey[600],
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyStatefulWidget2()));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FlatButton(
                      child: Text('Resend OTP'),
                      onPressed: () async {
                        await showNotification();

                      },
                    ),
                  ),
                ],
              ), // end PinEntryTextField()
            ), // end Padding()
          ),
        ),
      ),
    );
  }
}
