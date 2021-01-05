class Attributes {
  String orgName;
  String total;
  String pacs;
  String indivs;

  Attributes({this.orgName, this.total, this.pacs, this.indivs});

  Attributes.fromJson(Map<String, dynamic> json) {
    orgName = json['org_name'];
    total = json['total'];
    pacs = json['pacs'];
    indivs = json['indivs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['org_name'] = this.orgName;
    data['total'] = this.total;
    data['pacs'] = this.pacs;
    data['indivs'] = this.indivs;
    return data;
  }
}
