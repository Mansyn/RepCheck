import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rep_check/models/member.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/views/members/details.dart';

class MemberList extends StatelessWidget {
  final List<Member> memberList;

  const MemberList({Key key, this.memberList}) : super(key: key);

  Widget getProfilePhoto(Member member) {
    if (member.facebookAccount != null) {
      return CachedNetworkImage(
          imageUrl:
              Constants.fbPhotoUrl.replaceFirst('{id}', member.facebookAccount),
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover);
    } else {
      return Image.asset(Constants.defaultProfile, fit: BoxFit.cover);
    }
  }

  String getPartyName(Member member) {
    switch (member.party) {
      case 'R':
        return 'Republican';
        break;
      case 'D':
        return 'Democrat';
        break;
      case 'L':
        return 'Libertarian';
        break;
      default:
        return member.party;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: memberList.length,
      itemBuilder: (BuildContext context, int index) => Container(
          color: Styles.commonDarkCardBackground,
          child: Column(
            children: <Widget>[
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: getProfilePhoto(memberList[index]),
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.all(8.0),
              ),
              Text(
                  memberList[index].firstName +
                      ' ' +
                      memberList[index].lastName,
                  style: Styles.h1),
              Text(memberList[index].state + ' - ' + memberList[index].title,
                  style: Styles.defaultStyle),
              Text('Party: ' + getPartyName(memberList[index]),
                  style: Styles.defaultStyle),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('MORE INFO'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Details(member: memberList[index]),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          )),
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}
