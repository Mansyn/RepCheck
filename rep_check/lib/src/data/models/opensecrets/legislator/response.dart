import 'legislator.dart';

class Response {
  List<Legislator>? legislators;

  Response({this.legislators});

  Response.fromJson(Map<String, dynamic> json) {
    legislators = json['legislator'] == null
        ? null
        : (json['legislator'] as List)
            .map((e) => Legislator.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (legislators != null) {
      data['legislator'] = legislators?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
