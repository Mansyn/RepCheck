class Office {
  Office(
      {required this.name,
      required this.divisionId,
      required this.levels,
      required this.roles,
      required this.officialIndices});

  String name;
  String divisionId;
  List<String> levels;
  List<String> roles;
  List<int> officialIndices;

  factory Office.fromJson(Map<String, dynamic> json) => Office(
        name: json["name"],
        divisionId: json["divisionId"],
        levels: List<String>.from(json["levels"].map((x) => x)),
        roles: List<String>.from(json["roles"].map((x) => x)),
        officialIndices: List<int>.from(json["officialIndices"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "divisionId": divisionId,
        "levels": List<dynamic>.from(levels.map((x) => x)),
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "officialIndices": List<dynamic>.from(officialIndices.map((x) => x)),
      };
}
