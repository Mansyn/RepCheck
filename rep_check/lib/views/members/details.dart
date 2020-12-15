import 'package:flutter/material.dart';
import 'package:rep_check/api/api_response.dart';
import 'package:rep_check/blocs/member_bloc.dart';
import 'package:rep_check/models/member_details.dart';
import 'package:rep_check/models/role.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/widget_helper.dart';
import 'package:rep_check/views/partials/api_error.dart';
import 'package:rep_check/views/partials/fake_bottom_buttons.dart';
import 'package:rep_check/views/partials/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rep_check/utils/styles.dart';

class Details extends StatefulWidget {
  final String id;
  Details({Key key, this.id}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<Details> {
  MemberBloc _bloc;

  @override
  void initState() {
    _bloc = MemberBloc(widget.id);
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

  Widget buildButton(String type, MemberDetails member) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () async {
            switch (type) {
              case 'HOMEPAGE':
                launchURL(member.url);
                break;
              case 'FACEBOOK':
                launchURL(Constants.fbUrl + member.facebookAccount);
                break;
              case 'YOUTUBE':
                launchURL(Constants.youtubeUrl + member.youtubeAccount);
                break;
              case 'TWITTER':
                launchURL(Constants.twitUrl + member.twitterAccount);
                break;
              case 'GOVTRACK':
                launchURL(Constants.govTrackUrl + member.govtrackId);
                break;
            }
          },
          color: Styles.primaryColor,
          child: Text(type),
        ));
  }

  Widget buildDetails(MemberDetails member) {
    final Role role = member.roles[0];

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
                      Widgethelper.getProfilePhoto(member),
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
                  getHeadline(member.firstName + ' ' + member.lastName),
                  Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Role', style: TextStyle(height: 3)),
                              Text(role.title)
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text('Party', style: TextStyle(height: 3)),
                              Text(Widgethelper.getPartyName(
                                  member.currentParty)),
                            ])
                      ]),
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Address', style: TextStyle(height: 3)),
                            Text(role.office)
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text('State', style: TextStyle(height: 3)),
                            Text(role.state),
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
                            Text('Phone', style: TextStyle(height: 3)),
                            Text((role.phone != null ? role.phone : 'n/a'))
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text('Fax', style: TextStyle(height: 3)),
                            Text(role.fax != null ? role.fax : 'n/a'),
                          ])
                    ],
                  ),
                  SizedBox(height: 20),
                  getHeadline('Contact'),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(40.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          buildButton('HOMEPAGE', member),
                          buildButton('FACEBOOK', member),
                          buildButton('YOUTUBE', member),
                          buildButton('TWITTER', member),
                          buildButton('GOVTRACK', member)
                        ],
                      ),
                    ),
                  )
                ])));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: fakeBottomButtons(height: 50.0),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchMember(),
        child: StreamBuilder<ApiResponse<MemberDetails>>(
          stream: _bloc.memberStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(
                    loadingMessage: snapshot.data.message,
                  );
                  break;
                case Status.COMPLETED:
                  final MemberDetails member = snapshot.data.data;
                  return buildDetails(member);
                  break;
                case Status.ERROR:
                  return ApiError(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchMember(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
