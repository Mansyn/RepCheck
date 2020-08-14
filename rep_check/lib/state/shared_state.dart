import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class SharedState extends ChangeNotifier {
  static final navigatorKey = GlobalKey<NavigatorState>();

  final String publicaBaseUrl;
  final String publicaKey;

  SharedState(this.publicaBaseUrl, this.publicaKey);

  @override
  void dispose() {
    super.dispose();
  }
}
