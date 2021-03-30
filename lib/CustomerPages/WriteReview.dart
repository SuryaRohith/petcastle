//not yet done
import 'package:flutter/material.dart';

class WriteReview extends StatefulWidget {
  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Feedback'),
          backgroundColor: Colors.blueGrey[600],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Please write about the service you had availed '),
          ],
        ));
  }
}
