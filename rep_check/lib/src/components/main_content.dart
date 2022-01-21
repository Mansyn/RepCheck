import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';
import 'package:rep_check/src/components/loading.dart';
import 'package:rep_check/src/data/models/civic/office.dart';
import 'package:rep_check/src/data/models/civic/official.dart';
import 'package:rep_check/src/data/models/representative_response.dart';
import 'package:rep_check/src/data/repositories/civic_repository.dart';
import 'package:rep_check/src/pages/details.dart';
import 'package:rep_check/src/utils/constants.dart';
import 'package:rep_check/src/utils/enums.dart';
import 'package:rep_check/src/utils/formatting.dart';
import 'package:rep_check/src/utils/styles.dart';

import 'bottom_bar.dart';
import 'result_ready.dart';

class MainContent extends StatefulWidget {
  final bool isPortrait;

  const MainContent({Key? key, required this.isPortrait}) : super(key: key);

  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  CivicRepository civicRepository = CivicRepository();

  Level level = Level.full;
  Role role = Role.full;
  bool addressSet = false;

  LocationResult selectedPlace = LocationResult();

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

  void tabChange(int index) {
    switch (index) {
      case 0:
        setState(() {
          level = Level.full;
          role = Role.full;
        });
        break;
      case 1:
        setState(() {
          level = Level.country;
          role = Role.full;
        });
        break;
      case 2:
        setState(() {
          level = Level.admin1;
          role = Role.full;
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

    for (var office in response.offices) {
      if (office.officialIndices.contains(index)) {
        _office = office;
      }
    }

    return _office;
  }

  InkWell buildResult(Response response, Official official) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
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
                return SizedBox(
                    width: MediaQuery.of(context).size.width * .65,
                    height: constraints.maxHeight - 20,
                    child: Formatting.getCivicPhoto(official));
              }),
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
                      child: const Icon(Icons.navigate_next,
                          size: 40, color: Colors.white))),
              Positioned(
                bottom: 35,
                left: 10,
                width: MediaQuery.of(context).size.width * .65,
                child: ListTile(
                  title: Text(
                    official.name,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 4.0)
                        ]),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(Icons.room, color: Colors.white, size: 18),
                      Text(
                        getOffice(response, official).name,
                        style: const TextStyle(color: Colors.white, shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 4.0)
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
          if (snapshot.hasData && snapshot.data!.officials.isNotEmpty) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.officials.length,
                itemBuilder: (context, index) {
                  final Official official = snapshot.data!.officials[index];
                  return buildResult(snapshot.data!, official);
                });
          } else {
            return Results.empty();
          }
        } else {
          return const Loading(loadingMessage: 'finding representatives');
        }
      },
      future: getMembers(),
    );
  }

  void showPlacePicker() async {
    if (selectedPlace.latLng != null) {
      LocationResult result =
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlacePicker(
                    Constants.geoKey,
                    displayLocation: selectedPlace.latLng,
                  )));
      setState(() {
        addressController.text = result.formattedAddress ?? '';
        selectedPlace = result;
        addressSet = true;
      });
    } else {
      LocationResult result = await Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => PlacePicker(Constants.geoKey)));
      setState(() {
        addressController.text = result.formattedAddress ?? '';
        selectedPlace = result;
        addressSet = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 10,
        child: Container(
            padding: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height - 100,
            width: MediaQuery.of(context).size.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Styles.primaryColor,
                                borderRadius: const BorderRadius.only(
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
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 3),
                            alignment: Alignment.center,
                            child: Icon(Icons.gps_fixed,
                                size: 40, color: Styles.primaryColor)),
                        onTap: () {
                          showPlacePicker();
                        })
                  ]),
              Expanded(child: addressSet ? listWidget() : Results.ready()),
              widget.isPortrait ? BottomBar(callback: tabChange) : Row()
            ])));
  }
}
