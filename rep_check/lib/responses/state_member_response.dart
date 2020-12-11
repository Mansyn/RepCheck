import 'package:rep_check/models/chamber.dart';
import 'package:rep_check/models/member.dart';

class StateMemberResponse {
  String status;
  String copyright;
  List<Member> results;

  StateMemberResponse({this.status, this.copyright, this.results});

  StateMemberResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    copyright = json['copyright'];
    if (json['results'] != null) {
      results = new List<Member>();
      json['results'].forEach((v) {
        results.add(new Member.fromJson(v));
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
