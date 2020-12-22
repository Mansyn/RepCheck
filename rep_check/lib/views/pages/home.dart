import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/enums.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/views/civic/index.dart';
import 'package:rep_check/views/partials/common_appbar_actions.dart';
import 'package:rep_check/views/partials/drawer.dart';
import 'package:rep_check/views/partials/fake_bottom_buttons.dart';

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

  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: Constants.testingDevices, keywords: Constants.keywords);

  bool _adShown = false;
  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: Constants.adUnitId,
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            _adShown = true;
            setState(() {});
          } else if (event == MobileAdEvent.failedToLoad) {
            _adShown = false;
            setState(() {});
          }
        });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: Constants.adAppId);
    _adShown = false;
    _bannerAd = createBannerAd()
      ..load()
      ..show();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            persistentFooterButtons: _adShown
                ? fakeBottomButtons(height: 50.0)
                : null, // showcase admob banner
            appBar: AppBar(
              title: Text('Available Queries', style: Styles.h1AppBar),
              actions: commonAppBarActions(),
            ),
            drawer: HomeDrawer(),
            body: ListView(scrollDirection: Axis.vertical, children: <Widget>[
              CurvedListItem(
                  title: 'Senators From Your District',
                  header: 'UPPER BODY',
                  color: Styles.primaryAnalogous1,
                  nextColor: Styles.primaryAnalogous2,
                  query: Query.district,
                  body: Body.upper,
                  icon: MdiIcons.locationEnter,
                  description: 'Federal and State members'),
              CurvedListItem(
                  title: 'House Members From Your District',
                  header: 'LOWER BODY',
                  color: Styles.primaryAnalogous2,
                  nextColor: Styles.primaryAnalogous3,
                  query: Query.district,
                  body: Body.lower,
                  icon: MdiIcons.domain,
                  description: 'Federal and State members'),
              CurvedListItem(
                  title: 'Senators From Your State',
                  header: 'UPPER BODY',
                  color: Styles.primaryAnalogous3,
                  nextColor: Styles.primaryAnalogous4,
                  query: Query.state,
                  body: Body.upper,
                  icon: MdiIcons.accountBox,
                  description: 'State members'),
              CurvedListItem(
                  title: 'House Members From Your State',
                  header: 'LOWER BODY',
                  color: Styles.primaryAnalogous4,
                  nextColor: Styles.accentColor,
                  query: Query.state,
                  body: Body.upper,
                  icon: MdiIcons.accountBox,
                  description: 'State members')
            ])),
        onWillPop: _onBackPress);
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}

class CurvedListItem extends StatelessWidget {
  const CurvedListItem({
    this.title,
    this.header,
    this.query,
    this.body,
    this.icon,
    this.description,
    this.color,
    this.nextColor,
  });

  final String title;
  final String header;
  final Query query;
  final Body body;
  final String description;
  final IconData icon;
  final Color color;
  final Color nextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: nextColor,
        child: Container(
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80.0),
                )),
            padding: const EdgeInsets.only(
              left: 35,
              right: 35,
              top: 35.0,
              bottom: 60,
            ),
            child: GestureDetector(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CivicIndexPage(query, body),
                      ),
                    ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(header, style: Styles.appHeader),
                      SizedBox(
                        height: 2,
                      ),
                      Text(title, style: Styles.appTitle),
                      Text(description, style: Styles.appHeader)
                    ]))));
  }
}
