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
  Widget _buildVerticalLayout() {
    return Column(children: [
      Expanded(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: FittedBox(
              child: Image.asset(Constants.flagKey),
              fit: BoxFit.scaleDown,
            )),
      ),
      Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/auto');
            },
            child: Card(
                elevation: 6.0,
                color: Styles.accentVarColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0))),
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Container(
                    child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: Container(
                            padding: EdgeInsets.only(right: 12.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1.0, color: Colors.white24))),
                            child: Icon(Icons.location_searching, size: 40)),
                        title: Text(
                          Constants.detectDistrict,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(children: <Widget>[
                          Text(Constants.detectDistrictDesc,
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
                    borderRadius: BorderRadius.all(Radius.circular(18.0))),
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Container(
                    child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: Container(
                            padding: EdgeInsets.only(right: 12.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1.0, color: Colors.white24))),
                            child: Icon(Icons.search, size: 40)),
                        title: Text(
                          Constants.lookupDistrict,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(children: <Widget>[
                          Text(Constants.lookupDistrictDesc,
                              style: TextStyle(color: Colors.white))
                        ]),
                        trailing: Icon(Icons.keyboard_arrow_right,
                            color: Colors.white, size: 30.0)))))
      ]))
    ]);
  }

  Widget _buildHorizontalLayout() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: FittedBox(
              child: Image.asset(Constants.flagKey),
              fit: BoxFit.scaleDown,
            )),
      ),
      Expanded(
          flex: 2,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/auto');
                },
                child: Card(
                    elevation: 6.0,
                    color: Styles.accentVarColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(18.0))),
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                                child:
                                    Icon(Icons.location_searching, size: 40)),
                            title: Text(
                              Constants.detectDistrict,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(children: <Widget>[
                              Text(Constants.detectDistrictDesc,
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
                        borderRadius: BorderRadius.all(Radius.circular(18.0))),
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                                child: Icon(Icons.search, size: 40)),
                            title: Text(
                              Constants.lookupDistrict,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(children: <Widget>[
                              Text(Constants.lookupDistrictDesc,
                                  style: TextStyle(color: Colors.white))
                            ]),
                            trailing: Icon(Icons.keyboard_arrow_right,
                                color: Colors.white, size: 30.0)))))
          ]))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(Constants.appName, style: Styles.h1AppBar),
            actions: commonAppBarActions()),
        drawer: HomeDrawer(),
        resizeToAvoidBottomInset: false,
        backgroundColor: Styles.primaryColor,
        body: OrientationBuilder(builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildVerticalLayout()
              : _buildHorizontalLayout();
        }));
  }
}
