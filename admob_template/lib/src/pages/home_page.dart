import 'package:admob_flutter/admob_flutter.dart';
import 'package:admobtemplate/src/admob/admob_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  static int counter;
  static AdmobInterstitial interstitialAd;
  static AdmobReward rewardAd;
  static AdmobBannerSize bannerSize = AdmobBannerSize.BANNER;
  static String getBannerId = getBannerAdUnitId();
  static Map<String, dynamic> rewardCallback = {
    'type': '',
    'amount': 0,
  }; //HomePage.rewardCallback['type'] - HomePage.rewardCallback['amount']

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  @override
  void initState() {
    super.initState();

    HomePage.bannerSize = AdmobBannerSize.BANNER;

    HomePage.counter = 0;

    HomePage.interstitialAd = AdmobInterstitial(
      adUnitId: getInterstitialAdUnitId(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) HomePage.interstitialAd.load();
      },
    );

    HomePage.rewardAd = AdmobReward(
        adUnitId: getRewardBasedVideoAdUnitId(),
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          if (event == AdmobAdEvent.closed) HomePage.rewardAd.load();
          handleEvent(event, args, 'Reward');
        });

    HomePage.interstitialAd.load();

    HomePage.rewardAd.load();
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        print('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        print('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        print('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        print('Admob $adType failed to load. :(');
        break;
      case AdmobAdEvent.rewarded:
        HomePage.rewardCallback['type'] = args['type'];
        HomePage.rewardCallback['amount'] += args['amount'];
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    AdmobBanner myBanner = AdmobBanner(
      adUnitId: getBannerAdUnitId(),
      adSize: HomePage.bannerSize,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                child: Text('Counter ${HomePage.counter}'),
                onPressed: () {
                  HomePage.counter++;
                },
              ),
              RaisedButton(
                child: Text(
                  'Intersticial',
                ),
                onPressed: () async {
                  if (await HomePage.interstitialAd.isLoaded &&
                      HomePage.counter >= 3) {
                    Future.delayed(const Duration(milliseconds: 2500), () {
                      HomePage.interstitialAd.show();
                    });
                    setState(() {
                      HomePage.counter = 0;
                    });
                  }
                },
              ),
              RaisedButton(
                child: Text(
                  'Rewarded',
                ),
                onPressed: () async {
                  if (await HomePage.rewardAd.isLoaded) {
                    HomePage.rewardAd.show();
                  }
                },
              ),
              RaisedButton(
                child: Text('To Second Route'),
                onPressed: () {
                  Navigator.pushNamed(context, '/anotherPage');
                },
              ),
              myBanner,
            ],
          ),
        ),
      ),
    );
  }

  void dispose() {
    HomePage.interstitialAd.dispose();
    HomePage.rewardAd.dispose();
    super.dispose();
  }
}
