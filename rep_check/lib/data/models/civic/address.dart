class Address {
  Address({
    required this.line1,
    required this.city,
    required this.state,
    required this.zip,
  });
  late final String line1;
  late final String city;
  late final String state;
  late final String zip;

  Address.fromJson(Map<String, dynamic> json) {
    line1 = json['line1'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['line1'] = line1;
    _data['city'] = city;
    _data['state'] = state;
    _data['zip'] = zip;
    return _data;
  }
}
