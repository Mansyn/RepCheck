import 'contributors.dart';

class Response {
  Contributors contributors;

  Response({this.contributors});

  Response.fromJson(Map<String, dynamic> json) {
    contributors = json['contributors'] != null
        ? new Contributors.fromJson(json['contributors'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contributors != null) {
      data['contributors'] = this.contributors.toJson();
    }
    return data;
  }
}
