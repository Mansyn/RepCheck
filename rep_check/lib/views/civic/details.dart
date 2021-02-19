import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:rep_check/blocs/opensecret_bloc.dart';
import 'package:rep_check/models/civic/offices.dart';
import 'package:rep_check/models/civic/official.dart';
import 'package:rep_check/models/opensecrets/contributor/contributor.dart';
import 'package:rep_check/models/opensecrets/legislator/legislator.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/data_helper.dart';
import 'package:rep_check/utils/enums.dart';
import 'package:rep_check/views/partials/channel_button.dart';
import 'package:rep_check/views/partials/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rep_check/utils/styles.dart';

import 'detail_parts/detail_header.dart';

class OfficialDetails extends StatefulWidget {
  final Official official;
  final Offices office;
  final String state;
  OfficialDetails({Key key, this.official, this.office, this.state})
      : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<OfficialDetails> {
  List<Legislator> _relatedLegislators;
  List<Contributor> _topContributors;
  bool _searching = true;

  final oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    super.initState();
    this._fetchStateSecrets(widget.state);
  }

  Future<void> _fetchStateSecrets(String state) async {
    final code = Datahelper.getStateShort(state);
    final legislators = await OpenSecretBloc().fetchStateLegislators(code);

    setState(() {
      _relatedLegislators = legislators.response.legislator;
    });

    _fetchTopContributors();
  }

  Future<void> _fetchTopContributors() async {
    String cid;

    _relatedLegislators.forEach((legis) {
      List<String> legisNameParts = legis.attributes.firstlast.split(" ");
      String legisName =
          (legisNameParts[0] + " " + legisNameParts[legisNameParts.length - 1])
              .toLowerCase();

      List<String> officialNameParts = widget.official.name.split(" ");
      String officialName = (officialNameParts[0] +
              " " +
              officialNameParts[officialNameParts.length - 1])
          .toLowerCase();

      if (legisName == officialName) {
        cid = legis.attributes.cid;
      }
    });

    if (cid != null) {
      final contributors = await OpenSecretBloc().fetchTopContributors(cid);

      setState(() {
        _topContributors = contributors.response.contributors.contributor;
        _searching = false;
      });
    } else {
      setState(() {
        _searching = false;
      });
    }
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
        child: Text(text,
            style: Styles.listItemHeader
                .copyWith(decoration: TextDecoration.underline)));
  }

  Widget getContributorsHeadline() {
    if (_topContributors != null) {
      return getHeadline('Top Contributors');
    } else {
      return SizedBox(height: 0);
    }
  }

  Widget getContributors() {
    if (_topContributors != null) {
      return Column(children: <Widget>[
        Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Organization', style: Styles.detailProp)
                  ]),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[Text('Total', style: Styles.detailProp)]),
            ]),
        for (int i = 0; i <= 9; i++)
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_topContributors[i].attributes.orgName,
                              style: Styles.defaultStyle)
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                              "\$" +
                                  "${oCcy.format(double.parse(_topContributors[i].attributes.total))}",
                              style: Styles.defaultStyle)
                        ])
                  ]))
      ]);
    } else {
      return SizedBox(height: 0);
    }
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

    if (official.channels != null) {
      buttons.add(ChannelButton(
          buttonType: ButtonType.web,
          onPressed: () {
            launchURL(official.urls.first);
          }));
      official.channels.forEach((channel) {
        Widget button;
        switch (channel.type) {
          case 'Facebook':
            button = ChannelButton(
                buttonType: ButtonType.facebook,
                onPressed: () {
                  launchURL(Constants.fbUrl + channel.id);
                });
            break;
          case 'YouTube':
            button = ChannelButton(
                buttonType: ButtonType.youtube,
                onPressed: () {
                  launchURL(Constants.youtubeUrl + channel.id);
                });
            break;
          case 'Twitter':
            button = ChannelButton(
                buttonType: ButtonType.twitter,
                onPressed: () {
                  launchURL(Constants.twitUrl + channel.id);
                });
            break;
        }
        buttons.add(button);
      });
    }
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
    String address = '';
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
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: FractionalOffset.centerRight,
                        end: FractionalOffset.bottomLeft,
                        colors: <Color>[
                      const Color(0xFF222629),
                      const Color(0xFF474B4F),
                    ])),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DetailHeader(
                        official,
                        avatarTag: official.name,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                getHeadline('Details'),
                                Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Title',
                                                style: Styles.detailProp),
                                            Text(office.name)
                                          ]),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text('Party',
                                                style: Styles.detailProp),
                                            Text(official.party)
                                          ])
                                    ]),
                                Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    hasPhone(official)
                                        ? GestureDetector(
                                            onTap: () =>
                                                (official.phones != null
                                                    ? launchPhone(
                                                        official.phones[0])
                                                    : null),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text('Phone',
                                                      style: Styles.detailProp),
                                                  Text(getPhone(official),
                                                      style: TextStyle(
                                                          color: Styles
                                                              .primaryVariantColor)),
                                                ]))
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                                Text('Phone',
                                                    style: Styles.detailProp),
                                                Text('n/a'),
                                              ]),
                                    hasEmail(official)
                                        ? GestureDetector(
                                            onTap: () =>
                                                launchEmail(official.emails[0]),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text('Email',
                                                      style: Styles.detailProp),
                                                  Text(getEmail(official),
                                                      style: TextStyle(
                                                          color: Styles
                                                              .primaryVariantColor)),
                                                ]))
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                                Text('Email',
                                                    style: Styles.detailProp),
                                                Text('n/a'),
                                              ])
                                  ],
                                ),
                                Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Office',
                                              style: Styles.detailProp),
                                          Text(getOffice1(official)),
                                          Text(getOffice2(official))
                                        ])
                                  ],
                                ),
                                SizedBox(height: 20),
                                if (official.channels != null)
                                  getHeadline('Contact Channels'),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Column(
                                      children: getButtons(official),
                                    ),
                                  ),
                                ),
                                if (_searching)
                                  Loading(
                                      loadingMessage: "Searching Contributors"),
                                getContributorsHeadline(),
                                getContributors(),
                                SizedBox(height: 40)
                              ]))
                    ]))));
  }

  Widget build(BuildContext context) {
    return Scaffold(body: buildDetails(widget.official, widget.office));
  }
}
