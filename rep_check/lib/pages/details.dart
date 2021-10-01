import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text('Top Contributors',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )));
    } else {
      return SizedBox(height: 0);
    }
  }

  Widget getContributors() {
    if (_topContributors.isNotEmpty) {
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
                          Text(_topContributors[i].attributes!.orgName!,
                              style: Styles.defaultStyle)
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                              "\$" +
                                  "${oCcy.format(double.parse(_topContributors[i].attributes!.total!))}",
                              style: Styles.defaultStyle)
                        ])
                  ]))
      ]);
    } else {
      return SizedBox(height: 0);
    }
  }

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  List<Widget> getChannelIndicators(Official official) {
    List<Widget> buttons = [];

    // build urls
    if (official.urls.isNotEmpty) {
      buttons.add(Row(
        children: <Widget>[
          InkWell(
              onTap: () {
                _launchURL(official.urls.first);
              },
              child: FaIcon(FontAwesomeIcons.chrome,
                  color: Styles.white, size: 18)),
        ],
      ));

      var wiki = official.urls
          .where((element) => element.toLowerCase().contains('wiki'));
      if (wiki.isNotEmpty) {
        buttons.add(Row(
          children: <Widget>[
            InkWell(
                onTap: () {
                  _launchURL(wiki.toList().first);
                },
                child: FaIcon(FontAwesomeIcons.wikipediaW,
                    color: Styles.white, size: 18)),
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
                InkWell(
                    onTap: () {
                      _launchURL(Constants.fbUrl + channel.id);
                    },
                    child: FaIcon(FontAwesomeIcons.facebook,
                        color: Styles.white, size: 18)),
              ],
            ));
            break;
          case 'YouTube':
            buttons.add(Row(
              children: <Widget>[
                InkWell(
                    onTap: () {
                      _launchURL(Constants.youtubeUrl + channel.id);
                    },
                    child: FaIcon(FontAwesomeIcons.youtube,
                        color: Styles.white, size: 18)),
              ],
            ));
            break;
          case 'Twitter':
            buttons.add(Row(
              children: <Widget>[
                InkWell(
                    onTap: () {
                      _launchURL(Constants.twitUrl + channel.id);
                    },
                    child: FaIcon(FontAwesomeIcons.twitter,
                        color: Styles.white, size: 18)),
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
              child: Formatting.getCivicPhoto(widget.official),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              top: MediaQuery.of(context).size.height * .4 - 90,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.rotate_90_degrees_ccw,
                      color: Colors.white,
                      size: 35,
                    ),
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
                        Icon(
                          Icons.bookmark_border,
                          size: 30,
                        )
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
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[],
                          ),
                        ),
                        Text(widget.official.party)
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
                          // getContributorsHeadline(),
                          // getContributors(),
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(
                              "\$1,602/month",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              "Estimated repayment",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            trailing: Container(
                              alignment: Alignment.center,
                              width: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 10,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFfed19a),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF632bbf),
                                    ),
                                    child: Icon(
                                      Icons.question_answer,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                  Container(
                                    width: 10,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFfed19a),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: <Widget>[
                        _buildExpandedBtn('Contact'),
                        SizedBox(width: 10),
                        _buildExpandedBtn('Express Interest'),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedBtn(String msg) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFFe2d7f5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Text(
          msg,
          style: TextStyle(
            color: Color(0xff6732c1),
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Container(width: 20, height: 5, color: Colors.white);
  }
}
