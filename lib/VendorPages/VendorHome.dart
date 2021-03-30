//this is vendor main app whch contains bottom nav bar . no other functionality is here.the class name is Mystatefulwidget2 ... remember .
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/MyProfile.dart';
import 'package:petcastle/VendorPages/VendorAnalytics.dart';
import 'package:petcastle/VendorPages/VendorBookings.dart';
import 'package:petcastle/VendorPages/VendorProfile.dart';
import 'package:petcastle/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyStatefulWidget2 extends StatefulWidget {
  MyStatefulWidget2({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState2 createState() => _MyStatefulWidgetState2();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState2 extends State<MyStatefulWidget2> {
  SharedPreferences prefs;

  int _currentIndex = 0;
  final _pageOptions = [VendorBookings(), VendorProfile(), VendorAnalytics()];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF546E7A),
        title: const Text('Pet Castle'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_active_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    prefs = await SharedPreferences.getInstance();
                    prefs.remove('username');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyStatefulWidget()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: _pageOptions[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(Icons.analytics_outlined), label: 'Analytics'),
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
