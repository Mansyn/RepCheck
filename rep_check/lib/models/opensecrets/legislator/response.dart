import 'legislator.dart';

class Response {
  List<Legislator> legislator;

  Response({this.legislator});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['legislator'] != null) {
      legislator = new List<Legislator>();
      json['legislator'].forEach((v) {
        legislator.add(new Legislator.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.legislator != null) {
      data['legislator'] = this.legislator.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
