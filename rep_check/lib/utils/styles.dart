import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Styles {
  static Color red = Color(0xFFFA0202);
  static Color white = Color(0xFFFAFAFA);
  static Color blue = Color(0xFF0000D4);

  static Color primaryColor = blue;
  static Color accentColor = red;
  static Color backgroundColor = white;

  static TextStyle defaultStyle = TextStyle(fontSize: 16.0);

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

  static TextStyle search = pWhite.copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  static TextStyle pMuted = p.copyWith(
    color: Colors.grey[300],
  );

  static TextStyle detail = defaultStyle.copyWith(
    fontSize: 16.0,
    color: Colors.grey[800],
  );

  static TextStyle error = defaultStyle.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    color: Colors.red,
  );

  static TextStyle detailProp = TextStyle(
      color: primaryColor,
      fontSize: 16.0,
      fontWeight: FontWeight.w800,
      height: 3);

  static TextStyle link = defaultStyle.copyWith(
      color: accentColor, decoration: TextDecoration.underline);
}
