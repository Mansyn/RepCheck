class Legislator {
  String firstName;
  String lastName;
  String middleName;
  int district;
  String chamber;
  String url;
  String createdAt;
  String updatedAt;
  String email;
  bool active;
  String state;
  List<Offices> offices;
  String fullName;
  String legId;
  String party;
  String suffixes;
  String id;
  String photoUrl;

  Legislator(
      {this.firstName,
      this.lastName,
      this.middleName,
      this.district,
      this.chamber,
      this.url,
      this.createdAt,
      this.updatedAt,
      this.email,
      this.active,
      this.state,
      this.offices,
      this.fullName,
      this.legId,
      this.party,
      this.suffixes,
      this.id,
      this.photoUrl});

  Legislator.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    middleName = json['middle_name'];
    district = json['district'];
    chamber = json['chamber'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    email = json['email'];
    active = json['active'];
    state = json['state'];
    if (json['offices'] != null) {
      offices = new List<Offices>();
      json['offices'].forEach((v) {
        offices.add(new Offices.fromJson(v));
      });
    }
    fullName = json['full_name'];
    legId = json['leg_id'];
    party = json['party'];
    suffixes = json['suffixes'];
    id = json['id'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['middle_name'] = this.middleName;
    data['district'] = this.district;
    data['chamber'] = this.chamber;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['email'] = this.email;
    data['active'] = this.active;
    data['state'] = this.state;
    if (this.offices != null) {
      data['offices'] = this.offices.map((v) => v.toJson()).toList();
    }
    data['full_name'] = this.fullName;
    data['leg_id'] = this.legId;
    data['party'] = this.party;
    data['suffixes'] = this.suffixes;
    data['id'] = this.id;
    data['photo_url'] = this.photoUrl;
    return data;
  }
}

class Offices {
  String fax;
  String name;
  String phone;
  String address;
  String type;
  Null email;

  Offices(
      {this.fax, this.name, this.phone, this.address, this.type, this.email});

  Offices.fromJson(Map<String, dynamic> json) {
    fax = json['fax'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    type = json['type'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fax'] = this.fax;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['type'] = this.type;
    data['email'] = this.email;
    return data;
  }
}
