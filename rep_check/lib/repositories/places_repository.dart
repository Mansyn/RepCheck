import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:rep_check/env_config.dart';
import 'package:rep_check/responses/maps/place_response.dart';
import 'package:rep_check/responses/maps/suggestion_response.dart';
import 'package:rep_check/utils/constants.dart';

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = Constants.mapsApiKey;
  static final String iosKey = 'YOUR_API_KEY_HERE';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<SuggestionResponse>> fetchSuggestions(
      String input, String lang) async {
    final request = EnvConfig.mapsUrl +
        'autocomplete/json?input=$input&types=address&language=$lang&components=country:us&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final List<SuggestionResponse> predictions = result['predictions']
            .map<SuggestionResponse>((p) => SuggestionResponse(
                p['place_id'], p['description'], p['types'].cast<String>()))
            .toList();

        List<SuggestionResponse> suggestions = List<SuggestionResponse>();
        predictions.forEach((prediction) {
          if (prediction.types.contains('street_address')) {
            // Results that include 'street_address' should be included
            suggestions.add(prediction);
          } else {
            // Results that don't include 'street_address' will go through the check
            int typeCounter = 0;
            if (prediction.types.contains('geocode')) {
              typeCounter++;
            }
            if (prediction.types.contains('route')) {
              typeCounter++;
            }
            if (prediction.types.length > typeCounter) {
              suggestions.add(prediction);
            }
          }
        });

        return suggestions;
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<PlaceResponse> getPlaceDetailFromId(String placeId) async {
    final request = EnvConfig.mapsUrl +
        'details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
            result['result']['address_components'] as List<dynamic>;
        // build result
        final place = PlaceResponse();
        components.forEach((c) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
          if (type.contains('locality')) {
            place.city = c['long_name'];
          }
          if (type.contains('administrative_area_level_1')) {
            place.state = c['long_name'];
          }
          if (type.contains('postal_code')) {
            place.zipCode = c['long_name'];
          }
        });
        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
