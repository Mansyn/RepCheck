import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/home.dart';
import 'utils/styles.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
        title: 'Rep Check',
        theme: ThemeData(
            backgroundColor: Styles.backgroundColor,
            cardColor: Styles.backgroundColor,
            primaryColor: Styles.primaryColor,
            accentColor: Styles.accentColor,
            textTheme: GoogleFonts.robotoTextTheme(textTheme).copyWith(
                headline1:
                    GoogleFonts.robotoCondensed(textStyle: textTheme.headline1),
                headline2:
                    GoogleFonts.robotoCondensed(textStyle: textTheme.headline2),
                headline3:
                    GoogleFonts.robotoCondensed(textStyle: textTheme.headline3),
                headline4:
                    GoogleFonts.robotoCondensed(textStyle: textTheme.headline4),
                headline5:
                    GoogleFonts.robotoCondensed(textStyle: textTheme.headline5),
                headline6:
                    GoogleFonts.robotoCondensed(textStyle: textTheme.headline6),
                subtitle1:
                    GoogleFonts.robotoCondensed(textStyle: textTheme.subtitle1),
                subtitle2: GoogleFonts.robotoCondensed(
                    textStyle: textTheme.subtitle2))),
        home: HomePage());
  }
}
