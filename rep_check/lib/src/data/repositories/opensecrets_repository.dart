import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rep_check/env_config.dart';
import 'package:rep_check/src/data/models/contributor_response.dart';
import 'package:rep_check/src/data/models/legislator_response.dart';
import 'package:rep_check/src/data/models/summary_response.dart';
import 'package:rep_check/src/utils/constants.dart';

class SecretRepository {
  Future<LegislatorResponse> fetchLegislators(String state) async {
    String fullUrl = EnvConfig.osUrl +
        Constants.query +
        Constants.method +
        Constants.getLegs +
        Constants.amp +
        Constants.id +
        state +
        Constants.amp +
        Constants.outputJson +
        Constants.amp +
        Constants.apikey +
        Constants.osApiKey;

    final response = await http.get(Uri.parse(fullUrl));

    if (response.statusCode == 200) {
      return LegislatorResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch legislators');
    }
  }

  Future<ContributorResponse> fetchContributors(String id) async {
    String fullUrl = EnvConfig.osUrl +
        Constants.query +
        Constants.method +
        Constants.candContrib +
        Constants.amp +
        Constants.cid +
        id +
        Constants.amp +
        Constants.outputJson +
        Constants.amp +
        Constants.apikey +
        Constants.osApiKey;

    final response =
        await http.get(Uri.parse(fullUrl)).timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      return ContributorResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch legislator');
    }
  }

  Future<SummaryResponse> fetchSummary(String id) async {
    String fullUrl = EnvConfig.osUrl +
        Constants.query +
        Constants.method +
        Constants.candSummary +
        Constants.amp +
        Constants.cid +
        id +
        Constants.amp +
        Constants.outputJson +
        Constants.amp +
        Constants.apikey +
        Constants.osApiKey;

    final response =
        await http.get(Uri.parse(fullUrl)).timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      return SummaryResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch legislator summary');
    }
  }
}
