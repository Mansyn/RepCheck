import 'dart:ui';
import 'package:flutter/material.dart';

// primaryColor = #9b51e0 rgb(155,81,224)

class Styles {
  static Color appPrimaryColor = Color(0xFFa7d129);
  static Color appAccentColor = Color(0xFFdcff60);
  static Color appCanvasColor = Colors.white;
  static Color appBackground = Color(0xFF74a000);
  static Color commonDarkBackground = Colors.grey[200];
  static Color commonDarkCardBackground = Colors.grey[200]; // #1e2d3b
  static TextTheme appTextTheme = TextTheme(
    headline5: TextStyle(
      fontSize: 72.0,
      fontWeight: FontWeight.bold,
    ),
    headline6: Styles.title.copyWith(
      height: 2,
    ),
    bodyText1: TextStyle(
      color: Colors.grey[100],
    ),
  );

  static Color appDrawerIconColor = Colors.grey[800];
  static TextStyle appDrawerTextStyle = TextStyle(color: Colors.grey[900]);

  static TextStyle defaultStyle = TextStyle(
    color: Colors.grey[800],
  );

  static TextStyle h1 = defaultStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 18.0,
    height: 22 / 18,
    color: Colors.grey[700],
  );

  static TextStyle h1AppName = defaultStyle.copyWith(
    fontSize: 30.0,
    height: 35,
    fontFamily: 'YatraOne',
  );

  static TextStyle title = defaultStyle.copyWith(
    fontSize: 30.0,
    height: 35,
    fontFamily: 'YatraOne',
  );

  static TextStyle display1 = defaultStyle.copyWith(
    fontSize: 30.0,
    fontFamily: 'Radicals',
  );

  static TextStyle h1White = defaultStyle.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 18.0,
    height: 22 / 18,
    color: Colors.white,
  );

  static TextStyle p = defaultStyle.copyWith(
    fontSize: 16.0,
    color: Colors.grey[800],
  );

  static TextStyle pTheme = p.copyWith(
    color: appPrimaryColor,
  );

  static TextStyle pWhite = p.copyWith(
    color: Colors.white,
  );

  static TextStyle pMuted = p.copyWith(
    color: Colors.grey[500],
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

  static InputDecoration input = InputDecoration(
    fillColor: Colors.white,
    focusColor: Colors.grey[900],
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.blue,
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
