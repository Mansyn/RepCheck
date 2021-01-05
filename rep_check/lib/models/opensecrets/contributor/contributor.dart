import 'attributes.dart';

class Contributor {
  Attributes attributes;

  Contributor({this.attributes});

  Contributor.fromJson(Map<String, dynamic> json) {
    attributes = json['@attributes'] != null
        ? new Attributes.fromJson(json['@attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributes != null) {
      data['@attributes'] = this.attributes.toJson();
    }
    return data;
  }
}
