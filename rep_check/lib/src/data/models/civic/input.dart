class NormalizedInput {
  NormalizedInput({
    required this.line1,
    required this.city,
    required this.state,
    required this.zip,
  });

  String line1;
  String city;
  String state;
  String zip;

  factory NormalizedInput.fromJson(Map<String, dynamic> json) =>
      NormalizedInput(
        line1: json["line1"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
      );

  Map<String, dynamic> toJson() => {
        "line1": line1,
        "city": city,
        "state": state,
        "zip": zip,
      };
}
