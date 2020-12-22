import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rep_check/models/propublica/member.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/utils/widget_helper.dart';
import 'package:rep_check/views/members/details.dart';

class MemberList extends StatelessWidget {
  final List<Member> memberList;

  const MemberList({Key key, this.memberList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return StaggeredGridView.countBuilder(
        crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
        itemCount: memberList.length,
        itemBuilder: (BuildContext context, int index) => Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            color: Styles.primaryColor,
            child: GestureDetector(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(id: memberList[index].id),
                      ),
                    ),
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Widgethelper.getPublicaPhoto(memberList[index]),
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.all(8.0),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            left: Constants.commonPadding,
                            right: Constants.commonPadding),
                        child: Column(children: <Widget>[
                          Text(
                              memberList[index].firstName +
                                  ' ' +
                                  memberList[index].lastName,
                              style: Styles.listItemHeader,
                              textAlign: TextAlign.center),
                          Text(memberList[index].state,
                              style: Styles.defaultStyle),
                          Text(memberList[index].title, style: Styles.detail),
                          Text(Widgethelper.getMemberParty(memberList[index]),
                              style: Styles.detail),
                          ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                child: const Text('MORE INFO'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Details(id: memberList[index].id),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ]))
                  ],
                ))),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      );
    });
  }
}
