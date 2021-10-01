import 'legislator.dart';

class Response {
  List<Legislator>? legislators;

  Response({this.legislators});

  Response.fromJson(Map<String, dynamic> json) {
    this.legislators = json['legislator'] == null
        ? null
        : (json['legislator'] as List)
            .map((e) => Legislator.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.legislators != null)
      data['legislator'] = this.legislators?.map((e) => e.toJson()).toList();
    return data;
  }
}
