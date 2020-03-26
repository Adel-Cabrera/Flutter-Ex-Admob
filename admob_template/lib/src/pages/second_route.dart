import 'package:admob_flutter/admob_flutter.dart';
import 'package:admobtemplate/src/admob/admob_config.dart';
import 'package:admobtemplate/src/pages/home_page.dart';
import 'package:flutter/material.dart';

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  int counter = 0;
  AdmobInterstitial interstitialAd = HomePage.interstitialAd;
  AdmobReward rewardAd = HomePage.rewardAd;
  String getBanner = HomePage.getBannerId;
  AdmobBannerSize bannerSize = HomePage.bannerSize;
  Map<String, dynamic> rewardCallback = HomePage
      .rewardCallback; // rewardCallback['type'] - rewardCallback['amount']

  @override
  void initState() {
    super.initState();

    interstitialAd.load();
    rewardAd.load();
  }

  @override
  Widget build(BuildContext context) {
    AdmobBanner myBanner = AdmobBanner(
      adUnitId: getBannerAdUnitId(),
      adSize: bannerSize,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          RaisedButton(
            child: Text('Counter $counter'),
            onPressed: () {
              counter++;
            },
          ),
          RaisedButton(
            child: Text(
              'Intersticial',
            ),
            onPressed: () async {
              if (await interstitialAd.isLoaded && counter >= 3) {
                Future.delayed(const Duration(milliseconds: 2500), () {
                  interstitialAd.show();
                });
                setState(() {
                  counter = 0;
                });
              }
            },
          ),
          RaisedButton(
            child: Text(
              'Rewarded',
            ),
            onPressed: () async {
              if (await rewardAd.isLoaded) {
                rewardAd.show();
              }
            },
          ),
          Center(
            child: myBanner,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    rewardAd.dispose();
    super.dispose();
  }
}
