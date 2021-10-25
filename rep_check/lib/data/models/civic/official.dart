import 'channels.dart';
import 'input.dart';

class Official {
  Official({
    required this.name,
    required this.address,
    required this.party,
    required this.phones,
    required this.urls,
    required this.photoUrl,
    required this.emails,
    required this.channels,
  });

  String name;
  List<NormalizedInput> address;
  String party;
  List<String> phones;
  List<String> urls;
  String? photoUrl;
  List<String> emails;
  List<Channels> channels;

  factory Official.fromJson(Map<String, dynamic> json) => Official(
        name: json['name'],
        address: List<NormalizedInput>.from(
            json['address'].map((x) => NormalizedInput.fromJson(x))),
        party: json['party'],
        phones: List<String>.from(json['phones'].map((x) => x)),
        urls: List<String>.from(json['urls'].map((x) => x)),
        photoUrl: json['photoUrl'],
        emails: json['emails'] != null
            ? List<String>.from(json['emails'].map((x) => x))
            : [],
        channels: List<Channels>.from(
            json['channels'].map((x) => Channels.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': List<dynamic>.from(address.map((x) => x.toJson())),
        'party': party,
        'phones': List<dynamic>.from(phones.map((x) => x)),
        'urls': List<dynamic>.from(urls.map((x) => x)),
        'photoUrl': photoUrl,
        'emails': List<dynamic>.from(emails.map((x) => x)),
        'channels': List<dynamic>.from(channels.map((x) => x.toJson())),
      };
}
