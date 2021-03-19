import 'address.dart';
import 'channels.dart';

class Official {
  String name;
  List<Address> address;
  String party;
  List<String> phones;
  List<String> urls;
  String photoUrl;
  List<Channels> channels;
  List<String> emails;

  Official(
      {this.name,
      this.address,
      this.party,
      this.phones,
      this.urls,
      this.photoUrl,
      this.channels,
      this.emails});

  Official.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['address'] != null) {
      address = [];
      json['address'].forEach((v) {
        address.add(Address.fromJson(v));
      });
    }
    party = json['party'];
    if (json['phones'] != null) {
      phones = json['phones'].cast<String>();
    }
    if (json['urls'] != null) {
      urls = json['urls'].cast<String>();
    }
    photoUrl = json['photoUrl'];
    if (json['channels'] != null) {
      channels = [];
      json['channels'].forEach((v) {
        channels.add(Channels.fromJson(v));
      });
    }
    if (json['emails'] != null) {
      emails = json['emails'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    if (this.address != null) {
      data['address'] = this.address.map((v) => v.toJson()).toList();
    }
    data['party'] = this.party;
    data['phones'] = this.phones;
    data['urls'] = this.urls;
    data['photoUrl'] = this.photoUrl;
    if (this.channels != null) {
      data['channels'] = this.channels.map((v) => v.toJson()).toList();
    }
    data['emails'] = this.emails;
    return data;
  }
}
