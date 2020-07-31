import 'package:rep_check/app/app_config.dart';

void main() async {
  await FlutterAppConfig(
    environment: AppEnvironment.development,
    apiBaseUrl: 'https://my-api.com',
    appName: 'Flutter-App-Prod',
    initializeCrashlytics: true,
  ).run();
}
