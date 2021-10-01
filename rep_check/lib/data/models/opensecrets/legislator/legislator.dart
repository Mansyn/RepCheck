import 'attributes.dart';

class Legislator {
  Attributes? attributes;

  Legislator({this.attributes});

  Legislator.fromJson(Map<String, dynamic> json) {
    this.attributes = json['@attributes'] == null
        ? null
        : Attributes.fromJson(json['@attributes']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributes != null)
      data['@attributes'] = this.attributes?.toJson();
    return data;
  }
}
