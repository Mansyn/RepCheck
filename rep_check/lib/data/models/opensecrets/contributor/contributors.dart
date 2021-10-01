import 'attributes.dart';
import 'contributor.dart';

class Contributors {
  Attributes? attributes;
  List<Contributor>? contributor;

  Contributors({this.attributes, this.contributor});

  Contributors.fromJson(Map<String, dynamic> json) {
    this.attributes = json['@attributes'] == null
        ? null
        : Attributes.fromJson(json['@attributes']);
    this.contributor = json['contributor'] == null
        ? null
        : (json['contributor'] as List)
            .map((e) => Contributor.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributes != null)
      data['@attributes'] = this.attributes?.toJson();
    if (this.contributor != null)
      data['contributor'] = this.contributor?.map((e) => e.toJson()).toList();
    return data;
  }
}
