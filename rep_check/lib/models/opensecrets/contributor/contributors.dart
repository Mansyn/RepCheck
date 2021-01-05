import 'contributor.dart';

class Contributors {
  List<Contributor> contributor;

  Contributors({this.contributor});

  Contributors.fromJson(Map<String, dynamic> json) {
    if (json['contributor'] != null) {
      contributor = new List<Contributor>();
      json['contributor'].forEach((v) {
        contributor.add(new Contributor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contributor != null) {
      data['contributor'] = this.contributor.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
