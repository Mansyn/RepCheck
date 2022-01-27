import 'dart:convert';

import 'package:rep_check/env_config.dart';
import 'package:rep_check/src/data/models/representative_response.dart';
import 'package:rep_check/src/data/providers/http_provider.dart';
import 'package:rep_check/src/utils/constants.dart';

class CivicRepository {
  HttpProvider httpProvider = HttpProvider();

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

      final response = await httpProvider.getData(fullUrl, Constants.headers);

      if (response.statusCode == 200) {
        return Response.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to retrieve members');
      }
    }
  }
}
