import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:rep_check/api/api_response.dart';
import 'package:rep_check/blocs/location_bloc.dart';
import 'package:rep_check/blocs/all_member_bloc.dart';
import 'package:rep_check/blocs/state_member_bloc.dart';
import 'package:rep_check/models/member.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/query.dart';
import 'package:rep_check/views/members/state_list.dart';
import 'package:rep_check/views/partials/api_error.dart';
import 'package:rep_check/views/partials/loading.dart';

import 'list.dart';

class MembersIndexPage extends StatefulWidget {
  MembersIndexPage(this.chamber, this.query);

  final String chamber;
  final Query query;

  @override
  _MembersIndexPageState createState() => _MembersIndexPageState();
}

class _MembersIndexPageState extends State<MembersIndexPage> {
  AllMemberBloc _allbloc;
  StateMemberBloc _statebloc;
  String _state;

  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionStatus;

  @override
  void initState() {
    switch (widget.query) {
      case Query.full:
        _allbloc = AllMemberBloc(widget.chamber);
        break;
      case Query.state:
        checkPermission();
        break;
      case Query.district:
        checkPermission();
        break;
    }
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

    print('location service enbabled: ' + _serviceEnabled.toString());
    print('location permission: ' + _permissionStatus.toString());

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
      _state = location.adminArea != null ? location.adminArea : 'DC';
    });
  }

  @override
  void dispose() {
    _allbloc.dispose();
    _statebloc.dispose();
    super.dispose();
  }

  Widget buildFull() {
    return Scaffold(
      appBar: AppBar(
        title: Text("ENTIRE " + widget.chamber),
      ),
      body: Container(
        padding: EdgeInsets.all(Constants.commonPadding),
        child: RefreshIndicator(
          onRefresh: () => _allbloc.fetchMembersList(),
          child: StreamBuilder<ApiResponse<List<Member>>>(
            stream: _allbloc.memberListStream,
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
                        .sort((a, b) => a.state.compareTo(b.state));
                    return MemberList(memberList: snapshot.data.data);
                    break;
                  case Status.ERROR:
                    return ApiError(
                      errorMessage: snapshot.data.message,
                      onRetryPressed: () => _allbloc.fetchMembersList(),
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

  Widget buildState() {
    switch (_permissionStatus) {
      case PermissionStatus.granted:
      case PermissionStatus.grantedLimited:
        if (_state == null) {
          this._fetchLocation();
          return Scaffold(
              appBar: AppBar(
                title: Text(""),
              ),
              body: Container(
                  padding: EdgeInsets.all(Constants.commonPadding),
                  child: Loading(loadingMessage: 'getting your location...')));
        } else {
          _statebloc = StateMemberBloc(widget.chamber, _state);
          return Scaffold(
            appBar: AppBar(
              title: Text(_state.toUpperCase() + " " + widget.chamber),
            ),
            body: Container(
              padding: EdgeInsets.all(Constants.commonPadding),
              child: RefreshIndicator(
                onRefresh: () => _statebloc.fetchMembersList(),
                child: StreamBuilder<ApiResponse<List<Member>>>(
                  stream: _statebloc.memberListStream,
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
                              .sort((a, b) => a.lastName.compareTo(b.lastName));
                          return StateMemberList(
                              memberList: snapshot.data.data, state: _state);
                          break;
                        case Status.ERROR:
                          return ApiError(
                            errorMessage: snapshot.data.message,
                            onRetryPressed: () => _statebloc.fetchMembersList(),
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

  @override
  Widget build(BuildContext context) {
    switch (widget.query) {
      case Query.full:
        return buildFull();
        break;
      case Query.state:
        return buildState();
        break;
      case Query.district:
        return buildState();
        break;
      default:
        return buildFull();
    }
  }
}
