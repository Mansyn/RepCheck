import 'package:rep_check/api/api_base_helper.dart';
import 'package:rep_check/models/member.dart';
import 'package:rep_check/responses/member_response.dart';
import 'package:rep_check/utils/constants.dart';

class MemberRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Member>> fetchMemberList(String chamber) async {
    String fullUrl = Constants.apiBaseUrl +
        Constants.session +
        Constants.sep +
        (chamber == 'SENATE' ? Constants.senate : Constants.house) +
        Constants.sep +
        Constants.members +
        '.json';
    final response = await _helper.get(fullUrl, Constants.apiHeaders);
    return MemberResponse.fromJson(response).results[0].members;
  }

  Future<List<Member>> fetchStateMemberList(
      String chamber, String state) async {
    String fullUrl = Constants.apiBaseUrl +
        Constants.members +
        Constants.sep +
        (chamber == 'SENATE' ? Constants.senate : Constants.house) +
        Constants.sep +
        state +
        Constants.current +
        '.json';
    final response = await _helper.get(fullUrl, Constants.apiHeaders);
    return MemberResponse.fromJson(response).results[0].members;
  }
}
