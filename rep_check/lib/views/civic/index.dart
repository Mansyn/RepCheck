import 'package:flutter/material.dart';
import 'package:geocoder/model.dart';
import 'package:location/location.dart';
import 'package:rep_check/api/api_response.dart';
import 'package:rep_check/blocs/district_member_bloc.dart';
import 'package:rep_check/blocs/location_bloc.dart';
import 'package:rep_check/models/civic/official.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/enums.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/views/partials/api_error.dart';
import 'package:rep_check/views/partials/loading.dart';

import 'list.dart';

class CivicIndexPage extends StatefulWidget {
  CivicIndexPage(this.query, this.body);

  final Query query;
  final Body body;

  @override
  _CivicIndexPageState createState() => _CivicIndexPageState();
}

class _CivicIndexPageState extends State<CivicIndexPage> {
  DistrictMemberBloc _districtbloc;
  Address _address;

  Location location = new Location();
  bool _serviceEnabled;
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

    setState(() => {
          _permissionStatus = permissionStatus,
          _serviceEnabled = serviceEnabled
        });

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

  String _getQuery() {
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
          _districtbloc = DistrictMemberBloc(_getQuery(), _address);
          return Scaffold(
            appBar: AppBar(
              title: Text('Federal Upper Body', style: Styles.h1AppBar),
            ),
            body: Container(
              padding: EdgeInsets.all(Constants.commonPadding),
              child: RefreshIndicator(
                onRefresh: () => _districtbloc.fetchMembersList(),
                child: StreamBuilder<ApiResponse<List<Official>>>(
                  stream: _districtbloc.memberListStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                          return Loading(
                            loadingMessage: snapshot.data.message,
                          );
                          break;
                        case Status.COMPLETED:
                          snapshot.data.data
                              .sort((a, b) => a.name.compareTo(b.name));
                          return OfficialList(
                              list: snapshot.data.data, address: _address);
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
