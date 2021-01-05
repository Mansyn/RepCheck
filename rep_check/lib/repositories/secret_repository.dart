import 'package:flutter_config/flutter_config.dart';
import 'package:rep_check/api/api_base_helper.dart';
import 'package:rep_check/env_config.dart';
import 'package:rep_check/responses/opensecrets/contributor_response.dart';
import 'package:rep_check/responses/opensecrets/legislator_response.dart';
import 'package:rep_check/utils/constants.dart';

class SecretRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  static String osKey = '16ee0542d73bd5405d5354b5fc368253';

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
        osKey;
    print(fullUrl);
    final response = await _helper.get(fullUrl, Constants.headers);
    return LegislatorResponse.fromJson(response);
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
        osKey;
    print(fullUrl);
    final response = await _helper.get(fullUrl, Constants.headers);
    return ContributorResponse.fromJson(response);
  }
}
