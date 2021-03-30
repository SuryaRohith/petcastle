//This is the page for the Profile icon from the bottom navigation bar , after the user is logged in .
// This contains Profile, History and Upcoming bookings Buttons
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/AddMorePet.dart';
import 'package:petcastle/CustomerPages/AddPet.dart';

import 'package:petcastle/CustomerPages/MyProfile.dart';
import 'package:petcastle/CustomerPages/Notifications.dart';
import 'package:petcastle/main.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:petcastle/CustomerPages/History.dart';
import 'package:petcastle/CustomerPages/UpcomingBookings.dart';

class CL extends StatefulWidget {
  @override
  _CLState createState() => _CLState();
}

class _CLState extends State<CL> {
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF546E7A),
          title: const Text('Pet Castle'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications_active_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notif()),
                );
              },
            ),
            IconButton(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              icon: const Icon(Icons.logout),
              onPressed: () async {
                prefs = await SharedPreferences.getInstance();
                prefs.remove('username');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyStatefulWidget()),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Column(
              children: [
                Container(
                  height: 300,
                  child: ListView(
                    children: ListTile.divideTiles(context: context, tiles: [
                      ListTile(
                        title: Text('Profile'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddMorePet(),
                            ),
                          );
                        },
                        leading: Icon(Icons.person),
                      ),
                      ListTile(
                        title: Text('History'),
                        leading: Icon(Icons.history),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => History()),
                          );
                        },
                      ),
                      ListTile(
                        title: Text('Upcoming bookings'),
                        leading: Icon(Icons.favorite),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UB()),
                          );
                        },
                      ),
                      ListTile(
                        title: Text('Home'),
                        leading: Icon(Icons.home),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyStatefulWidget()),
                          );
                        },
                      ),
                    ]).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
