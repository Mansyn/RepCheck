class Attributes {
  String? candName;
  String? cid;
  String? cycle;
  String? origin;
  String? source;
  String? notice;

  Attributes(
      {this.candName,
      this.cid,
      this.cycle,
      this.origin,
      this.source,
      this.notice});

  Attributes.fromJson(Map<String, dynamic> json) {
    this.candName = json['cand_name'];
    this.cid = json['cid'];
    this.cycle = json['cycle'];
    this.origin = json['origin'];
    this.source = json['source'];
    this.notice = json['notice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cand_name'] = this.candName;
    data['cid'] = this.cid;
    data['cycle'] = this.cycle;
    data['origin'] = this.origin;
    data['source'] = this.source;
    data['notice'] = this.notice;
    return data;
  }
}
