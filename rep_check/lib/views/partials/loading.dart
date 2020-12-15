import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rep_check/utils/styles.dart';

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(loadingMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 28.0,
                  color: Styles.primaryColor,
                  decoration: TextDecoration.none)),
          SizedBox(height: 20),
          SizedBox(
            child: SpinKitChasingDots(color: Styles.primaryColor, size: 100.0),
            height: 100.0,
            width: 100.0,
          )
        ],
      ),
    );
  }
}
