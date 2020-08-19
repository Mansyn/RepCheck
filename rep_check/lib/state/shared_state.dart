import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

class SharedState extends ChangeNotifier {
  static final navigatorKey = GlobalKey<NavigatorState>();

  final String publicaBaseUrl;
  final String publicaKey;

  Position location;
  String state;
  String stateCode;

  SharedState(this.publicaBaseUrl, this.publicaKey);

  @override
  void dispose() {
    super.dispose();
  }
}
