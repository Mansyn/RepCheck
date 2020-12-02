class Committee {
  String name;
  String code;
  String apiUri;
  String side;
  String title;
  int rankInParty;
  String beginDate;
  String endDate;

  Committee(
      {this.name,
      this.code,
      this.apiUri,
      this.side,
      this.title,
      this.rankInParty,
      this.beginDate,
      this.endDate});

  Committee.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
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
    data['api_uri'] = this.apiUri;
    data['side'] = this.side;
    data['title'] = this.title;
    data['rank_in_party'] = this.rankInParty;
    data['begin_date'] = this.beginDate;
    data['end_date'] = this.endDate;
    return data;
  }
}
