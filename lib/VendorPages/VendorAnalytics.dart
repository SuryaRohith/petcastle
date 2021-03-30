//when vendor clicks on my analytics from bottom nav bar , he lands up on this page . this has three drop downs for timeframe,category and service
import 'package:flutter/material.dart';

class VendorAnalytics extends StatefulWidget {
  @override
  _VendorAnalyticsState createState() => _VendorAnalyticsState();
}

class _VendorAnalyticsState extends State<VendorAnalytics> {
  List<String> timeframes = ['Weekly', 'Monthly', 'Yearly'];
  List<String> weeks = ['Week1', 'Week2', 'Week3', 'Week4'];
  List<String> years = ['2021'];
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  List<String> dropdowns = [];
  String selectedtimeframe;
  String selectedcategory;
  String selectedservice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          // Country Dropdown
          DropdownButton<String>(
            hint: Text('TimeFrame'),
            value: selectedtimeframe,
            isExpanded: true,
            items: timeframes.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (drop) {
              if (drop == 'Monthly') {
                dropdowns = months;
              } else if (drop == 'Weekly') {
                dropdowns = weeks;
              } else if (drop == 'Yearly') {
                dropdowns = years;
              } else {
                dropdowns = [];
              }
              setState(() {
                selectedcategory = null;
                selectedtimeframe = drop;
              });
            },
          ),
          // Country Dropdown Ends here

          // Province Dropdown
          DropdownButton<String>(
            hint: Text('category'),
            value: selectedcategory,
            isExpanded: true,
            items: dropdowns.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (cat) {
              setState(() {
                selectedcategory = cat;
              });
            },
          ),
          // Province Dropdown Ends here
          DropdownButton<String>(
            hint: Text('service'),
            value: selectedservice,
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                selectedservice = newValue;
              });
            },
            items: <String>['All', 'Check up', 'Vaccine', 'Others']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
