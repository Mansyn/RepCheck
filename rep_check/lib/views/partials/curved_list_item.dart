import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoder/model.dart';
import 'package:rep_check/responses/maps/place_response.dart';
import 'package:rep_check/utils/enums.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/views/civic/auto.dart';
import 'package:rep_check/views/civic/manual.dart';

class CurvedListItem extends StatelessWidget {
  const CurvedListItem(
      {this.title,
      this.header,
      this.query,
      this.body,
      this.icon,
      this.description,
      this.color,
      this.nextColor,
      this.lookup,
      this.place,
      this.address});

  final String title;
  final String header;
  final Query query;
  final Body body;
  final String description;
  final IconData icon;
  final Color color;
  final Color nextColor;
  final Lookup lookup;
  final PlaceResponse place;
  final Address address;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: nextColor,
        child: Container(
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80.0),
                )),
            padding: const EdgeInsets.only(
              left: 35,
              right: 35,
              top: 35.0,
              bottom: 60,
            ),
            child: GestureDetector(
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        if (lookup == Lookup.auto) {
                          return CivicAutoPage(query, body, title, address);
                        } else {
                          return CivicManualPage(query, body, title, place);
                        }
                      }),
                    ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(header, style: Styles.appHeader),
                      Text(title, style: Styles.appTitle),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Text(description, style: Styles.appHeader)
                      ])
                    ]))));
  }
}
