import 'package:rep_check/models/chamber.dart';

class AllMemberResponse {
  String status;
  String copyright;
  List<Chamber> results;

  AllMemberResponse({this.status, this.copyright, this.results});

  AllMemberResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    copyright = json['copyright'];
    if (json['results'] != null) {
      results = new List<Chamber>();
      json['results'].forEach((v) {
        results.add(new Chamber.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['copyright'] = this.copyright;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
