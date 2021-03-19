import 'package:flutter/material.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:share/share.dart';
import 'package:rep_check/utils/constants.dart';

List<Widget> commonAppBarActions() {
  return List.filled(
      1,
      IconButton(
          icon: Icon(Icons.share),
          highlightColor: Styles.primaryColor,
          onPressed: () {
            Share.share(Constants.shareMessage,
                subject: Constants.shareSubject);
          }));
}
