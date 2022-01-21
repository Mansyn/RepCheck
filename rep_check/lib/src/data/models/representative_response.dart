import 'package:rep_check/src/data/models/civic/input.dart';
import 'package:rep_check/src/data/models/civic/office.dart';
import 'package:rep_check/src/data/models/civic/official.dart';

class Response {
  Response(
      {required this.normalizedInput,
      required this.kind,
      required this.offices,
      required this.officials});

  NormalizedInput normalizedInput;
  String kind;
  List<Office> offices;
  List<Official> officials;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        normalizedInput: NormalizedInput.fromJson(json['normalizedInput']),
        kind: json['kind'],
        offices: json['offices'] != null
            ? List<Office>.from(json['offices'].map((x) => Office.fromJson(x)))
            : [],
        officials: json['officials'] != null
            ? List<Official>.from(
                json['officials'].map((x) => Official.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        'normalizedInput': normalizedInput.toJson(),
        'kind': kind,
        'offices': List<dynamic>.from(offices.map((x) => x.toJson())),
        'officials': List<dynamic>.from(officials.map((x) => x.toJson())),
      };
}
