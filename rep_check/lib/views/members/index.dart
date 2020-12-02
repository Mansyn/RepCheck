import 'package:flutter/material.dart';
import 'package:geocoder/model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rep_check/api/api_response.dart';
import 'package:rep_check/blocs/location_bloc.dart';
import 'package:rep_check/blocs/member_bloc.dart';
import 'package:rep_check/models/member.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:rep_check/utils/query.dart';
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
  MemberBloc _bloc;
  String _state;
  Coordinates _coordinates;

  Permission _permission = Permission.location;
  PermissionStatus _permissionStatus = PermissionStatus.undetermined;

  @override
  void initState() {
    super.initState();

    switch (widget.query) {
      case Query.full:
        _bloc = MemberBloc(widget.chamber);
        break;
      case Query.state:
        _listenForPermissionStatus();
        break;
      case Query.district:
        _listenForPermissionStatus();
        break;
    }
  }

  void _listenForPermissionStatus() async {
    final status = await _permission.status;
    setState(() => _permissionStatus = status);
  }

  Future<void> _requestPermission(Permission permission) async {
    final status = await permission.request();

    setState(() {
      print(status);
      _permissionStatus = status;
      print(_permissionStatus);
    });
  }

  Future<void> _fetchLocation() async {
    final location = await LocationBloc().fetchLocation();

    setState(() {
      _state = location.adminArea != null ? location.adminArea : 'DC';
      _coordinates = location.coordinates;
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Widget buildFull() {
    return Scaffold(
      appBar: AppBar(
        title: Text("ALL " + widget.chamber + " MEMBERS"),
      ),
      body: Container(
        padding: EdgeInsets.all(Constants.commonPadding),
        child: RefreshIndicator(
          onRefresh: () => _bloc.fetchMembersList(widget.chamber),
          child: StreamBuilder<ApiResponse<List<Member>>>(
            stream: _bloc.memberListStream,
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
                      onRetryPressed: () =>
                          _bloc.fetchMembersList(widget.chamber),
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
    if (!_permissionStatus.isGranted) {
      this._requestPermission(_permission);
      return Loading(loadingMessage: 'need your permission...');
    } else {
      if (_state == null) {
        this._fetchLocation();
        return Loading(loadingMessage: 'need your location...');
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text(_state + " " + widget.chamber + " MEMBERS"),
          ),
          body: Container(
            padding: EdgeInsets.all(Constants.commonPadding),
            child: RefreshIndicator(
              onRefresh: () =>
                  _bloc.fetchStateMembersList(widget.chamber, _state),
              child: StreamBuilder<ApiResponse<List<Member>>>(
                stream: _bloc.memberListStream,
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
                          onRetryPressed: () => _bloc.fetchStateMembersList(
                              widget.chamber, _state),
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
