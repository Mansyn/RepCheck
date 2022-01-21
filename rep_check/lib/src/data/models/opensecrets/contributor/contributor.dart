import 'attributes1.dart';

class Contributor {
  Attributes1? attributes;

  Contributor({this.attributes});

  Contributor.fromJson(Map<String, dynamic> json) {
    attributes = json['@attributes'] == null
        ? null
        : Attributes1.fromJson(json['@attributes']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attributes != null) {
      data['@attributes'] = attributes?.toJson();
    }
    return data;
  }
}
