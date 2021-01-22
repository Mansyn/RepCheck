import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rep_check/models/civic/offices.dart';
import 'package:rep_check/models/civic/official.dart';
import 'package:rep_check/responses/civic/representative_response.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/utils/widget_helper.dart';

import 'details.dart';

class OfficialList extends StatefulWidget {
  final RepresentativeResponse response;
  final String state;
  const OfficialList({Key key, this.response, this.state}) : super(key: key);

  @override
  _OfficialListState createState() => new _OfficialListState();
}

class _OfficialListState extends State<OfficialList> {
  List<Color> colors = Styles.primaryColors;

  Offices getOffice(Official official) {
    Offices _office;
    int index = widget.response.officials.indexOf(official);

    widget.response.offices.forEach((office) {
      if (office.officialIndices.indexOf(index) > -1) {
        _office = office;
      }
    });

    return _office;
  }

  String getOfficeName(Official official) {
    String _office = '';
    int index = widget.response.officials.indexOf(official);

    widget.response.offices.forEach((office) {
      if (office.officialIndices.indexOf(index) > -1) {
        _office = office.name;
      }
    });

    return _office;
  }

  Text buildAddress() {
    return Text(
        widget.response.normalizedInput.line1 +
            ', ' +
            widget.response.normalizedInput.city +
            ', ' +
            widget.response.normalizedInput.state +
            ' ' +
            widget.response.normalizedInput.zip,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.response.officials != null &&
        widget.response.officials.length > 0) {
      return Stack(children: <Widget>[
        Transform.translate(
          offset: Offset(0.0, MediaQuery.of(context).size.height * 0.1050),
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0.0),
            scrollDirection: Axis.vertical,
            primary: true,
            itemCount: widget.response.officials.length,
            itemBuilder: (BuildContext content, int index) {
              colors.shuffle();
              return AwesomeListItem(
                  official: widget.response.officials[index],
                  office: getOffice(widget.response.officials[index]),
                  officeName: getOfficeName(widget.response.officials[index]),
                  state: widget.state,
                  color: colors[
                      new Random().nextInt(Styles.primaryColors.length)]);
            },
          ),
        ),
        Transform.translate(
            offset: Offset(0.0, -85.0),
            child: Container(
                child: ClipPath(
                    clipper: MyClipper(),
                    child: Stack(children: [
                      // Image.network(
                      //   "https://picsum.photos/800/400?random",
                      //   fit: BoxFit.cover,
                      // ),
                      Container(color: Styles.primaryColor),
                      Transform.translate(
                          offset: Offset(0.0, 92.0),
                          child: ListTile(
                              leading:
                                  ClipOval(child: Icon(Icons.place, size: 40)),
                              title: buildAddress()))
                    ]))))
      ]);
    } else {
      return Center(child: Text('No results found for address'));
    }
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height / 4.75);
    p.lineTo(0.0, size.height / 3.75);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class AwesomeListItem extends StatefulWidget {
  final Official official;
  final Offices office;
  final String officeName;
  final String state;
  final Color color;

  AwesomeListItem(
      {this.official, this.office, this.officeName, this.state, this.color});

  @override
  _AwesomeListItemState createState() => new _AwesomeListItemState();
}

class _AwesomeListItemState extends State<AwesomeListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OfficialDetails(
                    official: widget.official,
                    office: widget.office,
                    state: widget.state),
              ),
            ),
        child: Row(children: <Widget>[
          Container(width: 10.0, height: 190.0, color: widget.color),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.official.name, style: Styles.listItemHeader),
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(widget.officeName))
                ],
              ),
            ),
          ),
          Container(
              height: 150.0,
              width: 150.0,
              child: Stack(children: <Widget>[
                Transform.translate(
                  offset: Offset(50.0, 0.0),
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    color: widget.color,
                  ),
                ),
                Transform.translate(
                    offset: Offset(10.0, 20.0),
                    child: Card(
                        elevation: 20.0,
                        child: Container(
                            height: 120.0,
                            width: 120.0,
                            color: Styles.accentVarColor,
                            child: FittedBox(
                                child:
                                    Widgethelper.getCivicPhoto(widget.official),
                                fit: BoxFit.cover))))
              ]))
        ]));
  }
}
