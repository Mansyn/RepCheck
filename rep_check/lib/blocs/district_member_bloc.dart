import 'dart:async';

import 'package:geocoder/model.dart';
import 'package:rep_check/api/api_response.dart';
import 'package:rep_check/blocs/bloc.dart';
import 'package:rep_check/models/civic/official.dart';
import 'package:rep_check/repositories/members_repository.dart';

class DistrictMemberBloc implements Bloc {
  MemberRepository _memberRepository;

  StreamController _memberListController;

  String _body;

  Address _address;

  StreamSink<ApiResponse<List<Official>>> get memberListSink =>
      _memberListController.sink;

  Stream<ApiResponse<List<Official>>> get memberListStream =>
      _memberListController.stream;

  DistrictMemberBloc(String body, Address address) {
    _body = body;
    _address = address;
    _memberListController = StreamController<ApiResponse<List<Official>>>();
    _memberRepository = MemberRepository();
    fetchMembersList();
  }

  fetchMembersList() async {
    memberListSink.add(ApiResponse.loading('fetching district members'));
    try {
      final members =
          await _memberRepository.fetchAddressMemberList(_body, _address);
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
