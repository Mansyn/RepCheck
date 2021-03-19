class Offices {
  String name;
  String divisionId;
  List<String> levels;
  List<String> roles;
  List<int> officialIndices;

  Offices(
      {this.name,
      this.divisionId,
      this.levels,
      this.roles,
      this.officialIndices});

  Offices.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    divisionId = json['divisionId'];
    if (json['levels'] != null) {
      levels = json['levels'].cast<String>();
    }
    if (json['roles'] != null) {
      roles = json['roles'].cast<String>();
    }
    if (json['officialIndices'] != null) {
      officialIndices = json['officialIndices'].cast<int>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['divisionId'] = this.divisionId;
    data['levels'] = this.levels;
    data['roles'] = this.roles;
    data['officialIndices'] = this.officialIndices;
    return data;
  }
}
