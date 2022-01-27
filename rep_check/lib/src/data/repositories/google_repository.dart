import 'dart:convert';

import 'package:rep_check/src/data/providers/http_provider.dart';
import 'package:rep_check/src/utils/constants.dart';

class GoogleRepository {
  HttpProvider httpProvider = HttpProvider();

  Future<List<String>> fetchImageList(String query) async {
    var fullUrl =
        Uri.encodeFull(Constants.imagesUrl.replaceAll('{query}', query));

    final response = await httpProvider.getData(fullUrl, Constants.webHeaders);

    if (response.statusCode == 200) {
      List<String> links = [];

      var responseJson = json.decode(response.body.toString());
      var elements = responseJson.querySelectorAll("div.rg_meta");
      for (var element in elements) {
        if (element.hasChildNodes()) {
          var jsondecoded = jsonDecode(element.firstChild
              .toString()
              .substring(1, element.firstChild.toString().length - 1));
          links.add(jsondecoded['ou']);
        }
      }

      return links;
    } else {
      throw Exception('Failed to load legislator');
    }
  }
}
