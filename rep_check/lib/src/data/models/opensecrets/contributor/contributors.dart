import 'attributes.dart';
import 'contributor.dart';

class Contributors {
  Attributes? attributes;
  List<Contributor>? contributor;

  Contributors({this.attributes, this.contributor});

  Contributors.fromJson(Map<String, dynamic> json) {
    attributes = json['@attributes'] == null
        ? null
        : Attributes.fromJson(json['@attributes']);
    contributor = json['contributor'] == null
        ? null
        : (json['contributor'] as List)
            .map((e) => Contributor.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attributes != null) {
      data['@attributes'] = attributes?.toJson();
    }
    if (contributor != null) {
      data['contributor'] = contributor?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
