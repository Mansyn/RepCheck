import 'dart:io';

import 'package:http/http.dart';
import 'package:rep_check/api/api_base_helper.dart';
import 'package:rep_check/env_config.dart';
import 'package:rep_check/responses/maps/place_response.dart';
import 'package:rep_check/responses/maps/suggestion_response.dart';
import 'package:rep_check/utils/constants.dart';

class PlaceRepository {
  final client = Client();

  PlaceRepository(this.sessionToken);

  final sessionToken;

  static final String androidKey = Constants.mapsApiKey;
  static final String iosKey = 'YOUR_API_KEY_HERE';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<SuggestionResponse>> fetchSuggestions(
      String input, String lang) async {
    final fullUrl = EnvConfig.mapsUrl +
        'autocomplete/json?input=$input&types=address&language=$lang&components=country:us&key=$apiKey&sessiontoken=$sessionToken';
    print(fullUrl);
    final response = await _helper.get(fullUrl, Constants.headers);

    if (response['status'] == 'ZERO_RESULTS') {
      return [];
    }

    final List<SuggestionResponse> predictions = response['predictions']
        .map<SuggestionResponse>((p) => SuggestionResponse(
            p['place_id'], p['description'], p['types'].cast<String>()))
        .toList();

    List<SuggestionResponse> suggestions = [];
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

  Future<PlaceResponse> getPlaceDetailFromId(String placeId) async {
    final fullUrl = EnvConfig.mapsUrl +
        'details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken';
    print(fullUrl);
    final response = await _helper.get(fullUrl, Constants.headers);

    final components =
        response['result']['address_components'] as List<dynamic>;
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
}
