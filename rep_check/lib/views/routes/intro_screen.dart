import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/styles.dart';

import 'home.dart';

class IntroScreenPage extends StatefulWidget {
  @override
  _IntroScreenPageState createState() => _IntroScreenPageState();
}

class _IntroScreenPageState extends State<IntroScreenPage> {
  static final List<String> images = [
    'assets/images/logo.png',
    'assets/images/hands2.png',
    'assets/images/magnify.png',
  ];

  static final List<String> titles = [
    Constants.appName,
    'Did You Know',
    'Be Informed',
  ];

  static final List<String> descriptions = [
    'Less than half of USA citizens can name one of their representatives.',
    'Even less know how they voted, most are informed solely by advertisements.',
    'This tool is meant to allow quick access to that information.'
  ];

  final pages = [
    PageViewModel(
        pageColor: Styles.primaryAnalogous1,
        bubble: Image.asset(images[1]),
        title: Text(titles[0]),
        body: Text(descriptions[0]),
        titleTextStyle: Styles.h1AppName,
        bodyTextStyle: Styles.pWhite.copyWith(fontSize: 22),
        mainImage: Image.asset(
          images[0],
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: Styles.primaryAnalogous2,
      iconImageAssetPath: images[2],
      title: Text(titles[1]),
      body: Text(descriptions[1]),
      titleTextStyle: Styles.h1AppName,
      bodyTextStyle: Styles.pWhite.copyWith(fontSize: 22),
      mainImage: Image.asset(
        images[1],
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
        pageColor: Styles.primaryColor,
        iconImageAssetPath: images[0],
        title: Text(titles[2]),
        body: Text(descriptions[2]),
        titleTextStyle: Styles.h1AppName,
        bodyTextStyle: Styles.pWhite.copyWith(fontSize: 22),
        mainImage: Image.asset(
          images[2],
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Container(
        color: Styles.primaryColor,
        child: Scaffold(
          body: IntroViewsFlutter(
            pages,
            showNextButton: true,
            showBackButton: true,
            onTapDoneButton: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            pageButtonTextStyles: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
