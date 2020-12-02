import 'dart:async';

import 'package:rep_check/api/api_response.dart';
import 'package:rep_check/models/member.dart';
import 'package:rep_check/repositories/members_repository.dart';

class MemberBloc {
  MemberRepository _memberRepository;

  StreamController _memberListController;

  StreamSink<ApiResponse<List<Member>>> get memberListSink =>
      _memberListController.sink;

  Stream<ApiResponse<List<Member>>> get memberListStream =>
      _memberListController.stream;

  MemberBloc(String chamber) {
    _memberListController = StreamController<ApiResponse<List<Member>>>();
    _memberRepository = MemberRepository();
    fetchMembersList(chamber);
  }

  fetchMembersList(String chamber) async {
    memberListSink.add(ApiResponse.loading('Fetching All Members'));
    try {
      List<Member> members = await _memberRepository.fetchMemberList(chamber);
      memberListSink.add(ApiResponse.completed(members));
    } catch (e) {
      memberListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchStateMembersList(String chamber, String state) async {
    memberListSink.add(ApiResponse.loading('Fetching State Members'));
    try {
      List<Member> members =
          await _memberRepository.fetchStateMemberList(chamber, state);
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
