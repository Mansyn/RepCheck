class Attributes1 {
  String? orgName;
  String? total;
  String? pacs;
  String? indivs;

  Attributes1({this.orgName, this.total, this.pacs, this.indivs});

  Attributes1.fromJson(Map<String, dynamic> json) {
    this.orgName = json['org_name'];
    this.total = json['total'];
    this.pacs = json['pacs'];
    this.indivs = json['indivs'];
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
