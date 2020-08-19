import 'dart:async';

import 'package:rep_check/data/model/member.dart';
import 'package:rep_check/data/network/api_provider.dart';

class MemberRepository {
  ApiProvider _provider = ApiProvider();

  final String publicaBaseUrl;
  final String publicaKey;

  MemberRepository(this.publicaBaseUrl, this.publicaKey);

  Future<MemberResponse> fetchSenators(String state) async {
    final response = await _provider.get(
        this.publicaBaseUrl + "members/senate/" + state + "/current.json",
        this.publicaKey);
    return MemberResponse.fromJson(response);
  }
}
