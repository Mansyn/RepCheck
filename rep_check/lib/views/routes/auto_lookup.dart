import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rep_check/utils/enums.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/views/partials/common_appbar_actions.dart';
import 'package:rep_check/views/partials/curved_list_item.dart';

class AutoLookupPage extends StatefulWidget {
  @override
  _AutoLookupPageState createState() => _AutoLookupPageState();
}

class _AutoLookupPageState extends State<AutoLookupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Current District', style: Styles.h1AppBar),
          actions: commonAppBarActions(),
        ),
        body: ListView(scrollDirection: Axis.vertical, children: <Widget>[
          CurvedListItem(
              title: 'Senators For Your District',
              header: 'UPPER BODY',
              color: Styles.primaryAnalogous1,
              nextColor: Styles.primaryAnalogous2,
              query: Query.district,
              body: Body.upper,
              icon: MdiIcons.locationEnter,
              description: 'Federal and State members',
              lookup: Lookup.auto),
          CurvedListItem(
              title: 'House Members For Your District',
              header: 'LOWER BODY',
              color: Styles.primaryAnalogous2,
              nextColor: Styles.primaryAnalogous3,
              query: Query.district,
              body: Body.lower,
              icon: MdiIcons.domain,
              description: 'Federal and State members',
              lookup: Lookup.auto),
          CurvedListItem(
              title: 'Senator For Your State',
              header: 'UPPER BODY',
              color: Styles.primaryAnalogous3,
              nextColor: Styles.primaryAnalogous4,
              query: Query.state,
              body: Body.upper,
              icon: MdiIcons.accountBox,
              description: 'State members',
              lookup: Lookup.auto),
          CurvedListItem(
              title: 'House Members For This State',
              header: 'LOWER BODY',
              color: Styles.primaryAnalogous4,
              nextColor: Styles.accentColor,
              query: Query.state,
              body: Body.lower,
              icon: MdiIcons.accountBox,
              description: 'State members',
              lookup: Lookup.auto)
        ]));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
