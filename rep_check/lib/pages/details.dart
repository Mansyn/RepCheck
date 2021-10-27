import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rep_check/components/loading.dart';
import 'package:rep_check/data/models/civic/office.dart';
import 'package:rep_check/data/models/civic/official.dart';
import 'package:rep_check/data/models/opensecrets/contributor/contributor.dart';
import 'package:rep_check/data/models/opensecrets/legislator/attributes.dart';
import 'package:rep_check/data/models/opensecrets/legislator/legislator.dart';
import 'package:rep_check/data/repositories/opensecrets_repository.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/data.dart';
import 'package:rep_check/utils/formatting.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class OfficialDetails extends StatefulWidget {
  final Official official;
  final Office office;
  final String state;

  OfficialDetails(
      {Key? key,
      required this.official,
      required this.office,
      required this.state})
      : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<OfficialDetails> {
  SecretRepository secretRepository = SecretRepository();

  List<Legislator> _relatedLegislators = [];
  List<Contributor> _topContributors = [];
  bool _searching = true;

  final oCcy = new NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    super.initState();
    if (Data.isStateAbbr(widget.state)) {
      this._loadContributions(widget.state);
    }
  }

  Future<void> _loadContributions(String stateCode) async {
    final fetchLegislatorsResponse =
        await secretRepository.fetchLegislators(stateCode);

    if (fetchLegislatorsResponse.response != null) {
      if (fetchLegislatorsResponse.response!.legislators != null) {
        setState(() {
          _relatedLegislators = fetchLegislatorsResponse.response!.legislators!;
        });

        _fetchTopContributors();
      }
    }
  }

  Future<void> _fetchTopContributors() async {
    String? cid;

    _relatedLegislators.forEach((legislator) {
      if (legislator.attributes != null) {
        Attributes attr = legislator.attributes!;
        List<String> legisNameParts = attr.firstlast!.split(" ");
        String legisName = (legisNameParts[0] +
                " " +
                legisNameParts[legisNameParts.length - 1])
            .toLowerCase();
        List<String> officialNameParts = widget.official.name.split(" ");
        String officialName = (officialNameParts[0] +
                " " +
                officialNameParts[officialNameParts.length - 1])
            .toLowerCase();

        if (legisName == officialName) {
          cid = legislator.attributes!.cid;
        }
      }
    });

    if (cid != null) {
      final contributors = await secretRepository.fetchContributors(cid!);

      setState(() {
        _topContributors = contributors.response!.contributors!.contributor!;
        _searching = false;
      });
    } else {
      setState(() {
        _searching = false;
      });
    }
  }

  Widget getContributorsHeadline() {
    if (_topContributors.isNotEmpty) {
      return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Top Contributors',
              style: TextStyle(
                color: Styles.accentColor,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            FaIcon(FontAwesomeIcons.dollarSign,
                color: Styles.accentColor, size: 30)
          ],
        ),
        SizedBox(height: 10)
      ]);
    } else {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text('Contributors Not Found',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )));
    }
  }

  Widget getContributors() {
    if (_topContributors.isNotEmpty) {
      return Column(children: <Widget>[
        Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Organization',
                  style: TextStyle(
                    color: Styles.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              Text('Total',
                  style: TextStyle(
                    color: Styles.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ]),
        SizedBox(height: 10),
        for (int i = 0; i <= 9; i++)
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      // <-- This is what you need
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_topContributors[i].attributes!.orgName!,
                              overflow: TextOverflow.ellipsis,
                              style: Styles.defaultStyle)
                        ],
                      ),
                    ),
                    Text(
                        "\$" +
                            "${oCcy.format(double.parse(_topContributors[i].attributes!.total!))}",
                        style: Styles.defaultStyle)
                  ]))
      ]);
    } else {
      return SizedBox(height: 0);
    }
  }

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  void launchEmail(String email) async {
    String url = 'mailto:$email';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchPhone(String phone) async {
    String url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String getOffice1(Official official) {
    String address = 'n/a';
    if (official.address.isNotEmpty) {
      if (official.address.length > 0) {
        address = official.address[0].line1;
      }
    }
    return address;
  }

  String getOffice2(Official official) {
    String address = '';
    if (official.address.isNotEmpty) {
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
    if (official.phones.isNotEmpty) {
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
    if (official.emails.isNotEmpty) {
      if (official.emails.length > 0) {
        email = true;
      }
    }
    return email;
  }

  String getEmail(Official official) {
    return official.emails[0];
  }

  List<Widget> getChannelIndicators(Official official) {
    List<Widget> buttons = [];

    // build urls
    if (official.urls.isNotEmpty) {
      buttons.add(Row(
        children: <Widget>[
          IconButton(
              onPressed: () {
                _launchURL(official.urls.first);
              },
              focusColor: Styles.accentColor,
              highlightColor: Styles.accentColor,
              hoverColor: Styles.accentColor,
              icon: FaIcon(FontAwesomeIcons.chrome, color: Styles.white),
              iconSize: 21),
        ],
      ));

      var wiki = official.urls
          .where((element) => element.toLowerCase().contains('wiki'));
      if (wiki.isNotEmpty) {
        buttons.add(Row(
          children: <Widget>[
            IconButton(
                onPressed: () {
                  _launchURL(wiki.toList().first);
                },
                focusColor: Styles.accentColor,
                highlightColor: Styles.accentColor,
                hoverColor: Styles.accentColor,
                icon: FaIcon(FontAwesomeIcons.wikipediaW, color: Styles.white),
                iconSize: 21),
          ],
        ));
      }
    }

    // build channels
    if (official.channels.isNotEmpty) {
      official.channels.forEach((channel) {
        switch (channel.type) {
          case 'Facebook':
            buttons.add(Row(
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      _launchURL(Constants.fbUrl + channel.id);
                    },
                    focusColor: Styles.accentColor,
                    highlightColor: Styles.accentColor,
                    hoverColor: Styles.accentColor,
                    icon:
                        FaIcon(FontAwesomeIcons.facebook, color: Styles.white),
                    iconSize: 21),
              ],
            ));
            break;
          case 'YouTube':
            buttons.add(Row(
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      _launchURL(Constants.youtubeUrl + channel.id);
                    },
                    focusColor: Styles.accentColor,
                    highlightColor: Styles.accentColor,
                    hoverColor: Styles.accentColor,
                    icon: FaIcon(FontAwesomeIcons.youtube, color: Styles.white),
                    iconSize: 21),
              ],
            ));
            break;
          case 'Twitter':
            buttons.add(Row(
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      _launchURL(Constants.twitUrl + channel.id);
                    },
                    focusColor: Styles.accentColor,
                    highlightColor: Styles.accentColor,
                    hoverColor: Styles.accentColor,
                    icon: FaIcon(FontAwesomeIcons.twitter, color: Styles.white),
                    iconSize: 21),
              ],
            ));
            break;
        }
      });
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .44,
              child: Formatting.getCivicHeadline(widget.official),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              top: MediaQuery.of(context).size.height * .4 - 95,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.buffer,
                        color: Styles.white, size: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: getChannelIndicators(widget.official),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .6 + 50,
              top: MediaQuery.of(context).size.height * .4 - 50,
              child: SingleChildScrollView(
                  child: Container(
                padding: const EdgeInsets.only(left: 30, right: 20, top: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.office.name,
                          style: TextStyle(
                            color: Styles.accentColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FaIcon(FontAwesomeIcons.userAlt,
                            color: Styles.accentColor, size: 30)
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        widget.official.name,
                        style: TextStyle(
                          color: Styles.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Title', style: Styles.detailProp),
                                Text(widget.office.name,
                                    style: Styles.defaultStyle)
                              ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text('Party', style: Styles.detailProp),
                                Text(widget.official.party,
                                    style: Styles.defaultStyle)
                              ])
                        ]),
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        hasPhone(widget.official)
                            ? GestureDetector(
                                onTap: () => (widget.official.phones.isNotEmpty
                                    ? launchPhone(widget.official.phones[0])
                                    : null),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Phone', style: Styles.detailProp),
                                      Text(
                                        getPhone(widget.official),
                                        style: Styles.link,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ]))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Text('Phone', style: Styles.detailProp),
                                    Text('n/a', style: Styles.defaultStyle),
                                  ]),
                        hasEmail(widget.official)
                            ? GestureDetector(
                                onTap: () => (widget.official.emails.isNotEmpty
                                    ? launchEmail(widget.official.emails[0])
                                    : null),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text('Email',
                                          overflow: TextOverflow.ellipsis,
                                          style: Styles.detailProp),
                                      Text(getEmail(widget.official),
                                          style: Styles.link),
                                    ]))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                    Text('Email', style: Styles.detailProp),
                                    Text('n/a', style: Styles.defaultStyle),
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
                              Text(getOffice1(widget.official),
                                  style: Styles.defaultStyle),
                              Text(getOffice2(widget.official),
                                  style: Styles.defaultStyle)
                            ])
                      ],
                    ),
                    SizedBox(height: 15),
                    Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (_searching)
                            Loading(loadingMessage: 'Searching Contributors'),
                          if (!_searching) getContributorsHeadline(),
                          if (!_searching) getContributors(),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
