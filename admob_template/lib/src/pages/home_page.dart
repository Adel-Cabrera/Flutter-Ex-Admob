import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Home Page'),
          onPressed: () {
            Navigator.pushNamed(context, '/anotherPage');
          },
        ),
      ),
    );
  }
}
