import 'package:rep_check/api/api_base_helper.dart';
import 'package:rep_check/env_config.dart';
import 'package:rep_check/responses/opensecrets/contributor_response.dart';
import 'package:rep_check/responses/opensecrets/legislator_response.dart';
import 'package:rep_check/utils/constants.dart';

class SecretRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

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
        Constants.osApiKey;
    print(fullUrl);
    final response = await _helper.get(fullUrl, Constants.headers);
    return ContributorResponse.fromJson(response);
  }
}
