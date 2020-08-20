import 'dart:async';

import 'package:rep_check/data/model/legislator.dart';
import 'package:rep_check/data/network/response.dart';
import 'package:rep_check/data/repository/member_repository.dart';
import 'package:rep_check/state/shared_state.dart';

class MemberBloc {
  MemberRepository _memberRepository;
  StreamController _memberListController;

  final SharedState state;

  StreamSink<Response<List<Legislator>>> get memberListSink =>
      _memberListController.sink;

  Stream<Response<List<Legislator>>> get memberListStream =>
      _memberListController.stream;

  MemberBloc(this.state) {
    _memberListController = StreamController<Response<List<Legislator>>>();
    _memberRepository = MemberRepository(state.apiUrl, state.apiKey);
    fetchMembers();
  }

  fetchMembers() async {
    memberListSink.add(Response.loading('Getting Members.'));
    try {
      List<Legislator> members =
          await _memberRepository.fetchYourMembers(this.state.coordinates);
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
