import 'member.dart';

class Chamber {
  String congress;
  String chamber;
  int numResults;
  int offset;
  List<Member> members;

  Chamber(
      {this.congress,
      this.chamber,
      this.numResults,
      this.offset,
      this.members});

  Chamber.fromJson(Map<String, dynamic> json) {
    congress = json['congress'];
    chamber = json['chamber'];
    numResults = json['num_results'];
    offset = json['offset'];
    if (json['members'] != null) {
      members = new List<Member>();
      json['members'].forEach((v) {
        members.add(new Member.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['congress'] = this.congress;
    data['chamber'] = this.chamber;
    data['num_results'] = this.numResults;
    data['offset'] = this.offset;
    if (this.members != null) {
      data['members'] = this.members.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
