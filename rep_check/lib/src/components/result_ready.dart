import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rep_check/src/utils/constants.dart';
import 'package:rep_check/src/utils/styles.dart';

class Results {
  static Widget ready() {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage(Constants.logoMuted),
          ),
        ));
  }

  static Widget query() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Querying...',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 28.0,
                  color: Styles.primaryColor,
                  decoration: TextDecoration.none)),
          const SizedBox(height: 20),
          SizedBox(
            child: SpinKitChasingDots(color: Styles.primaryColor, size: 100.0),
            height: 100.0,
            width: 100.0,
          )
        ],
      ),
    );
  }

  static Widget noInternet() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('No Internet',
              textAlign: TextAlign.center,
              style: Styles.h2.copyWith(fontSize: 28)),
          const SizedBox(height: 20),
          SizedBox(
            child: FaIcon(FontAwesomeIcons.wifi,
                color: Styles.primaryColor, size: 82),
            height: 100.0,
            width: 100.0,
          )
        ],
      ),
    );
  }

  static Widget empty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('No Results',
              textAlign: TextAlign.center,
              style: Styles.h2.copyWith(fontSize: 28)),
          const SizedBox(height: 20),
          SizedBox(
            child: FaIcon(FontAwesomeIcons.search,
                color: Styles.primaryColor, size: 100),
            height: 100.0,
            width: 100.0,
          )
        ],
      ),
    );
  }
}
