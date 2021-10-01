import 'attributes1.dart';

class Contributor {
  Attributes1? attributes;

  Contributor({this.attributes});

  Contributor.fromJson(Map<String, dynamic> json) {
    this.attributes = json['@attributes'] == null
        ? null
        : Attributes1.fromJson(json['@attributes']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributes != null)
      data['@attributes'] = this.attributes?.toJson();
    return data;
  }
}
