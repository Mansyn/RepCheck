import 'summary.dart';

class Response {
  Response({
    required this.summary,
  });
  late final Summary summary;

  Response.fromJson(Map<String, dynamic> json) {
    summary = Summary.fromJson(json['summary']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['summary'] = summary.toJson();
    return _data;
  }
}
