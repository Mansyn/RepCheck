import 'contributors.dart';

class Response {
  Contributors? contributors;

  Response({this.contributors});

  Response.fromJson(Map<String, dynamic> json) {
    this.contributors = json['contributors'] == null
        ? null
        : Contributors.fromJson(json['contributors']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contributors != null)
      data['contributors'] = this.contributors?.toJson();
    return data;
  }
}
