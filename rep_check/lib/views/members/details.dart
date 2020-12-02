import 'package:flutter/material.dart';
import 'package:rep_check/models/member.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rep_check/utils/styles.dart';

class Details extends StatelessWidget {
  final Member member;
  Details({Key key, this.member}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget getProfilePhoto(Member member) {
      if (member.facebookAccount != null) {
        return FadeInImage.assetNetwork(
            placeholder: Constants.loadingKey,
            image: Constants.fbPhotoUrl
                .replaceFirst('{id}', member.facebookAccount),
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(Constants.defaultProfile);
            },
            fit: BoxFit.cover);
      } else {
        return Image.asset(Constants.defaultProfile, fit: BoxFit.cover);
      }
    }

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 80.0),
        Icon(
          Icons.perm_identity,
          color: Colors.grey[900],
          size: 60.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.grey[900], thickness: 2.0),
        ),
        SizedBox(height: 10.0),
        Text(
          member.firstName + ' ' + member.lastName,
          style: TextStyle(
              color: Colors.grey[900], fontSize: 42, fontFamily: 'YatraOne'),
        ),
        Text(member.title,
            style: TextStyle(fontSize: 18, color: Colors.grey[900])),
        SizedBox(height: 10.0),
        Text('State: ' + member.state,
            style: TextStyle(fontSize: 18, color: Colors.grey[900])),
        Text('Phone: ' + member.phone,
            style: TextStyle(fontSize: 18, color: Colors.grey[900])),
        Text('Fax: ' + member.fax,
            style: TextStyle(fontSize: 18, color: Colors.grey[900])),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            child: getProfilePhoto(member)),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(167, 209, 41, .75)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Styles.appDrawerIconColor),
          ),
        )
      ],
    );

    launchURL(url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    final homepageButton = Container(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () async {
            launchURL(member.url);
          },
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Text("HOMEPAGE"),
        ));
    final contactButton = Container(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () async {
            launchURL(member.contactForm);
          },
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Text("CONTACT"),
        ));
    final facebookButton = Container(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () async {
            launchURL(member.contactForm);
          },
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Text("FACEBOOK"),
        ));
    final youtubeButton = Container(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () async {
            launchURL(member.contactForm);
          },
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Text("YOUTUBE"),
        ));
    final twitterButton = Container(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () async {
            launchURL(member.contactForm);
          },
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Text("TWITTER"),
        ));
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            homepageButton,
            contactButton,
            youtubeButton,
            facebookButton,
            twitterButton
          ],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
