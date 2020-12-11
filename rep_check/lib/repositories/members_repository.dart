import 'package:rep_check/api/api_base_helper.dart';
import 'package:rep_check/models/member.dart';
import 'package:rep_check/models/member_details.dart';
import 'package:rep_check/responses/all_member_response.dart';
import 'package:rep_check/responses/member_response.dart';
import 'package:rep_check/responses/state_member_response.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:us_states/us_states.dart';

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
    print(fullUrl);
    final response = await _helper.get(fullUrl, Constants.apiHeaders);
    return AllMemberResponse.fromJson(response).results[0].members;
  }

  Future<List<Member>> fetchStateMemberList(
      String chamber, String state) async {
    String stateCode = USStates.getAbbreviation(state);
    String fullUrl = Constants.apiBaseUrl +
        Constants.members +
        Constants.sep +
        (chamber == 'SENATE' ? Constants.senate : Constants.house) +
        Constants.sep +
        stateCode +
        Constants.sep +
        Constants.current +
        '.json';
    print(fullUrl);
    final response = await _helper.get(fullUrl, Constants.apiHeaders);
    return StateMemberResponse.fromJson(response).results;
  }

  Future<MemberDetails> fetchMember(String id) async {
    String fullUrl =
        Constants.apiBaseUrl + Constants.members + Constants.sep + id + '.json';
    print(fullUrl);
    final response = await _helper.get(fullUrl, Constants.apiHeaders);
    print(response);
    return MemberResponse.fromJson(response).results[0];
  }
}
