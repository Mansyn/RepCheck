import 'package:flutter/material.dart';

import 'utils/router.dart';
import 'utils/styles.dart';
import 'views/pages/unknown_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
