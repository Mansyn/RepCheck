import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geocoder/model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rep_check/models/civic/official.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/utils/widget_helper.dart';

import 'details.dart';

class OfficialList extends StatelessWidget {
  final List<Official> list;
  final Address address;
  const OfficialList({Key key, this.list, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return StaggeredGridView.countBuilder(
        crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) => Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            color: Styles.primaryColor,
            child: GestureDetector(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OfficialDetails(official: list[index]),
                      ),
                    ),
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: 0,
                      color: Styles.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Widgethelper.getCivicPhoto(list[index]),
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.all(8.0),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            left: Constants.commonPadding,
                            right: Constants.commonPadding),
                        child: Column(children: <Widget>[
                          Text(list[index].name,
                              style: Styles.listItemHeader,
                              textAlign: TextAlign.center),
                          Text(Widgethelper.getMemberParty(list[index]),
                              style: Styles.h1Black),
                          ButtonBar(children: <Widget>[
                            FlatButton(
                                child: Icon(MdiIcons.dotsHorizontal),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OfficialDetails(
                                            official: list[index]),
                                      ));
                                })
                          ])
                        ])),
                  ],
                ))),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      );
    });
  }
}
