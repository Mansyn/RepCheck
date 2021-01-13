import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rep_check/models/civic/offices.dart';
import 'package:rep_check/models/civic/official.dart';
import 'package:rep_check/responses/civic/representative_response.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/utils/widget_helper.dart';

import 'details.dart';

class OfficialList extends StatelessWidget {
  final RepresentativeResponse response;
  final String state;
  const OfficialList({Key key, this.response, this.state}) : super(key: key);

  String getOfficeName(Official official) {
    String _office = '';
    int index = response.officials.indexOf(official);

    response.offices.forEach((office) {
      if (office.officialIndices.indexOf(index) > -1) {
        _office = office.name;
      }
    });

    return _office;
  }

  Text buildAddress() {
    return Text(
        response.normalizedInput.line1 +
            ', ' +
            response.normalizedInput.city +
            ', ' +
            response.normalizedInput.state +
            ' ' +
            response.normalizedInput.zip,
        style: Styles.h2);
  }

  Offices getOffice(Official official) {
    Offices _office;
    int index = response.officials.indexOf(official);

    response.offices.forEach((office) {
      if (office.officialIndices.indexOf(index) > -1) {
        _office = office;
      }
    });

    return _office;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          padding: EdgeInsets.only(
              left: Constants.commonPadding,
              right: Constants.commonPadding,
              bottom: Constants.commonPadding),
          child: Row(children: [Flexible(child: buildAddress())])),
      Expanded(child:
          Container(child: OrientationBuilder(builder: (context, orientation) {
        return StaggeredGridView.countBuilder(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
          itemCount: response.officials.length,
          itemBuilder: (BuildContext context, int index) => Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              color: Styles.primaryColor,
              child: GestureDetector(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OfficialDetails(
                              official: response.officials[index],
                              office: getOffice(response.officials[index]),
                              state: state),
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
                        child: Widgethelper.getCivicPhoto(
                            response.officials[index]),
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.all(8.0),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              left: Constants.commonPadding,
                              right: Constants.commonPadding),
                          child: Column(children: <Widget>[
                            Text(response.officials[index].name,
                                style: Styles.listItemHeader,
                                textAlign: TextAlign.center),
                            Text(getOfficeName(response.officials[index]),
                                style: Styles.h2Black,
                                textAlign: TextAlign.center),
                            Text(
                                Widgethelper.getMemberParty(
                                    response.officials[index]),
                                style: Styles.h2Black),
                            ButtonBar(children: <Widget>[
                              FlatButton(
                                  child: Icon(MdiIcons.dotsHorizontal),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OfficialDetails(
                                              official:
                                                  response.officials[index],
                                              office: getOffice(
                                                  response.officials[index]),
                                              state: state),
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
      })))
    ]);
  }
}
