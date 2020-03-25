import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  int _counter = 0;
  /*
  AdmobInterstitial interstitialAd = AdmobInterstitial(
    adUnitId: getInterstitialAdUnitId(),
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    interstitialAd.load();
  }
  */

  AdmobBannerSize bannerSize;
  AdmobInterstitial interstitialAd;
  AdmobReward rewardAd;

  @override
  void initState() {
    super.initState();
    bannerSize = AdmobBannerSize.BANNER;

    interstitialAd = AdmobInterstitial(
      adUnitId: getInterstitialAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );

    rewardAd = AdmobReward(
        adUnitId: getRewardBasedVideoAdUnitId(),
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          if (event == AdmobAdEvent.closed) rewardAd.load();
        });

    interstitialAd.load();
    rewardAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              setState(() {
                _counter += 1;
              });
            },
            child: Text(
              'Counter $_counter',
            ),
          ),
          RaisedButton(
            child: Text(
              'Intersticial',
            ),
            onPressed: () async {
              if (await interstitialAd.isLoaded && _counter >= 3) {
                interstitialAd.show();
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
          AdmobBanner(
            adUnitId: getBannerAdUnitId(),
            adSize: AdmobBannerSize.FULL_BANNER,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    rewardAd.dispose();
    _counter = 0;
    super.dispose();
  }
}
