class Attributes1 {
  String? orgName;
  String? total;
  String? pacs;
  String? indivs;

  Attributes1({this.orgName, this.total, this.pacs, this.indivs});

  Attributes1.fromJson(Map<String, dynamic> json) {
    orgName = json['org_name'];
    total = json['total'];
    pacs = json['pacs'];
    indivs = json['indivs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['org_name'] = orgName;
    data['total'] = total;
    data['pacs'] = pacs;
    data['indivs'] = indivs;
    return data;
  }
}
