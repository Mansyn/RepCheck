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
  Widget _portraitMode() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          padding: EdgeInsets.only(bottom: 20.0),
          child: FittedBox(
            child: Image.asset(Constants.flagKey),
            fit: BoxFit.fill,
          )),
      Container(
          child: GestureDetector(
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
                                          width: 1.0, color: Colors.white24))),
                              child: Icon(Icons.location_searching, size: 40)),
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
                              color: Colors.white, size: 30.0)))))),
      Container(
          child: GestureDetector(
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
                                          width: 1.0, color: Colors.white24))),
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
                              color: Colors.white, size: 30.0))))))
    ]);
  }

  Widget _landscapeMode() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
        child: Container(
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
        backgroundColor: Styles.primaryColor,
        body: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _portraitMode();
          } else {
            return _landscapeMode();
          }
        }));
  }
}
