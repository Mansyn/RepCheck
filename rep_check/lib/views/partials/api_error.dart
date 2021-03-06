import 'package:flutter/material.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/styles.dart';

class ApiError extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const ApiError({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Text(
            Constants.testing ? errorMessage : "API ERROR!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          OutlinedButton(
              style: OutlinedButton.styleFrom(primary: Styles.primaryColor),
              child: Text('Retry', style: TextStyle(color: Colors.white)),
              onPressed: onRetryPressed)
        ]));
  }
}
