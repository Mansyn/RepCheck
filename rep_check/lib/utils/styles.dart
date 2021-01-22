import 'dart:ui';
import 'package:flutter/material.dart';

class MyAppTheme {
  Color bglight;
  Color bgdark;
  Color prime1;
  Color prime2;
  Color accent1;
  Color accent2;
  bool isDark;

  /// Default constructor
  MyAppTheme({@required this.isDark});

  ThemeData get themeData {
    /// Create a TextTheme and ColorScheme, that we can use to generate ThemeData
    TextTheme txtTheme =
        (isDark ? ThemeData.dark() : ThemeData.light()).textTheme;
    Color txtColor = txtTheme.bodyText1.color;
    ColorScheme colorScheme = ColorScheme(
        // Decide how you want to apply your own custom them, to the MaterialApp
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: prime1,
        primaryVariant: prime2,
        secondary: accent1,
        secondaryVariant: accent2,
        background: isDark ? bgdark : bglight,
        surface: isDark ? bgdark : bglight,
        onBackground: txtColor,
        onSurface: txtColor,
        onError: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        error: Colors.red.shade400);

    /// Now that we have ColorScheme and TextTheme, we can create the ThemeData
    var t = ThemeData.from(textTheme: txtTheme, colorScheme: colorScheme)
        // We can also add on some extra properties that ColorScheme seems to miss
        .copyWith(
            buttonColor: accent1,
            cursorColor: accent1,
            highlightColor: accent1,
            toggleableActiveColor: accent1);

    /// Return the themeData which MaterialApp can now use
    return t;
  }
}

class Styles {
  static Color primaryColor = Color(0xFF86C232);
  static Color primaryVariantColor = Color(0xFF61892F);
  static Color accentColor = Color(0xFF222629);
  static Color accentVarColor = Color(0xFF474B4F);
  static TextTheme appTextTheme = TextTheme(
    headline5: TextStyle(
      fontSize: 72.0,
      fontWeight: FontWeight.bold,
    ),
    bodyText1: TextStyle(
      color: Colors.grey[100],
    ),
  );
  static Color primaryAnalogous1 = Color(0xFF6CBB3C);
  static Color primaryAnalogous2 = Color(0xFFB2C248);
  static Color primaryAnalogous3 = Color(0xFF85BB65);
  static Color primaryAnalogous4 = Color(0xFF243F17);
  static Color primaryAnalogous5 = Color(0xFF007C01);
  static Color primaryAnalogous6 = Color(0xFF427818);

  static List<Color> primaryColors = [
    Styles.primaryVariantColor,
    Styles.primaryAnalogous1,
    Styles.primaryAnalogous2,
    Styles.primaryAnalogous3,
    Styles.primaryAnalogous4,
    Styles.primaryAnalogous5,
    Styles.primaryAnalogous6
  ];

  static TextStyle defaultStyle = TextStyle();

  static TextStyle h1AppBar = defaultStyle.copyWith(
    fontSize: 26.0,
    fontFamily: 'PassionOne',
  );

  static TextStyle h1AppName = defaultStyle.copyWith(
    fontSize: 72.0,
    fontFamily: 'PassionOne',
  );

  static TextStyle loadingHeader = defaultStyle.copyWith(
      fontSize: 42.0,
      color: primaryColor,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.normal);

  static TextStyle listItemHeader =
      defaultStyle.copyWith(fontSize: 28.0, fontFamily: 'PassionOne');

  static TextStyle detailHeader = defaultStyle.copyWith(
    fontSize: 38.0,
    fontFamily: 'PassionOne',
  );

  static TextStyle appTitle = defaultStyle.copyWith(
    fontSize: 38.0,
    fontFamily: 'PassionOne',
  );

  static TextStyle sliverTitle = defaultStyle.copyWith(
      fontSize: 21.0, fontFamily: 'PassionOne', color: Colors.white);

  static TextStyle sliverTitleNoPhoto =
      sliverTitle.copyWith(color: primaryColor);

  static TextStyle appHeader = defaultStyle.copyWith(
      color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w800);

  static TextStyle h1 = defaultStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 21.0,
    color: primaryColor,
  );

  static TextStyle h2 = defaultStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 16.0,
    color: primaryColor,
  );

  static TextStyle h2White = h2.copyWith(
    color: Colors.white,
  );

  static TextStyle h2Black = h2.copyWith(
    color: Colors.black,
  );

  static TextStyle h2Accent = h2.copyWith(color: Styles.accentColor);

  static TextStyle p = defaultStyle.copyWith(
    fontSize: 16.0,
    color: Colors.grey[800],
  );

  static TextStyle pTheme = p.copyWith(
    color: primaryColor,
  );

  static TextStyle pWhite = p.copyWith(
    color: Colors.white,
  );

  static TextStyle pMuted = p.copyWith(
    color: Colors.grey[500],
  );

  static TextStyle detail = defaultStyle.copyWith(
    fontSize: 12.0,
    color: Colors.grey[800],
  );

  static TextStyle pForgotPassword = p.copyWith(
    color: Colors.blue,
  );

  static TextStyle pButton = defaultStyle.copyWith(
    fontSize: 15.0,
  );

  static TextStyle error = defaultStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Colors.red,
  );

  static TextStyle detailProp = TextStyle(
      color: primaryColor,
      fontSize: 14.0,
      fontWeight: FontWeight.w800,
      height: 3);

  static InputDecoration input = InputDecoration(
    fillColor: Colors.white,
    focusColor: Colors.grey[900],
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: primaryColor,
        width: 2.0,
      ),
    ),
    border: OutlineInputBorder(
      gapPadding: 1.0,
      borderSide: BorderSide(
        color: Colors.grey[600],
        width: 1.0,
      ),
    ),
    hintStyle: TextStyle(
      color: Colors.grey[600],
    ),
  );

  static int redColor = 0xffff2d55;
  static Color tipColor = Color.fromRGBO(255, 226, 108, 1);
  static Color matchWonCardSideColor = Color.fromRGBO(22, 160, 133, 1);
  static Color matchLostCardSideColor = Color.fromRGBO(211, 84, 0, 1);
  static Color vipCardBgColor = Colors.orange[100];

  // forums
  static Color forumBgColor = Color.fromRGBO(37, 35, 49, 1);

  static Color leftMessageBgColor = Color.fromRGBO(52, 49, 69, 1);
  static Color leftMessageAkaColor = Color.fromRGBO(107, 108, 127, 1);
  static Color leftMessageMessageColor = Colors.white;

  static Color rightMessageBgColor = Color.fromRGBO(37, 105, 253, 1);
  static Color rightMessageAkaColor = Color.fromRGBO(139, 172, 244, 1);
  static Color rightMessageMessageColor = Colors.white;
}
