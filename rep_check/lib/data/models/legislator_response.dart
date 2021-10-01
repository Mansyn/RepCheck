import 'opensecrets/legislator/response.dart';

class LegislatorResponse {
  Response? response;

  LegislatorResponse({this.response});

  LegislatorResponse.fromJson(Map<String, dynamic> json) {
    this.response =
        json['response'] == null ? null : Response.fromJson(json['response']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) data['response'] = this.response?.toJson();
    return data;
  }
}
