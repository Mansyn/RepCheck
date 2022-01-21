import 'contributors.dart';

class Response {
  Contributors? contributors;

  Response({this.contributors});

  Response.fromJson(Map<String, dynamic> json) {
    contributors = json['contributors'] == null
        ? null
        : Contributors.fromJson(json['contributors']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contributors != null) {
      data['contributors'] = contributors?.toJson();
    }
    return data;
  }
}
