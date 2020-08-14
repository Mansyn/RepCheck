import 'dart:async';

import 'package:rep_check/data/model/member.dart';
import 'package:rep_check/data/network/response.dart';
import 'package:rep_check/data/repository/member_repository.dart';
import 'package:rep_check/state/shared_state.dart';

class MemberBloc {
  MemberRepository _memberRepository;
  StreamController _memberListController;

  final SharedState state;

  StreamSink<Response<MemberResponse>> get memberListSink =>
      _memberListController.sink;

  Stream<Response<MemberResponse>> get memberListStream =>
      _memberListController.stream;

  MemberBloc(this.state) {
    _memberListController = StreamController<Response<MemberResponse>>();
    _memberRepository =
        MemberRepository(state.publicaBaseUrl, state.publicaKey);
    fetchMembers();
  }

  fetchMembers() async {
    memberListSink.add(Response.loading('Getting Members.'));
    try {
      MemberResponse members = await _memberRepository.fetchMemberData();
      memberListSink.add(Response.completed(members));
    } catch (e) {
      memberListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _memberListController?.close();
  }
}
