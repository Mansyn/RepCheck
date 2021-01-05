import 'package:flutter/material.dart';
import 'package:geocoder/model.dart';
import 'package:location/location.dart';
import 'package:rep_check/api/api_response.dart';
import 'package:rep_check/blocs/district_civic_bloc.dart';
import 'package:rep_check/blocs/location_bloc.dart';
import 'package:rep_check/blocs/opensecret_bloc.dart';
import 'package:rep_check/models/opensecrets/legislator/legislator.dart';
import 'package:rep_check/responses/civic/representative_response.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/enums.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/views/partials/api_error.dart';
import 'package:rep_check/views/partials/loading.dart';
import 'package:us_states/us_states.dart';
import 'list.dart';

class CivicIndexPage extends StatefulWidget {
  CivicIndexPage(this.query, this.body, this.title);

  final Query query;
  final Body body;
  final String title;
  @override
  _CivicIndexPageState createState() => _CivicIndexPageState();
}

class _CivicIndexPageState extends State<CivicIndexPage> {
  DistrictCivicBloc _districtbloc;
  Address _address;

  Location location = new Location();
  PermissionStatus _permissionStatus;

  @override
  void initState() {
    checkPermission();
    super.initState();
  }

  Future<bool> checkPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionStatus;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        Navigator.of(context).pop();
      }
    }

    permissionStatus = await location.hasPermission();

    setState(() => {_permissionStatus = permissionStatus});

    return _permissionStatus == PermissionStatus.granted ||
        _permissionStatus == PermissionStatus.grantedLimited;
  }

  Future<void> _requestPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _permissionStatus = permissionStatus;
      print('location permission requested - result: ' +
          _permissionStatus.toString());
    });
  }

  Future<void> _fetchLocation() async {
    final location = await LocationBloc().fetchLocation();

    setState(() {
      _address = location;
    });
  }

  @override
  void dispose() {
    _districtbloc.dispose();
    super.dispose();
  }

  String _getBody() {
    switch (widget.body) {
      case Body.upper:
        return 'legislatorUpperBody';
        break;
      case Body.lower:
        return 'legislatorLowerBody';
        break;
      default:
        return 'legislatorUpperBody';
    }
  }

  String _getQuery() {
    switch (widget.query) {
      case Query.state:
        return 'administrativeArea1';
        break;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_permissionStatus) {
      case PermissionStatus.granted:
      case PermissionStatus.grantedLimited:
        if (_address == null) {
          this._fetchLocation();
          return Scaffold(
              appBar: AppBar(
                title: Text(""),
              ),
              body: Container(
                  padding: EdgeInsets.all(Constants.commonPadding),
                  child: Loading(loadingMessage: 'getting your location...')));
        } else {
          _districtbloc = DistrictCivicBloc(_getQuery(), _getBody(), _address);
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title, style: Styles.h1AppBar),
            ),
            body: Container(
              padding: EdgeInsets.all(Constants.commonPadding),
              child: RefreshIndicator(
                onRefresh: () => _districtbloc.fetchMembersList(),
                child: StreamBuilder<ApiResponse<RepresentativeResponse>>(
                  stream: _districtbloc.civicListStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(
                            loadingMessage: snapshot.data.message,
                          );
                          break;
                        case Status.COMPLETED:
                          return OfficialList(
                              response: snapshot.data.data,
                              state: _address.adminArea);
                          break;
                        case Status.ERROR:
                          return ApiError(
                            errorMessage: snapshot.data.message,
                            onRetryPressed: () =>
                                _districtbloc.fetchMembersList(),
                          );
                          break;
                      }
                    }
                    return Container();
                  },
                ),
              ),
            ),
          );
        }
        break;
      default:
        this._requestPermission();
        return Loading(loadingMessage: 'need your permission...');
        break;
    }
  }
}
