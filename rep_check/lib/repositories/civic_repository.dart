import 'package:rep_check/api/api_base_helper.dart';
import 'package:rep_check/env_config.dart';
import 'package:rep_check/responses/civic/representative_response.dart';
import 'package:rep_check/utils/constants.dart';

class CivicRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<RepresentativeResponse> fetchAddressMemberList(
      String query, String body, String address) async {
    String fullUrl = EnvConfig.apiUrl +
        Constants.representatives +
        Constants.query +
        Constants.key +
        Constants.apiKey +
        Constants.amp +
        Constants.roles +
        body +
        (query != '' ? (Constants.amp + Constants.levels + query) : '') +
        Constants.amp +
        Constants.address +
        address.replaceAll(' ', '+');
    print(fullUrl);
    final response = await _helper.get(fullUrl, Constants.headers);
    return RepresentativeResponse.fromJson(response);
  }
}
