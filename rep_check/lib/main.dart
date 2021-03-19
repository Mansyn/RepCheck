import 'package:connectivity/connectivity.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'utils/router.dart';
import 'utils/styles.dart';
import 'views/routes/unknown_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  MobileAds.instance.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  String deviceID;
  bool hasInternet = false, isChecking = true;

  @override
  void initState() {
    super.initState();
    check();
  }

  void getDeviceID() async {
    String deviceId = await PlatformDeviceId.getDeviceId;
    print('Device ID is $deviceId');
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
      theme: appTheme.themeData,
      initialRoute: '/splash',
      routes: appRoutes,
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
    super.dispose();
  }
}
