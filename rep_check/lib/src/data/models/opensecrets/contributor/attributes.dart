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
    candName = json['cand_name'];
    cid = json['cid'];
    cycle = json['cycle'];
    origin = json['origin'];
    source = json['source'];
    notice = json['notice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cand_name'] = candName;
    data['cid'] = cid;
    data['cycle'] = cycle;
    data['origin'] = origin;
    data['source'] = source;
    data['notice'] = notice;
    return data;
  }
}
