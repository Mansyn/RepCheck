import 'dart:async';

import 'package:rep_check/api/api_response.dart';
import 'package:rep_check/blocs/bloc.dart';
import 'package:rep_check/models/member.dart';
import 'package:rep_check/repositories/members_repository.dart';

class AllMemberBloc implements Bloc {
  MemberRepository _memberRepository;

  StreamController _memberListController;

  String _chamber;

  StreamSink<ApiResponse<List<Member>>> get memberListSink =>
      _memberListController.sink;

  Stream<ApiResponse<List<Member>>> get memberListStream =>
      _memberListController.stream;

  AllMemberBloc(String chamber) {
    _chamber = chamber;
    _memberListController = StreamController<ApiResponse<List<Member>>>();
    _memberRepository = MemberRepository();
    fetchMembersList();
  }

  fetchMembersList() async {
    memberListSink.add(ApiResponse.loading('Fetching All Members'));
    try {
      List<Member> members = await _memberRepository.fetchMemberList(_chamber);
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
