import 'attributes.dart';

class Legislator {
  Attributes? attributes;

  Legislator({this.attributes});

  Legislator.fromJson(Map<String, dynamic> json) {
    attributes = json['@attributes'] == null
        ? null
        : Attributes.fromJson(json['@attributes']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attributes != null) {
      data['@attributes'] = attributes?.toJson();
    }
    return data;
  }
}
