import 'package:flutter/material.dart';
import 'package:rep_check/models/civic/official.dart';
import 'package:rep_check/utils/widget_helper.dart';
import 'package:rep_check/views/partials/fake_bottom_buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rep_check/utils/styles.dart';

class OfficialDetails extends StatefulWidget {
  final Official official;
  OfficialDetails({Key key, this.official}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<OfficialDetails> {
  @override
  void initState() {
    super.initState();
  }

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget getHeadline(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text, style: Styles.listItemHeader),
    );
  }

  Widget buildButton(String type, Official official) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () async {
            switch (type) {
              case 'HOMEPAGE':
                launchURL(official.urls.first);
                break;
            }
          },
          color: Styles.primaryColor,
          child: Text(type),
        ));
  }

  Widget buildDetails(Official official) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                expandedHeight: 210,
                floating: true,
                snap: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    collapseMode: CollapseMode.pin,
                    title: Text('',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 16.0)),
                    background:
                        Stack(alignment: Alignment.center, children: <Widget>[
                      Widgethelper.getCivicPhoto(official),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          gradient: LinearGradient(
                            begin: FractionalOffset.bottomCenter,
                            end: FractionalOffset.topCenter,
                            colors: [
                              Colors.grey.withOpacity(0.0),
                              Colors.black38,
                            ],
                          ),
                        ),
                      ),
                    ])))
          ];
        },
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
            physics: ClampingScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  getHeadline(official.name),
                  Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Party', style: TextStyle(height: 3)),
                              Text(official.party)
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text('Address', style: TextStyle(height: 3)),
                              Text(Widgethelper.getPartyName(
                                  official.address.first.line1))
                            ])
                      ]),
                  SizedBox(height: 20),
                  getHeadline('Contact'),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(40.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[buildButton('HOMEPAGE', official)],
                      ),
                    ),
                  )
                ])));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        persistentFooterButtons: fakeBottomButtons(height: 50.0),
        body: buildDetails(widget.official));
  }
}
