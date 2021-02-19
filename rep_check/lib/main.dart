import 'package:connectivity/connectivity.dart';
import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_config/flutter_config.dart';

import 'utils/constants.dart';
import 'utils/router.dart';
import 'utils/styles.dart';
import 'views/routes/unknown_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: Constants.testingDevices, keywords: Constants.keywords);

  String deviceID;
  BannerAd _bannerAd;
  double _adSize = 0;
  bool hasInternet = false, isChecking = true;

  @override
  void initState() {
    super.initState();
    check();
    FirebaseAdMob.instance.initialize(appId: Constants.adAppId);
    _bannerAd = createBannerAd()
      ..load()
      ..show();
  }

  void getDeviceID() async {
    String deviceId = await DeviceId.getID;
    print('Device ID is $deviceId');
  }

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: Constants.adUnitId,
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            setState(() {
              _adSize = _bannerAd.size.height.toDouble();
            });
          } else if (event == MobileAdEvent.failedToLoad) {
            setState(() {
              _adSize = 0;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    //getDeviceID();
    MyAppTheme appTheme = MyAppTheme(isDark: true)
      ..prime1 = Styles.primaryColor
      ..prime2 = Styles.primaryVariantColor
      ..accent1 = Styles.accentColor
      ..accent2 = Styles.accentVarColor
      ..bglight = Colors.white
      ..bgdark = Styles.accentColor;
    return MaterialApp(
      title: 'Rep Check',
      debugShowCheckedModeBanner: false,
      theme: appTheme.themeData,
      initialRoute: '/splash',
      routes: appRoutes,
      builder: (context, widget) {
        return Padding(
          child: widget,
          padding: new EdgeInsets.only(bottom: _adSize),
        );
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => UnknownPage(),
        );
      },
    );
  }

  check() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        isChecking = false;
        hasInternet = true;
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isChecking = false;
        hasInternet = true;
      });
    } else {
      setState(() {
        isChecking = false;
        hasInternet = false;
      });
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}
