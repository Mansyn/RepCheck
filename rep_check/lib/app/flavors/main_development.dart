import 'package:rep_check/app/app_config.dart';

void main() async {
  await FlutterAppConfig(
    environment: AppEnvironment.development,
    apiUrl: 'https://openstates.org/api/v1/',
    apiKey: '06a6f314-6354-4a0b-9d36-3d64535a3c91',
    appName: 'Rep Check Dev',
  ).run();
}
