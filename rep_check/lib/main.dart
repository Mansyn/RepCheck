import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';

import 'utils/router.dart';
import 'utils/styles.dart';
import 'views/pages/unknown_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) => UnknownPage(),
        );
      },
    );
  }
}
