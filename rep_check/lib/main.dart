import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rep_check/utils/constants.dart';

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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return MaterialApp(
        title: Constants.title,
        theme: ThemeData(
            backgroundColor: Styles.backgroundColor,
            cardColor: Styles.backgroundColor,
            primaryColor: Styles.primaryColor,
            colorScheme:
                theme.colorScheme.copyWith(secondary: Styles.accentColor),
            textTheme: GoogleFonts.robotoCondensedTextTheme(textTheme)),
        home: HomePage());
  }
}
