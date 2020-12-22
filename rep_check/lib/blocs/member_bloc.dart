import 'dart:async';

import 'package:rep_check/api/api_response.dart';
import 'package:rep_check/blocs/bloc.dart';
import 'package:rep_check/models/propublica/member_details.dart';
import 'package:rep_check/repositories/members_repository.dart';

class MemberBloc implements Bloc {
  MemberRepository _memberRepository;

  StreamController _memberController;

  String _id;

  StreamSink<ApiResponse<MemberDetails>> get memberSink =>
      _memberController.sink;

  Stream<ApiResponse<MemberDetails>> get memberStream =>
      _memberController.stream;

  MemberBloc(String id) {
    _id = id;
    _memberController = StreamController<ApiResponse<MemberDetails>>();
    _memberRepository = MemberRepository();
    fetchMember();
  }

  fetchMember() async {
    memberSink.add(ApiResponse.loading('fetching member'));
    try {
      MemberDetails members = await _memberRepository.fetchMember(_id);
      memberSink.add(ApiResponse.completed(members));
    } catch (e) {
      memberSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _memberController?.close();
  }
}
