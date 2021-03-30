//Contains vendor profile , services, history, upcoming bookings ,when profile from bottom nav bar is clicked , after vendor logs in
import 'package:flutter/material.dart';
import 'package:petcastle/VendorPages/VendorHistory.dart';
import 'package:petcastle/VendorPages/VendorMyProfile.dart';
import 'package:petcastle/VendorPages/VendorServiceCard.dart';

import 'package:petcastle/VendorPages/VendorUpcomingBookings.dart';

class VendorProfile extends StatefulWidget {
  @override
  _VendorProfileState createState() => _VendorProfileState();
}

class _VendorProfileState extends State<VendorProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 130.0),
            child: ListView(
              children: ListTile.divideTiles(context: context, tiles: [
                ListTile(
                  title: Text('Profile'),
                  leading: Icon(Icons.person),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VendorMyProfile(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text('Services'),
                  leading: Icon(Icons.auto_fix_high),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VSC()),
                    );
                  },
                ),
                ListTile(
                  title: Text('History'),
                  leading: Icon(Icons.history),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VHistory()),
                    );
                  },
                ),
                ListTile(
                  title: Text('Upcoming bookings'),
                  leading: Icon(Icons.favorite),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VUB()),
                    );
                  },
                ),
              ]).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
