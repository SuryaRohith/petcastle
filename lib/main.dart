//thi is from where the app runs
//this just has a bottom nav bar
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:petcastle/CustomerPages/AfterLogin.dart';
import 'package:petcastle/CustomerPages/AppHome.dart';

import 'package:petcastle/CustomerPages/MyProfile.dart';

import 'package:petcastle/CustomerPages/Notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: MyStatefulWidget(),
    );
  }
}

bool pressed = false;

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _currentIndex = 0;
  final _pageOptions = [AppHome(), AfterLogin()];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF546E7A),
        automaticallyImplyLeading: false,
        title: const Text('Pet Castle'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.notifications_active_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notif()),
                );
              },
            ),
          ),
        ],
      ),
      body: _pageOptions[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          selectedItemColor: Colors.blueGrey[600],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}
