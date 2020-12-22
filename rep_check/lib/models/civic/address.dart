class Address {
  String line1;
  String city;
  String state;
  String zip;

  Address({this.line1, this.city, this.state, this.zip});

  Address.fromJson(Map<String, dynamic> json) {
    line1 = json['line1'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['line1'] = this.line1;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    return data;
  }
}
