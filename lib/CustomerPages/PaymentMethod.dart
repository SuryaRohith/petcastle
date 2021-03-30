//payments page . this contains pay by cash / pay by upi . this redirects to pay by upi

import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/UPIMethod.dart';
import 'package:petcastle/main.dart';

class PaymentMethod extends StatefulWidget {
  PaymentMethod({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
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
        title: Text("Payment "),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: Center(
        child: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: (RaisedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Booking Confirmed . Thank you !'),
                              content: Container(
                                height: 130,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Please complete the payment at the service center ',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                  },
                  textColor: Colors.white,
                  color: Colors.blueGrey[600],
                  padding: const EdgeInsets.all(10.0),
                  child:
                      const Text('Pay By Cash', style: TextStyle(fontSize: 15)),
                )),
              ),
              Container(
                child: (RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UPIMethod()),
                    );
                  },
                  textColor: Colors.white,
                  color: Colors.blueGrey[600],
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Pay using UPI',
                      style: TextStyle(fontSize: 15)),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
