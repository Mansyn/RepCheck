import 'package:flutter/material.dart';
import 'package:geocoder/model.dart';
import 'package:rep_check/api/api_response.dart';
import 'package:rep_check/blocs/district_civic_bloc.dart';
import 'package:rep_check/responses/civic/representative_response.dart';
import 'package:rep_check/utils/enums.dart';
import 'package:rep_check/utils/styles.dart';
import 'package:rep_check/views/partials/api_error.dart';
import 'package:rep_check/views/partials/loading.dart';
import 'list.dart';

class CivicAutoPage extends StatefulWidget {
  CivicAutoPage(this.query, this.body, this.title, this.address);

  final Query query;
  final Body body;
  final String title;
  final Address address;

  @override
  _CivicAutoPageState createState() => _CivicAutoPageState();
}

class _CivicAutoPageState extends State<CivicAutoPage> {
  DistrictCivicBloc _districtbloc;

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
    _districtbloc =
        DistrictCivicBloc(_getQuery(), _getBody(), widget.address.addressLine);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: Styles.h1AppBar),
        ),
        body: Container(
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
                                state: widget.address.adminArea);
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
                    }))));
  }
}
