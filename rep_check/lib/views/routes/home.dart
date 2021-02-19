import 'package:flutter/material.dart';

import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/views/partials/common_appbar_actions.dart';
import 'package:rep_check/views/partials/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Rep Check', style: Styles.h1AppBar),
          actions: commonAppBarActions(),
        ),
        drawer: HomeDrawer(),
        body: Container(
            decoration: BoxDecoration(color: Styles.primaryColor),
            child: SingleChildScrollView(
                primary: true,
                child: Column(children: <Widget>[
                  Image.asset(
                    Constants.handsKey,
                    width: double.infinity,
                    height: 350,
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center,
                    scale: 2.6,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/auto');
                      },
                      child: Card(
                          color: Styles.accentVarColor,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Column(children: [
                            ListTile(
                              leading: Icon(Icons.location_searching),
                              title: const Text('Detect District'),
                              subtitle: Text('using your GPS location'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                  'Find representatives by using your current location'),
                            )
                          ]))),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/manual');
                      },
                      child: Card(
                          color: Styles.accentVarColor,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Column(children: [
                            ListTile(
                              leading: Icon(Icons.search),
                              title: const Text('Lookup District'),
                              subtitle: Text('find by address'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                  'Find representatives by using an address'),
                            )
                          ]))),
                  SizedBox(height: 60)
                ]))));
  }
}
