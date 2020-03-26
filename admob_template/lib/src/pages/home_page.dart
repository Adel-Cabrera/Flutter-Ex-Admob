import 'package:admob_flutter/admob_flutter.dart';
import 'package:admobtemplate/src/pages/params.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            RaisedButton(
              child: Text('Home Page'),
              onPressed: () {
                Navigator.pushNamed(context, '/anotherPage');
              },
            ),
            AdmobBanner(
              adUnitId: Params.getBannerAdUnitId(),
              adSize: Params.bannerSize,
            ),
          ],
        ),
      ),
    );
  }
}
