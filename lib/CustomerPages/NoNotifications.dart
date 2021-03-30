// when there are no notifcations
//havent linked this to anything as of now because i have linked the notifications containing page
import 'package:flutter/material.dart';

class NoNotif extends StatefulWidget {
  @override
  _NoNotifState createState() => _NoNotifState();
}

class _NoNotifState extends State<NoNotif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
          backgroundColor: Colors.blueGrey[600],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('assets/images/notification.webp',
                  width: 100, height: 100, fit: BoxFit.contain),
            ),
            Text('You have no notifications'),
          ],
        ));
  }
}
