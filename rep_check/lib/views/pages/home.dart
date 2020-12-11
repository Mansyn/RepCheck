import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/query.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/views/members/index.dart';
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
    testDevices: Constants.testing_devices,
    keywords: Constants.keywords,
    childDirected: true,
    nonPersonalizedAds: false,
  );

  bool _adShown = false;
  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
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
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
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
              ? FakeBottomButtons(height: 50.0)
              : null, // showcase admob banner
          appBar: AppBar(
            title: Text(Constants.appName),
            actions: commonAppBarActions(),
          ),
          drawer: HomeDrawer(),
          body: Container(
            padding: EdgeInsets.all(Constants.commonPadding),
            constraints: BoxConstraints.expand(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'AVAILABLE QUERIES:',
                  style: Styles.h1,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(MdiIcons.viewList),
                      Expanded(
                        child: Text('VIEW ENTIRE SENATE',
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MembersIndexPage('SENATE', Query.full),
                      ),
                    );
                  },
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MembersIndexPage('SENATE', Query.full),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(MdiIcons.viewList),
                      Expanded(
                        child: Text('VIEW ENTIRE HOUSE REPS',
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MembersIndexPage('HOUSE', Query.full),
                      ),
                    );
                  },
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MembersIndexPage('HOUSE', Query.full),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(MdiIcons.viewList),
                      Expanded(
                        child: Text('VIEW SENATORS FOR YOUR STATE',
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MembersIndexPage('SENATE', Query.state),
                      ),
                    );
                  },
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MembersIndexPage('SENATE', Query.state),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(MdiIcons.viewList),
                      Expanded(
                        child: Text('VIEW HOUSE REPS FOR YOUR STATE',
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MembersIndexPage('HOUSE', Query.state),
                      ),
                    );
                  },
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MembersIndexPage('HOUSE', Query.state),
                      ),
                    );
                  },
                ),
                SizedBox(height: 25)
              ],
            ),
          ),
        ),
        //drawer: _buildDrawer()),
        onWillPop: _onBackPress);
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}
