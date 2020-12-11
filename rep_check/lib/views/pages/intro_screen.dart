import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/views/partials/fake_bottom_buttons.dart';

import 'home.dart';

class IntroScreenPage extends StatefulWidget {
  @override
  _IntroScreenPageState createState() => _IntroScreenPageState();
}

class _IntroScreenPageState extends State<IntroScreenPage> {
  static final List<String> images = [
    'assets/images/logo.png',
    'assets/images/roots.png',
    'assets/images/hands.png',
  ];

  static final List<String> titles = [
    Constants.appName,
    'Did You Know',
    'Be Informed',
  ];

  static final List<String> descriptions = [
    'We believe everyone should know who represents them in Congress.',
    'Less than half of Americans can name their Representative. Too few know how their Representatives performed, too many are informed solely by advertisements.',
    'We want this tool to empower voters with information.'
  ];

  final pages = [
    PageViewModel(
        pageColor: Styles.primaryColor.withRed(120),
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
      pageColor: Styles.primaryColor.withRed(150),
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
        pageColor: Styles.primaryColor.withRed(90),
        iconImageAssetPath: images[1],
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
        color: Colors.red,
        child: Scaffold(
          persistentFooterButtons: FakeBottomButtons(height: 50.0),
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
