//when user clicks on notification icon from the app bar this is gonna display
//changes are to be done in designing of cards
import 'package:flutter/material.dart';

class Notif extends StatefulWidget {
  @override
  _NotifState createState() => new _NotifState();
}

class _NotifState extends State<Notif> {
  int y = 2;
  int x = 1;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('My Notifications'),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: SingleChildScrollView(
        child: new Container(
          padding: new EdgeInsets.all(1.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                //new card begins here
                for (int j = 0; j < y; j++)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Card(
                      elevation: 10,
                      child: Container(
                        height: 100,
                        child: Row(
                          children: [
                            Icon(Icons.celebration),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                width: 300,
                                child: Text(
                                    'Yay! Checkup for Bruno from ABC Clinic dated 21-02-2021 is confirmed'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                for (int i = 0; i < x; i++)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Card(
                      elevation: 10,
                      child: Container(
                        height: 100,
                        child: Row(
                          children: [
                            Icon(Icons.do_not_disturb_alt),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                width: 300,
                                child: Text(
                                    'Sorry!Check up for Bruno from ABC Clinic on 21-02-2021 15:30 hrs has been cancelled'
                                    'If you have made the payment it will reflect back into your account in 3-7 business days '),
                              ),
                            )
                          ],
                        ),
                      ),
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
