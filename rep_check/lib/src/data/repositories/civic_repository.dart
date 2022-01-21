import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rep_check/env_config.dart';
import 'package:rep_check/src/data/models/representative_response.dart';
import 'package:rep_check/src/utils/constants.dart';

class CivicRepository {
  Future<Response> fetchMemberList(
      String levels, String roles, String address) async {
    if (address.length < 10) {
      return Response.fromJson(jsonDecode(''));
    } else {
      String fullUrl = EnvConfig.apiUrl +
          Constants.representatives +
          Constants.query +
          Constants.key +
          Constants.apiKey +
          (roles != '' ? (Constants.amp + roles) : '') +
          (levels != '' ? (Constants.amp + levels) : '') +
          Constants.amp +
          Constants.address +
          address.replaceAll(' ', '+');

      final response = await http.get(Uri.parse(fullUrl));

      if (response.statusCode == 200) {
        return Response.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to retrieve members');
      }
    }
  }
}
