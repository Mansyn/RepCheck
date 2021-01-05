import 'attributes.dart';

class Legislator {
  Attributes attributes;

  Legislator({this.attributes});

  Legislator.fromJson(Map<String, dynamic> json) {
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
