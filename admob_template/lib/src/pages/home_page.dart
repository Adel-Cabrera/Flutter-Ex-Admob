import 'package:admob_flutter/admob_flutter.dart';
import 'package:admobtemplate/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  static int counter = 0;
  static AdmobInterstitial interstitialAd = AdmobInterstitial(
    adUnitId: getInterstitialAdUnitId(),
    listener: (AdmobAdEvent event, Map<String, dynamic> args) {
      if (event == AdmobAdEvent.closed) interstitialAd.load();
    },
  );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdmobBannerSize bannerSize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bannerSize = AdmobBannerSize.BANNER;
  }

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
              adUnitId: getBannerAdUnitId(),
              adSize: AdmobBannerSize.BANNER,
            ),
          ],
        ),
      ),
    );
  }
}
