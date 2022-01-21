import 'opensecrets/summary/response.dart';

class SummaryResponse {
  Response? response;

  SummaryResponse({this.response});

  SummaryResponse.fromJson(Map<String, dynamic> json) {
    response =
        json['response'] == null ? null : Response.fromJson(json['response']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) data['response'] = response?.toJson();
    return data;
  }
}
