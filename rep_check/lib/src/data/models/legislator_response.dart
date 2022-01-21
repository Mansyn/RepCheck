import 'opensecrets/legislator/response.dart';

class LegislatorResponse {
  Response? response;

  LegislatorResponse({this.response});

  LegislatorResponse.fromJson(Map<String, dynamic> json) {
    response =
        json['response'] == null ? null : Response.fromJson(json['response']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) data['response'] = response?.toJson();
    return data;
  }
}
