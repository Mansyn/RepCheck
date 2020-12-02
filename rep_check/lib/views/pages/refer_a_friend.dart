import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/views/partials/custom_form_fields.dart';
import 'package:rep_check/views/partials/fake_bottom_buttons.dart';

class ReferAFriendPage extends StatefulWidget {
  @override
  _ReferAFriendPageState createState() => _ReferAFriendPageState();
}

class _ReferAFriendPageState extends State<ReferAFriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refer A Friend"),
      ),
      body: Container(
        padding: EdgeInsets.all(Constants.commonPadding),
        child: ListView(
          children: <Widget>[
            Text(
              "Tell a friend to tell a friend to tell a friend.",
              style: Styles.h1.copyWith(
                height: 2,
              ),
            ),
            Container(
              height: 300,
              child: Image.asset('assets/images/collaboration.png'),
            ),
            MySubmitIconedButton(
                "Share App With Friends", Icon(Icons.share), false, () {
              Share.share(Constants.shareMessage,
                  subject: Constants.shareSubject);
            }),
            FakeBottom(),
          ],
        ),
      ),
    );
  }
}
