import 'address.dart';
import 'channels.dart';
import 'input.dart';

class Official {
  Official({
    required this.name,
    required this.address,
    required this.normalizedInput,
    required this.party,
    required this.phones,
    required this.urls,
    required this.photoUrl,
    required this.emails,
    required this.channels,
  });

  late final String name;
  late final List<Address> address;
  late final List<NormalizedInput> normalizedInput;
  late final String party;
  late final List<String> phones;
  late final List<String> urls;
  late final String? photoUrl;
  late final List<String> emails;
  late final List<Channels> channels;

  factory Official.fromJson(Map<String, dynamic> json) => Official(
        name: json['name'],
        address:
            List.from(json['address']).map((e) => Address.fromJson(e)).toList(),
        normalizedInput: json['normalizedInput'] != null
            ? List<NormalizedInput>.from(
                json['normalizedInput'].map((x) => NormalizedInput.fromJson(x)))
            : [],
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
        'normalizedInput':
            List<dynamic>.from(normalizedInput.map((x) => x.toJson())),
        'party': party,
        'phones': List<dynamic>.from(phones.map((x) => x)),
        'urls': List<dynamic>.from(urls.map((x) => x)),
        'photoUrl': photoUrl,
        'emails': List<dynamic>.from(emails.map((x) => x)),
        'channels': List<dynamic>.from(channels.map((x) => x.toJson())),
      };
}
