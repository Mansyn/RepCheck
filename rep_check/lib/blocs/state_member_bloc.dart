import 'dart:async';

import 'package:rep_check/api/api_response.dart';
import 'package:rep_check/blocs/bloc.dart';
import 'package:rep_check/models/member.dart';
import 'package:rep_check/repositories/members_repository.dart';

class StateMemberBloc implements Bloc {
  MemberRepository _memberRepository;

  StreamController _memberListController;

  String _chamber;

  String _state;

  StreamSink<ApiResponse<List<Member>>> get memberListSink =>
      _memberListController.sink;

  Stream<ApiResponse<List<Member>>> get memberListStream =>
      _memberListController.stream;

  StateMemberBloc(String chamber, String state) {
    _chamber = chamber;
    _state = state;
    _memberListController = StreamController<ApiResponse<List<Member>>>();
    _memberRepository = MemberRepository();
    fetchMembersList();
  }

  fetchMembersList() async {
    memberListSink.add(ApiResponse.loading('Fetching State Members'));
    try {
      List<Member> members =
          await _memberRepository.fetchStateMemberList(_chamber, _state);
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
