import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/views/partials/custom_form_fields.dart';

class ReferAFriendPage extends StatefulWidget {
  @override
  _ReferAFriendPageState createState() => _ReferAFriendPageState();
}

class _ReferAFriendPageState extends State<ReferAFriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Refer A Friend", style: Styles.h1AppBar),
        ),
        body: Container(
            padding: EdgeInsets.all(Constants.commonPadding),
            child: ListView(children: <Widget>[
              Container(
                height: 20.0,
              ),
              Center(
                  child: Text(
                Constants.tell,
                style: Styles.h1,
                textAlign: TextAlign.center,
              )),
              Container(
                height: 20.0,
              ),
              mySubmitIconedButton(
                  "Share App With Friends", Icon(Icons.share), false, () {
                Share.share(Constants.shareMessage,
                    subject: Constants.shareSubject);
              })
            ])));
  }
}
