class Subcommittee {
  String name;
  String code;
  String parentCommitteeId;
  String apiUri;
  String side;
  String title;
  int rankInParty;
  String beginDate;
  String endDate;

  Subcommittee(
      {this.name,
      this.code,
      this.parentCommitteeId,
      this.apiUri,
      this.side,
      this.title,
      this.rankInParty,
      this.beginDate,
      this.endDate});

  Subcommittee.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    parentCommitteeId = json['parent_committee_id'];
    apiUri = json['api_uri'];
    side = json['side'];
    title = json['title'];
    rankInParty = json['rank_in_party'];
    beginDate = json['begin_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    data['parent_committee_id'] = this.parentCommitteeId;
    data['api_uri'] = this.apiUri;
    data['side'] = this.side;
    data['title'] = this.title;
    data['rank_in_party'] = this.rankInParty;
    data['begin_date'] = this.beginDate;
    data['end_date'] = this.endDate;
    return data;
  }
}
