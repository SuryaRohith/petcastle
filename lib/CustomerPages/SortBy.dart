//This page is opened when the customer clicks on the sort by button from the MyDoctor.dart page
import 'package:flutter/material.dart';

class SortBy extends StatefulWidget {
  @override
  _SortByState createState() => _SortByState();
}

class _SortByState extends State<SortBy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sort by"),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: Center(
        child: Text('Yet to be done'),
      ),
    );
  }
}
