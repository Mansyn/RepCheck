import 'attributes.dart';

class Summary {
  Summary({
    required this.attributes,
  });
  late final Attributes attributes;

  Summary.fromJson(Map<String, dynamic> json) {
    attributes = Attributes.fromJson(json['@attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['@attributes'] = attributes.toJson();
    return _data;
  }
}
