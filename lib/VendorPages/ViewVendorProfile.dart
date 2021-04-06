import 'package:flutter/material.dart';

class VVP extends StatefulWidget {
  @override
  _VVPState createState() => _VVPState();
}

class _VVPState extends State<VVP> {
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final h = data.size.height;
    final w = data.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendors Profile'),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: w * 0.8,
              height: h * 0.4,
              child: Text("Dissplay vendors special details here"),
            ),
            Container(
              alignment: Alignment.center,
              width: w * 0.8,
              height: h * 0.4,
              child: Image.asset('assets/images/dogpeek.png'),
            ),
          ],
        ),
      ),
    );
  }
}
