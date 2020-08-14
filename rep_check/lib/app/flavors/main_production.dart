import 'package:rep_check/app/app_config.dart';

void main() async {
  await FlutterAppConfig(
          environment: AppEnvironment.development,
          publicaBaseUrl: 'https://api.propublica.org/congress/v1/',
          publicaKey: 'NXPaOcfs3gRy8WabavuC9LyP0w2GNYbm5w6hBAhd',
          appName: 'Rep Check')
      .run();
}
