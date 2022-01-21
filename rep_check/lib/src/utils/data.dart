import 'package:rep_check/src/data/repositories/google_repository.dart';
import 'package:us_states/us_states.dart';

enum SearchType { google, flickr }

class Data {
  GoogleRepository googleRepository = GoogleRepository();

  Future<List<String>> loadImagesFromGoogleTask(String query) async {
    return googleRepository.fetchImageList(query);
  }

  static bool isStateAbbr(String name) {
    return USStates.getAllAbbreviations().contains(name);
  }

  static String getStateAbbr(String name) {
    return USStates.getAbbreviation(name);
  }

  static String? getStateName(String code) {
    return USStates.getName(code);
  }
}
