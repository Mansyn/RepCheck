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
            alignment: Alignment.center,
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
                  SizedBox(height: 30),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/auto');
                      },
                      child: Card(
                          elevation: 6.0,
                          color: Styles.accentVarColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18.0))),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 6.0),
                          child: Container(
                              child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: Container(
                                      padding: EdgeInsets.only(right: 12.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.white24))),
                                      child: Icon(Icons.location_searching)),
                                  title: Text(
                                    'Detect District',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                  subtitle: Row(children: <Widget>[
                                    Text('use GPS location',
                                        style: TextStyle(color: Colors.white))
                                  ]),
                                  trailing: Icon(Icons.keyboard_arrow_right,
                                      color: Colors.white, size: 30.0))))),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/manual');
                      },
                      child: Card(
                          elevation: 6.0,
                          color: Styles.accentVarColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18.0))),
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 6.0),
                          child: Container(
                              child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: Container(
                                      padding: EdgeInsets.only(right: 12.0),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.white24))),
                                      child: Icon(Icons.search)),
                                  title: Text(
                                    'Lookup District',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                  subtitle: Row(
                                    children: <Widget>[
                                      Text('find by address',
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                  trailing: Icon(Icons.keyboard_arrow_right,
                                      color: Colors.white, size: 30.0)))))
                ]))));
  }
}
