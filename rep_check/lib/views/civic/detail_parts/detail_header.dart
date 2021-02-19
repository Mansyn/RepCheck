import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rep_check/models/civic/official.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

import 'diagonally_cut_colored_image.dart';

class DetailHeader extends StatelessWidget {
  DetailHeader(
    this.official, {
    @required this.avatarTag,
  });

  final Official official;
  final Object avatarTag;

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildDiagonalImageBackground(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return new DiagonallyCutColoredImage(
      Image.asset(
        Constants.rootsKey,
        width: screenWidth,
        height: 280.0,
        fit: BoxFit.cover,
      ),
      color: Styles.primaryFadedColor,
    );
  }

  Widget _buildAvatar() {
    return Hero(
        tag: avatarTag,
        child: CircleAvatar(
          backgroundImage: official.photoUrl != null
              ? NetworkImage(official.photoUrl)
              : AssetImage(Constants.whiteAvatar),
          radius: 100.0,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      _buildDiagonalImageBackground(context),
      Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.3,
          child: Column(children: <Widget>[
            _buildAvatar(),
            Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(avatarTag,
                    style: Styles.listItemHeader.copyWith(
                      fontSize: 36.0,
                      color: Styles.primaryColor,
                    ))),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Styles.primaryColor)),
                        textColor: Styles.primaryColor,
                        padding: EdgeInsets.all(8.0),
                        onPressed: () {
                          launchURL(Constants.newsUrl +
                              official.name.replaceAll(' ', '+'));
                        },
                        child: Text(Constants.newsSearch.toUpperCase()),
                      )
                    ]))
          ])),
      Positioned(
        top: 26.0,
        left: 4.0,
        child: BackButton(color: Colors.white),
      )
    ]);
  }
}
