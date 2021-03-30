import 'dart:convert';

import 'package:rep_check/api/api_base_helper.dart';
import 'package:rep_check/utils/constants.dart';

class GoogleRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<String>> fetchImageList(String query) async {
    var fullUrl =
        Uri.encodeFull(Constants.imagesUrl.replaceAll('{query}', query));

    print(fullUrl);
    final response = await _helper.get(fullUrl, Constants.webHeaders);

    List<String> links = [];

    var elements = response.querySelectorAll("div.rg_meta");
    for (var element in elements) {
      if (element.hasChildNodes()) {
        print(element.firstChild.toString());
        var jsondecoded = jsonDecode(element.firstChild
            .toString()
            .substring(1, element.firstChild.toString().length - 1));
        print(jsondecoded['ou']);
        links.add(jsondecoded['ou']);
      }
    }

    return links;
  }
}
