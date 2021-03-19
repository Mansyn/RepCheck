import 'package:rep_check/repositories/google_repository.dart';
import 'package:us_states/us_states.dart';

enum SearchType { Google, Flickr }

class Datahelper {
  Datahelper() {
    googleRepository = GoogleRepository();
  }

  GoogleRepository googleRepository;

  Future<List<String>> loadImagesFromGoogleTask(String query) async {
    return googleRepository.fetchImageList(query);
  }

  static String getStateShort(String name) {
    return USStates.getAbbreviation(name);
  }

  static String getStateLong(String code) {
    return USStates.getName(code);
  }
}
