import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/query.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/views/members/index.dart';
import 'package:rep_check/views/partials/common_appbar_actions.dart';
import 'package:rep_check/views/partials/custom_form_fields.dart';
import 'package:rep_check/views/partials/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _onBackPress() {
    _askExit();
    return Future.value(false);
  }

  Future _askExit() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: new Text('Are you sure to exit app?'),
              children: <Widget>[
                new SimpleDialogOption(
                  child: new Text('OK'),
                  onPressed: () {
                    Navigator.pop(context, 1);
                  },
                ),
                new SimpleDialogOption(
                  child: new Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context, 0);
                  },
                )
              ]);
        })) {
      case 1:
        exit(0);
        break;
      case 0:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(Constants.appName),
            actions: commonAppBarActions(),
          ),
          drawer: HomeDrawer(),
          body: Container(
            padding: EdgeInsets.all(Constants.commonPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'AVAILABLE QUERIES:',
                  style: Styles.h1,
                ),
                SizedBox(height: 10),
                MySubmitIconedThemedButton(context, "VIEW ENTIRE SENATE",
                    Icon(MdiIcons.viewList), true, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MembersIndexPage('SENATE', Query.full),
                    ),
                  );
                }),
                SizedBox(height: 10),
                MySubmitIconedThemedButton(context, "VIEW ENTIRE HOUSE REPS",
                    Icon(MdiIcons.viewList), true, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MembersIndexPage('HOUSE', Query.full),
                    ),
                  );
                }),
                SizedBox(height: 10),
                MySubmitIconedThemedButton(
                    context,
                    "VIEW SENATORS FOR YOUR STATE",
                    Icon(MdiIcons.viewList),
                    true, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MembersIndexPage('HOUSE', Query.state),
                    ),
                  );
                }),
                SizedBox(height: 10),
                MySubmitIconedThemedButton(
                    context,
                    "VIEW HOUSE REPS FOR YOUR STATE",
                    Icon(MdiIcons.viewList),
                    true, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MembersIndexPage('SENATE', Query.state),
                    ),
                  );
                }),
                SizedBox(height: 25),
                Container(
                  child: Image.asset('assets/images/roots.png'),
                ),
              ],
            ),
          ),
        ),
        //drawer: _buildDrawer()),
        onWillPop: _onBackPress);
  }
}
