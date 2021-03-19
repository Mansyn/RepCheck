import 'dart:convert';

import 'package:html/parser.dart';
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
    if (response.statusCode == 200) {
      print(response.body);
      var document = parse(response.body);
      var elements = document.querySelectorAll("div.rg_meta");
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
    } else {
      throw Exception('Failed');
    }
  }
}
