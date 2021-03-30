//to choose upi methods like paytm , googlepay etc .
import 'package:flutter/material.dart';
import 'package:petcastle/main.dart';

class UPIMethod extends StatefulWidget {
  @override
  _UPIMethodState createState() => _UPIMethodState();
}

class _UPIMethodState extends State<UPIMethod> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyStatefulWidget()),
              );
            },
          ),
        ],
        title: Text("UPI Methods"),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text(
                                'Your Booking has been Confirmed . Thank you !'),
                            content: Container(
                              height: 15,
                            ),
                          ));
                },
                child: Image.asset('assets/images/paytm.png',
                    width: 100, height: 100, fit: BoxFit.contain),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text(
                                'Your Booking has been Confirmed . Thank you !'),
                            content: Container(
                              height: 15,
                            ),
                          ));
                },
                child: Image.asset('assets/images/phonepe-logo.png',
                    width: 100, height: 100, fit: BoxFit.contain),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text(
                                'Your Booking has been Confirmed . Thank you !'),
                            content: Container(
                              height: 15,
                            ),
                          ));
                },
                child: Image.asset('assets/images/bhim-app.png',
                    width: 100, height: 100, fit: BoxFit.contain),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text(
                                'Your Booking has been Confirmed . Thank you !'),
                            content: Container(
                              height: 15,
                            ),
                          ));
                },
                child: Image.asset('assets/images/google-pay.png',
                    width: 100, height: 100, fit: BoxFit.contain),
              ),
            ],
          ),
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
