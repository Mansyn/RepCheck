import 'package:flutter_config/flutter_config.dart';
import 'package:geocoder/model.dart';
import 'package:rep_check/api/api_base_helper.dart';
import 'package:rep_check/env_config.dart';
import 'package:rep_check/models/civic/official.dart';
import 'package:rep_check/models/propublica/member.dart';
import 'package:rep_check/models/propublica/member_details.dart';
import 'package:rep_check/responses/civic/representative_response.dart';
import 'package:rep_check/responses/propublica/all_member_response.dart';
import 'package:rep_check/responses/propublica/member_response.dart';
import 'package:rep_check/responses/propublica/state_member_response.dart';
import 'package:rep_check/utils/constants.dart';
import 'package:us_states/us_states.dart';

class MemberRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  static String osKey = FlutterConfig.get('apiKey');

  Future<List<Member>> fetchMemberList(String chamber) async {
    String fullUrl = EnvConfig.pbApiUrl +
        Constants.session +
        Constants.sep +
        (chamber == 'SENATE' ? Constants.senate : Constants.house) +
        Constants.sep +
        Constants.members +
        '.json';
    print(fullUrl);
    final response = await _helper.get(fullUrl, Constants.pbHeaders);
    return AllMemberResponse.fromJson(response).results[0].members;
  }

  Future<List<Member>> fetchStateMemberList(
      String chamber, String state) async {
    String stateCode = USStates.getAbbreviation(state);
    String fullUrl = EnvConfig.pbApiUrl +
        Constants.members +
        Constants.sep +
        (chamber == 'SENATE' ? Constants.senate : Constants.house) +
        Constants.sep +
        stateCode +
        Constants.sep +
        Constants.current +
        '.json';
    print(fullUrl);
    final response = await _helper.get(fullUrl, Constants.pbHeaders);
    return StateMemberResponse.fromJson(response).results;
  }

  Future<MemberDetails> fetchMember(String id) async {
    String fullUrl =
        EnvConfig.pbApiUrl + Constants.members + Constants.sep + id + '.json';
    print(fullUrl);
    final response = await _helper.get(fullUrl, Constants.pbHeaders);
    return MemberResponse.fromJson(response).results[0];
  }

  Future<List<Official>> fetchAddressMemberList(
      String body, Address address) async {
    String fullUrl = EnvConfig.apiUrl +
        Constants.representatives +
        Constants.query +
        Constants.key +
        osKey +
        Constants.amp +
        Constants.roles +
        body +
        Constants.amp +
        Constants.address +
        address.addressLine.replaceAll(' ', '+');
    print(fullUrl);
    final response = await _helper.get(fullUrl, Constants.headers);
    return RepresentativeResponse.fromJson(response).officials;
  }
}
