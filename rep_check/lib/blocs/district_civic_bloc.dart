import 'dart:async';

import 'package:geocoder/model.dart';
import 'package:rep_check/api/api_response.dart';
import 'package:rep_check/blocs/bloc.dart';
import 'package:rep_check/repositories/civic_repository.dart';
import 'package:rep_check/responses/civic/representative_response.dart';

class DistrictCivicBloc implements Bloc {
  CivicRepository _civicRepository;

  StreamController _civicListController;

  String _query;

  String _body;

  String _address;

  StreamSink<ApiResponse<RepresentativeResponse>> get civicListSink =>
      _civicListController.sink;

  Stream<ApiResponse<RepresentativeResponse>> get civicListStream =>
      _civicListController.stream;

  DistrictCivicBloc(String query, String body, String address) {
    _query = query;
    _body = body;
    _address = address;
    _civicListController =
        StreamController<ApiResponse<RepresentativeResponse>>();
    _civicRepository = CivicRepository();
    fetchMembersList();
  }

  fetchMembersList() async {
    civicListSink.add(ApiResponse.loading('fetching members'));
    try {
      final members = await _civicRepository.fetchAddressMemberList(
          _query, _body, _address);
      civicListSink.add(ApiResponse.completed(members));
    } catch (e) {
      civicListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _civicListController?.close();
  }
}
