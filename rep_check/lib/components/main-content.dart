import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:rep_check/components/loading.dart';
import 'package:rep_check/data/models/civic/office.dart';
import 'package:rep_check/data/models/civic/official.dart';
import 'package:rep_check/data/models/representative_response.dart';
import 'package:rep_check/data/repositories/civic_repository.dart';
import 'package:rep_check/pages/details.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/enums.dart';
import 'package:rep_check/utils/formatting.dart';
import 'package:rep_check/utils/styles.dart';

import 'bottom-bar.dart';
import 'result-ready.dart';

class MainContent extends StatefulWidget {
  final bool isPortrait;

  const MainContent({Key? key, required this.isPortrait}) : super(key: key);

  static final kInitialPosition = LatLng(29.749907, -95.358421);

  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  CivicRepository civicRepository = CivicRepository();

  Level level = Level.full;
  Role role = Role.full;
  bool addressSet = false;

  late PickResult selectedPlace;

  TextEditingController addressController = TextEditingController()..text = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _getRoles() {
    switch (role) {
      case Role.full:
        return Constants.roles +
            'legislatorUpperBody' +
            Constants.amp +
            Constants.roles +
            'legislatorLowerBody';
      case Role.upper:
        return Constants.roles + 'legislatorUpperBody';
      case Role.lower:
        return Constants.roles + 'legislatorLowerBody';
      default:
        return '';
    }
  }

  String _getLevels() {
    switch (level) {
      case Level.full:
        return Constants.levels +
            'country' +
            Constants.amp +
            Constants.levels +
            'administrativeArea1';
      case Level.country:
        return Constants.levels + 'country';
      case Level.admin1:
        return Constants.levels + 'administrativeArea1';
      default:
        return '';
    }
  }

  void callback(String filter) {
    switch (filter) {
      case 'All':
        setState(() {
          this.level = Level.full;
          this.role = Role.full;
        });
        break;
      case 'Federal':
        setState(() {
          this.level = Level.country;
          this.role = Role.full;
        });
        break;
      case 'State':
        setState(() {
          this.level = Level.admin1;
          this.role = Role.full;
        });
        break;
    }
    setState(() {});
  }

  Future<Response> getMembers() async {
    return civicRepository.fetchMemberList(
        _getLevels(), _getRoles(), addressController.text);
  }

  Office getOffice(Response response, Official official) {
    late Office _office;
    int index = response.officials.indexOf(official);

    response.offices.forEach((office) {
      if (office.officialIndices.indexOf(index) > -1) {
        _office = office;
      }
    });

    return _office;
  }

  InkWell buildResult(Response response, Official official) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(
            builder: (c) => OfficialDetails(
                official: official,
                office: getOffice(response, official),
                state: response.normalizedInput.state),
          ));
        },
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
            child: Stack(children: <Widget>[
              LayoutBuilder(
                builder: (BuildContext c, BoxConstraints constraints) {
                  return Container(
                    width: MediaQuery.of(context).size.width * .65,
                    height: constraints.maxHeight - 20,
                    child: Formatting.getCivicPhoto(official),
                  );
                },
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Styles.blue,
                    ),
                    child: Icon(Icons.navigate_next,
                        size: 40, color: Colors.white),
                  )),
              Positioned(
                bottom: 35,
                left: 10,
                width: MediaQuery.of(context).size.width * .65,
                child: ListTile(
                  title: Text(
                    official.name,
                    style:
                        TextStyle(fontSize: 20, color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 4.0),
                    ]),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.room,
                        color: Colors.white,
                        size: 18,
                      ),
                      Text(
                        getOffice(response, official).name,
                        style: TextStyle(color: Colors.white, shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 4.0),
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ])));
  }

  Widget listWidget() {
    return FutureBuilder<Response>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return Results.noInternet();
        } else if (snapshot.connectionState == ConnectionState.active) {
          return Results.query();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.officials.length,
                itemBuilder: (context, index) {
                  final Official official = snapshot.data!.officials[index];
                  return buildResult(snapshot.data!, official);
                });
          } else if (snapshot.hasError) {
            return Results.empty();
          } else {
            return Results.empty();
          }
        } else {
          return Loading(loadingMessage: 'finding representatives');
        }
      },
      future: getMembers(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 10,
        child: Container(
            padding: EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height - 100,
            width: MediaQuery.of(context).size.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                  Widget>[
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Styles.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            )),
                        child: TextField(
                            controller: addressController,
                            autofocus: true,
                            style: Styles.search,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon:
                                    Icon(Icons.search, color: Styles.white),
                                hintText: 'Enter address',
                                hintStyle: Styles.search),
                            onSubmitted: (value) {
                              setState(() {
                                addressSet = value.isNotEmpty;
                              });
                            }))),
                InkWell(
                    child: Container(
                        width: 50,
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 3),
                        alignment: Alignment.center,
                        child: Icon(Icons.gps_fixed,
                            size: 40, color: Styles.primaryColor)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlacePicker(
                                  apiKey: Constants.geoKey,
                                  onPlacePicked: (result) {
                                    selectedPlace = result;
                                    addressController.text =
                                        result.formattedAddress ?? '';
                                    Navigator.of(context).pop();
                                    setState(() {
                                      addressSet = true;
                                    });
                                  },
                                  initialPosition: MainContent.kInitialPosition,
                                  useCurrentLocation: true)));
                    })
              ]),
              Expanded(child: addressSet ? listWidget() : Results.ready()),
              widget.isPortrait ? BottomBar(callback: this.callback) : Row()
            ])));
  }
}
