import 'dart:async';

import 'package:geocoder/model.dart';
import 'package:rep_check/api/api_response.dart';
import 'package:rep_check/blocs/bloc.dart';
import 'package:rep_check/repositories/members_repository.dart';
import 'package:rep_check/responses/civic/representative_response.dart';

class DistrictMemberBloc implements Bloc {
  MemberRepository _memberRepository;

  StreamController _memberListController;

  String _query;

  String _body;

  Address _address;

  StreamSink<ApiResponse<RepresentativeResponse>> get memberListSink =>
      _memberListController.sink;

  Stream<ApiResponse<RepresentativeResponse>> get memberListStream =>
      _memberListController.stream;

  DistrictMemberBloc(String query, String body, Address address) {
    _query = query;
    _body = body;
    _address = address;
    _memberListController =
        StreamController<ApiResponse<RepresentativeResponse>>();
    _memberRepository = MemberRepository();
    fetchMembersList();
  }

  fetchMembersList() async {
    memberListSink.add(ApiResponse.loading('fetching district members'));
    try {
      final members = await _memberRepository.fetchAddressMemberList(
          _query, _body, _address);
      memberListSink.add(ApiResponse.completed(members));
    } catch (e) {
      memberListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _memberListController?.close();
  }
}
