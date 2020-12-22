import 'package:rep_check/models/civic/input.dart';
import 'package:rep_check/models/civic/offices.dart';
import 'package:rep_check/models/civic/official.dart';

class RepresentativeResponse {
  NormalizedInput normalizedInput;
  String kind;
  Object divisions;
  List<Offices> offices;
  List<Official> officials;

  RepresentativeResponse(
      {this.normalizedInput,
      this.kind,
      this.divisions,
      this.offices,
      this.officials});

  RepresentativeResponse.fromJson(Map<String, dynamic> json) {
    normalizedInput = json['normalizedInput'] != null
        ? new NormalizedInput.fromJson(json['normalizedInput'])
        : null;
    kind = json['kind'];
    divisions = json['divisions'];
    if (json['offices'] != null) {
      offices = new List<Offices>();
      json['offices'].forEach((v) {
        offices.add(new Offices.fromJson(v));
      });
    }
    if (json['officials'] != null) {
      officials = new List<Official>();
      json['officials'].forEach((v) {
        officials.add(new Official.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.normalizedInput != null) {
      data['normalizedInput'] = this.normalizedInput.toJson();
    }
    data['kind'] = this.kind;
    if (this.divisions != null) {
      data['divisions'] = this.divisions;
    }
    if (this.offices != null) {
      data['offices'] = this.offices.map((v) => v.toJson()).toList();
    }
    if (this.officials != null) {
      data['officials'] = this.officials.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
