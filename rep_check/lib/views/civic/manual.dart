import 'package:flutter/material.dart';
import 'package:rep_check/api/api_response.dart';
import 'package:rep_check/responses/civic/representative_response.dart';
import 'package:rep_check/responses/maps/place_response.dart';
import 'package:rep_check/views/partials/api_error.dart';
import 'package:rep_check/views/partials/loading.dart';
import 'package:rep_check/blocs/district_civic_bloc.dart';
import 'package:rep_check/utils/enums.dart';
import 'package:rep_check/utils/styles.dart';

import 'list.dart';

class CivicManualPage extends StatefulWidget {
  CivicManualPage(this.query, this.body, this.title, this.place);

  final Query query;
  final Body body;
  final String title;
  final PlaceResponse place;
  @override
  _CivicManualPageState createState() => _CivicManualPageState();
}

class _CivicManualPageState extends State<CivicManualPage> {
  DistrictCivicBloc _districtbloc;

  @override
  void initState() {
    super.initState();
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

  String _buildAddress() {
    return widget.place.streetNumber +
        ' ' +
        widget.place.street +
        ', ' +
        widget.place.city +
        ', ' +
        widget.place.state +
        ' ' +
        widget.place.zipCode;
  }

  @override
  Widget build(BuildContext context) {
    _districtbloc = DistrictCivicBloc(_getQuery(), _getBody(), _buildAddress());
    return Scaffold(
        appBar: AppBar(title: Text(widget.title, style: Styles.h1AppBar)),
        body: OrientationBuilder(builder: (context, orientation) {
          return Container(
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
                                  state: widget.place.state,
                                  orientation: orientation);
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
                      })));
        }));
  }
}
