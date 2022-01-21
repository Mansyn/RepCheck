import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/home.dart';
import 'utils/constants.dart';
import 'utils/styles.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        home: const HomePage());
  }
}
