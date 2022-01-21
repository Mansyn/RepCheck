import 'opensecrets/contributor/response.dart';

class ContributorResponse {
  Response? response;

  ContributorResponse({this.response});

  ContributorResponse.fromJson(Map<String, dynamic> json) {
    response =
        json['response'] == null ? null : Response.fromJson(json['response']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) data['response'] = response?.toJson();
    return data;
  }
}
