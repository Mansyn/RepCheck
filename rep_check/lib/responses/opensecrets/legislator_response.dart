import 'package:rep_check/models/opensecrets/legislator/response.dart';

class LegislatorResponse {
  Response response;

  LegislatorResponse({this.response});

  LegislatorResponse.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    return data;
  }
}
