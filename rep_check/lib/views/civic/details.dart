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

  launchPhone(String phone) async {
    String url = 'tel:$phone';
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

  String getOffice1(Official official) {
    String address = 'n/a';
    if (official.address != null) {
      if (official.address.length > 0) {
        address = official.address[0].line1;
      }
    }
    return address;
  }

  String getOffice2(Official official) {
    String address = 'n/a';
    if (official.address != null) {
      if (official.address.length > 0) {
        address = official.address[0].city +
            ', ' +
            official.address[0].state +
            ' ' +
            official.address[0].zip;
      }
    }
    return address;
  }

  bool hasPhone(Official official) {
    bool phone = false;
    if (official.phones != null) {
      if (official.phones.length > 0) {
        phone = true;
      }
    }
    return phone;
  }

  String getPhone(Official official) {
    return official.phones[0];
  }

  bool hasEmail(Official official) {
    bool email = false;
    if (official.emails != null) {
      if (official.emails.length > 0) {
        email = true;
      }
    }
    return email;
  }

  String getEmail(Official official) {
    return official.emails[0];
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
                    title: Text(official.name,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.sliverTitle),
                    background: Widgethelper.getCivicPhoto(official)))
          ];
        },
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
            physics: ClampingScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  getHeadline('Details'),
                  Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Title', style: Styles.detailProp),
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
                      hasPhone(official)
                          ? GestureDetector(
                              onTap: () => (official.phones != null
                                  ? launchPhone(official.phones[0])
                                  : null),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Phone', style: Styles.detailProp),
                                    Text(getPhone(official),
                                        style: TextStyle(
                                            color: Styles.primaryVariantColor)),
                                  ]))
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                  Text('Phone', style: Styles.detailProp),
                                  Text('n/a'),
                                ]),
                      hasEmail(official)
                          ? GestureDetector(
                              onTap: () => launchEmail(official.emails[0]),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text('Email', style: Styles.detailProp),
                                    Text(getEmail(official),
                                        style: TextStyle(
                                            color: Styles.primaryVariantColor)),
                                  ]))
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                  Text('Email', style: Styles.detailProp),
                                  Text('n/a'),
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
                            Text('Office', style: Styles.detailProp),
                            Text(getOffice1(official)),
                            Text(getOffice2(official))
                          ])
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
