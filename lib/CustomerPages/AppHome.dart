// This is the Home page for the customer .
//modification:done

//This contains a carousel and the categories of services for the customer.
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:petcastle/CustomerPages/MyDoctor(withfuture).dart';

import 'package:petcastle/Login/LogInScreen.dart';
import 'package:petcastle/Login/LogInScreenV.dart';
import 'package:petcastle/Login/SignUpScreenV.dart';
import 'package:petcastle/Login/SignUpScreen.dart';

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  List<String> onlyImages = [
    "assets/images/doctor1.jpg",
    "assets/images/trainer1.jpg",
    "assets/images/hostel1.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    return new Scaffold(
        body: SingleChildScrollView(
      child: new Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    initialPage: 0,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                  items: onlyImages
                      .map((item) => Container(
                            child: Image.asset(
                              item,
                              fit: BoxFit.cover,
                              width: data.size.width,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: SingleChildScrollView(
                child: Container(
                  //  color: Colors.pink,
                  height: data.size.height * 1,
                  width: data.size.width * 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Card(
                                color: Colors.lightBlue[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: data.size.height * 0.03,
                                  width: data.size.width * 0.8,
                                  child: Text(
                                    'Please select the required service',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Card(
                                  color: Colors.purple[50],
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: data.size.height * 0.04,
                                    width: data.size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: data.size.width * 0.5,
                                          child: Text(
                                            'Do you provide Pet Services? ',
                                            style: TextStyle(
                                              fontSize: data.size.width * 0.028,
                                              color: Colors.purple[900],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: data.size.width * 0.4,
                                          child: TextButton(
                                            child: Text(
                                              'Click here to login',
                                              style: TextStyle(
                                                color: Colors.purple[900],
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VLogIn()),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  height: data.size.height * 0.18,
                                  width: data.size.width * 0.9,
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey[50],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    data.size.width * 0.03),
                                            child: CircleAvatar(
                                              radius: data.size.width * 0.18,
                                              backgroundImage: AssetImage(
                                                  'assets/images/doctor2.jpg'),
                                            ),
                                          ),
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: new Border.all(
                                              color: Colors.blueGrey[300],
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: data.size.width * 0.4,
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyDoctor()),
                                              );
                                            },
                                            child: const Text('Pet Doctor',
                                                style: TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey[50],
                                      borderRadius: BorderRadius.circular(20)),
                                  height: data.size.height * 0.18,
                                  width: data.size.width * 0.9,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: data.size.width * 0.4,
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyDoctor()),
                                              );
                                            },
                                            child: const Text('Pet Trainer',
                                                style: TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    data.size.width * 0.03),
                                            child: CircleAvatar(
                                              radius: data.size.width * 0.18,
                                              backgroundImage: AssetImage(
                                                  'assets/images/trainer3.png'),
                                            ),
                                          ),
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: new Border.all(
                                              color: Colors.blueGrey[300],
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey[50],
                                      borderRadius: BorderRadius.circular(20)),
                                  height: data.size.height * 0.18,
                                  width: data.size.width * 0.9,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    data.size.width * 0.03),
                                            child: CircleAvatar(
                                              radius: data.size.width * 0.18,
                                              backgroundImage: AssetImage(
                                                  'assets/images/groomer2.jpg'),
                                            ),
                                          ),
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: new Border.all(
                                              color: Colors.blueGrey[300],
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: data.size.width * 0.4,
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyDoctor()),
                                              );
                                            },
                                            child: const Text('Pet Grooomer',
                                                style: TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey[50],
                                      borderRadius: BorderRadius.circular(20)),
                                  height: data.size.height * 0.18,
                                  width: data.size.width * 0.9,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: data.size.width * 0.4,
                                          // color: Colors.yellow,
                                          child: FlatButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyDoctor()),
                                              );
                                            },
                                            child: const Text('Pet Hostel',
                                                style: TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    data.size.width * 0.03),
                                            child: CircleAvatar(
                                              radius: data.size.width * 0.18,
                                              backgroundImage: AssetImage(
                                                  'assets/images/hostel3.jpg'),
                                            ),
                                          ),
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: new Border.all(
                                              color: Colors.blueGrey[300],
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
