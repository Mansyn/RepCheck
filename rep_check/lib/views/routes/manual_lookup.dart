import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rep_check/repositories/places_repository.dart';
import 'package:rep_check/responses/maps/place_response.dart';
import 'package:rep_check/responses/maps/suggestion_response.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/enums.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/views/partials/address_search.dart';
import 'package:rep_check/views/partials/common_appbar_actions.dart';
import 'package:rep_check/views/partials/curved_list_item.dart';
import 'package:uuid/uuid.dart';

class ManualLookupPage extends StatefulWidget {
  @override
  _ManualLookupPageState createState() => _ManualLookupPageState();
}

class _ManualLookupPageState extends State<ManualLookupPage> {
  PlaceResponse _place;

  final _controller = TextEditingController();
  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _state = '';
  String _zipCode = '';

  Text buildAddress() {
    return Text(
        (_streetNumber != '' ? _streetNumber + ' ' : '') +
            _street +
            ', ' +
            _city +
            ', ' +
            _state +
            ' ' +
            _zipCode,
        style: Styles.h2);
  }

  @override
  Widget build(BuildContext context) {
    if (_place == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text(Constants.lookupDistrict, style: Styles.h1AppBar),
          ),
          body: Column(children: <Widget>[
            TextField(
                controller: _controller,
                readOnly: true,
                onTap: () async {
                  // generate a new token here
                  final sessionToken = Uuid().v4();
                  final SuggestionResponse result = await showSearch(
                    context: context,
                    delegate: AddressSearch(sessionToken),
                  );
                  // This will change the text displayed in the TextField
                  if (result != null) {
                    final placeDetails = await PlaceApiProvider(sessionToken)
                        .getPlaceDetailFromId(result.placeId);
                    setState(() {
                      _controller.text = result.description;
                      _streetNumber = placeDetails.streetNumber ??= '';
                      _street = placeDetails.street ??= '';
                      _city = placeDetails.city ??= '';
                      _state = placeDetails.state ??= '';
                      _zipCode = placeDetails.zipCode ??= '';
                      _place = placeDetails;
                    });
                  }
                },
                decoration: InputDecoration(
                  icon: Container(
                    margin: EdgeInsets.only(left: 20),
                    width: 10,
                    height: 10,
                    child: Icon(Icons.search),
                  ),
                  hintText: 'Click here to lookup address',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
                )),
            SizedBox(height: 20.0)
          ]));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text(Constants.lookupDistrict, style: Styles.h1AppBar),
            actions: commonAppBarActions(),
          ),
          body: Column(children: <Widget>[
            Container(
                padding: EdgeInsets.all(Constants.commonPadding),
                child: Row(children: [Flexible(child: buildAddress())])),
            Expanded(
                child:
                    ListView(scrollDirection: Axis.vertical, children: <Widget>[
              CurvedListItem(
                  title: 'Senators For This District',
                  header: 'UPPER BODY',
                  color: Styles.primaryAnalogous1,
                  nextColor: Styles.primaryAnalogous2,
                  query: Query.district,
                  body: Body.upper,
                  icon: MdiIcons.locationEnter,
                  description: 'Federal and State members',
                  lookup: Lookup.manual,
                  place: _place),
              CurvedListItem(
                  title: 'House Members For This District',
                  header: 'LOWER BODY',
                  color: Styles.primaryAnalogous2,
                  nextColor: Styles.primaryAnalogous3,
                  query: Query.district,
                  body: Body.lower,
                  icon: MdiIcons.domain,
                  description: 'Federal and State members',
                  lookup: Lookup.manual,
                  place: _place),
              CurvedListItem(
                  title: 'Senator For This State',
                  header: 'UPPER BODY',
                  color: Styles.primaryAnalogous3,
                  nextColor: Styles.primaryAnalogous4,
                  query: Query.state,
                  body: Body.upper,
                  icon: MdiIcons.accountBox,
                  description: 'State members',
                  lookup: Lookup.manual,
                  place: _place),
              CurvedListItem(
                  title: 'House Members For This State',
                  header: 'LOWER BODY',
                  color: Styles.primaryAnalogous4,
                  nextColor: Styles.accentColor,
                  query: Query.state,
                  body: Body.lower,
                  icon: MdiIcons.accountBox,
                  description: 'State members',
                  lookup: Lookup.manual,
                  place: _place)
            ]))
          ]));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
