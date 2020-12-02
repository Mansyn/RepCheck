import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:rep_check/utils/constants.dart';

List<Widget> commonAppBarActions() {
  List<Widget> actions = new List<Widget>();
  actions.add(
    IconButton(
      icon: Icon(Icons.share),
      highlightColor: Colors.pink,
      onPressed: () {
        Share.share(Constants.shareMessage, subject: Constants.shareSubject);
      },
    ),
  );
  return actions;
}
