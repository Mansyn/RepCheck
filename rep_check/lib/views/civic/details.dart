import 'package:flutter/material.dart';
import 'package:rep_check/models/civic/offices.dart';
import 'package:rep_check/models/civic/official.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/widget_helper.dart';
import 'package:rep_check/views/partials/fake_bottom_buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rep_check/utils/styles.dart';

class OfficialDetails extends StatefulWidget {
  final Official official;
  final Offices office;
  OfficialDetails({Key key, this.official, this.office}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<OfficialDetails> {
  @override
  void initState() {
    super.initState();
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchEmail(String email) async {
    String url = 'mailto:$email';
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
              case 'Homepage':
                launchURL(official.urls.first);
                break;
              case 'Facebook':
                launchURL(Constants.fbUrl +
                    official.channels
                        .firstWhere((element) => element.type == 'Facebook')
                        .id);
                break;
              case 'YouTube':
                launchURL(Constants.youtubeUrl +
                    official.channels
                        .firstWhere((element) => element.type == 'YouTube')
                        .id);
                break;
              case 'Twitter':
                launchURL(Constants.twitUrl +
                    official.channels
                        .firstWhere((element) => element.type == 'Twitter')
                        .id);
                break;
            }
          },
          color: Styles.primaryColor,
          child: Text(type),
        ));
  }

  List<Widget> getButtons(Official official) {
    List<Widget> buttons = List<Widget>();

    buttons.add(buildButton('Homepage', official));
    official.channels.forEach((channel) {
      buttons.add(buildButton(channel.type, official));
    });

    return buttons;
  }

  Widget buildDetails(Official official, Offices office) {
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
                              Text('Office', style: Styles.detailProp),
                              Text(office.name)
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text('Party', style: Styles.detailProp),
                              Text(official.party)
                            ])
                      ]),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Address', style: Styles.detailProp),
                            Text(official.address != null
                                ? official.address[0].line1 +
                                    ', ' +
                                    official.address[0].city
                                : 'n/a')
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text('State', style: Styles.detailProp),
                            Text(official.address[0].state),
                          ])
                    ],
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Phone', style: Styles.detailProp),
                            Text(official.phones != null
                                ? official.phones[0]
                                : 'n/a')
                          ]),
                      GestureDetector(
                          onTap: () => (official.emails != null
                              ? launchEmail(official.emails[0])
                              : null),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text('Email', style: Styles.detailProp),
                                Text(
                                    official.emails != null
                                        ? official.emails[0]
                                        : 'n/a',
                                    style: TextStyle(
                                        color: Styles.primaryVariantColor)),
                              ]))
                    ],
                  ),
                  SizedBox(height: 20),
                  getHeadline('Channels'),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(40.0),
                    child: Center(
                      child: Column(
                        children: getButtons(official),
                      ),
                    ),
                  )
                ])));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        persistentFooterButtons: fakeBottomButtons(height: 50.0),
        body: buildDetails(widget.official, widget.office));
  }
}
