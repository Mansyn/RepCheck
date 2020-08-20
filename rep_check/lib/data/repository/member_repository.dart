import 'dart:async';

import 'package:geocoder/geocoder.dart';
import 'package:rep_check/data/model/legislator.dart';
import 'package:rep_check/data/network/api_provider.dart';

class MemberRepository {
  ApiProvider _provider = ApiProvider();

  final String apiUrl;
  final String apiKey;

  MemberRepository(this.apiUrl, this.apiKey);

  Future<List<Legislator>> fetchYourMembers(Coordinates coordinates) async {
    final response = await _provider.get(
        this.apiUrl +
            'legislators/geo/?lat=' +
            coordinates.latitude.toString() +
            '&long=' +
            coordinates.longitude.toString(),
        this.apiKey);
    return (response as List).map((i) => Legislator.fromJson(i)).toList();
  }
}
