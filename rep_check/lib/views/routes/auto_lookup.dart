import 'package:flutter/material.dart';
import 'package:geocoder/model.dart';
import 'package:location/location.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rep_check/blocs/location_bloc.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/enums.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/views/partials/common_appbar_actions.dart';
import 'package:rep_check/views/partials/curved_list_item.dart';
import 'package:rep_check/views/partials/loading.dart';

class AutoLookupPage extends StatefulWidget {
  @override
  _AutoLookupPageState createState() => _AutoLookupPageState();
}

class _AutoLookupPageState extends State<AutoLookupPage> {
  Address _address;

  Location location = new Location();
  PermissionStatus _permissionStatus;

  @override
  void initState() {
    checkPermission();
    super.initState();
  }

  Future<bool> checkPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionStatus;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        Navigator.of(context).pop();
      }
    }

    permissionStatus = await location.hasPermission();

    setState(() => {_permissionStatus = permissionStatus});

    return _permissionStatus == PermissionStatus.granted;
  }

  Future<void> _requestPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied ||
        permissionStatus == PermissionStatus.deniedForever) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted &&
          permissionStatus != PermissionStatus.grantedLimited) {
        return;
      }
    }

    setState(() {
      _permissionStatus = permissionStatus;
      print('location permission requested - result: ' +
          _permissionStatus.toString());
    });
  }

  Future<void> _fetchLocation() async {
    final location = await LocationBloc().fetchLocation();

    setState(() {
      _address = location;
    });
  }

  Text buildAddress() {
    return Text(_address.addressLine.replaceAll(', USA', ''),
        style: Styles.h2White);
  }

  @override
  Widget build(BuildContext context) {
    switch (_permissionStatus) {
      case PermissionStatus.granted:
      case PermissionStatus.grantedLimited:
        if (_address == null) {
          this._fetchLocation();
          return Scaffold(
              appBar: AppBar(
                title: Text(""),
              ),
              body: Container(
                  padding: EdgeInsets.all(Constants.commonPadding),
                  child: Loading(loadingMessage: 'getting your location...')));
        } else {
          return Scaffold(
              appBar: AppBar(
                title: Text('Current District', style: Styles.h1AppBar),
                actions: commonAppBarActions(),
              ),
              bottomNavigationBar: Stack(children: [
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                          color: Styles.accentVarColor,
                          width: 1,
                          style: BorderStyle.solid),
                    )),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: Row(children: [
                      Container(
                          child: Icon(Icons.location_searching, size: 40),
                          padding: EdgeInsets.only(right: 10.0)),
                      Flexible(child: buildAddress())
                    ]))
              ]),
              body: Column(children: <Widget>[
                Expanded(
                    child: ListView(
                        padding: EdgeInsets.only(bottom: 60),
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                      CurvedListItem(
                          title: 'Senators For Your District',
                          header: 'UPPER BODY',
                          color: Styles.primaryAnalogous1,
                          nextColor: Styles.primaryAnalogous2,
                          query: Query.district,
                          body: Body.upper,
                          icon: MdiIcons.locationEnter,
                          description: 'Federal and State members',
                          lookup: Lookup.auto,
                          place: null,
                          address: _address),
                      CurvedListItem(
                          title: 'House Members For Your District',
                          header: 'LOWER BODY',
                          color: Styles.primaryAnalogous2,
                          nextColor: Styles.primaryAnalogous3,
                          query: Query.district,
                          body: Body.lower,
                          icon: MdiIcons.domain,
                          description: 'Federal and State members',
                          lookup: Lookup.auto,
                          place: null,
                          address: _address),
                      CurvedListItem(
                          title: 'Senator For Your State',
                          header: 'UPPER BODY',
                          color: Styles.primaryAnalogous3,
                          nextColor: Styles.primaryAnalogous4,
                          query: Query.state,
                          body: Body.upper,
                          icon: MdiIcons.accountBox,
                          description: 'State members',
                          lookup: Lookup.auto,
                          place: null,
                          address: _address),
                      CurvedListItem(
                          title: 'House Members For Your State',
                          header: 'LOWER BODY',
                          color: Styles.primaryAnalogous4,
                          nextColor: Styles.accentColor,
                          query: Query.state,
                          body: Body.lower,
                          icon: MdiIcons.accountBox,
                          description: 'State members',
                          lookup: Lookup.auto,
                          place: null,
                          address: _address)
                    ]))
              ]));
        }
        break;
      default:
        this._requestPermission();
        return Loading(loadingMessage: 'need your permission...');
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
