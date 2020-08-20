import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class SharedState extends ChangeNotifier {
  static final navigatorKey = GlobalKey<NavigatorState>();

  final String apiUrl;
  final String apiKey;

  Position location;
  String state;
  Coordinates coordinates;

  SharedState(this.apiUrl, this.apiKey);

  @override
  void dispose() {
    super.dispose();
  }
}
