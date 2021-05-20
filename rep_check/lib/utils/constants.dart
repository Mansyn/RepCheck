import 'package:flutter_config/flutter_config.dart';

class Constants {
  static bool testing = true;

  /// general setup
  static String appId = 'com.unleashed.rep_check';
  static String iosAppId = 'com.unleashed.rep_check';
  static String appName = 'Rep Check';
  static String appTagLine = 'Be aware of who represents you';
  static String appBio = 'Built to help people know who represents them';
  static String contactEmail = 'iwalktheline@live.com';
  static String appAbout =
      'Rep Check was built to enable people to easily research their representatives. We welcome all feedback and suggestions to further empower citizens with knowledge.';
  static String tell = 'Tell a friend to tell a friend to tell a friend';

  static String detectDistrict = 'Detect District';
  static String detectDistrictDesc = 'use GPS location';
  static String lookupDistrict = 'Lookup District';
  static String lookupDistrictDesc = 'find by address';

  /// Share message
  static String shareLink = 'http://unleasheddevelopement.com';
  static String shareMessage = 'Check out this Amazing App at ' + shareLink;
  static String shareSubject = 'Best App Ever!';
  static String twitterUrl = 'https://twitter.com/rhymenocerus';

// ad config
  static List<String> testingDevices = [
    'b89b2dd4c77b6936',
    '577599a1dd5ab4ce',
    '5b59fb61f33543fc',
    '3C1704A7B8B2A9B21396AF749904CBE3'
  ];
  static String adUnitId = 'ca-app-pub-4892089932850014/8913053714';
  static String adAppId = 'ca-app-pub-4892089932850014~6638244163';
  static List<String> keywords = ['voting', 'government', 'information'];

  static String apiKey = FlutterConfig.get('apiKey');
  static String osApiKey = FlutterConfig.get('osKey');
  static String pbApiKey = FlutterConfig.get('pbApiKey');
  static String mapsApiKey = FlutterConfig.get('mapsKey');

  /// http headers
  static Map<String, String> pbHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-API-Key': pbApiKey
  };

  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  static Map<String, String> webHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'user-agent':
        'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36'
  };

  Map<String, String> backendHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer val'
  };

  /// FCM notification keys & topics
  static String publicTopicKey = testing ? 'testing' : 'public';

  /// e.t.c.
  static double commonPadding = 15.0;
  static String commonDateFormat = 'dd MMM yyyy, hh:mm a';
  static String sep = '/';
  static String query = '?';
  static String amp = '&';

  /// images
  static String logoKey = 'assets/images/logo.png';
  static String mapKey = 'assets/images/map.png';
  static String flagKey = 'assets/images/flag.png';
  static String rootsKey = 'assets/images/roots.png';
  static String handsKey = 'assets/images/hands2.png';
  static String loadingKey = 'assets/images/loading.gif';
  static String defaultAvatar = 'assets/images/avatar.png';
  static String backgroundHeaderKey = 'assets/images/drawer_header.png';
  static String dcKey = 'assets/images/dc.jpg';
  static String facebookKey = 'assets/images/buttons/facebook.png';
  static String githubKey = 'assets/images/buttons/github.png';
  static String amazonKey = 'assets/images/buttons/amazon.png';
  static String appleKey = 'assets/images/buttons/apple.png';
  static String mailKey = 'assets/images/buttons/mail.png';
  static String microsoftKey = 'assets/images/buttons/microsoft.png';
  static String yahooKey = 'assets/images/buttons/yahoo.png';
  static String googleKey = 'assets/images/buttons/google.png';
  static String twitterKey = 'assets/images/buttons/twitter.png';
  static String youtubeKey = 'assets/images/buttons/youtube.png';
  static String webKey = 'assets/images/buttons/web.png';

  /// param keys
  static String appPreviouslyRunKey = 'seen';
  static String members = 'members';
  static String congress = 'congress';
  static String house = 'house';
  static String senate = 'senate';
  static String representatives = 'representatives';
  static String chamber = 'chamber';
  static String state = 'state';
  static String district = 'district';
  static String current = 'current';
  static String address = 'address=';
  static String roles = 'roles=';
  static String levels = 'levels=';
  static String peopleGeo = 'people.geo';
  static String lat = 'lat=';
  static String long = 'lng=';
  static String key = 'key=';
  static String apikey = 'apikey=';
  static String method = 'method=';
  static String outputJson = 'output=json';
  static String id = 'id=';
  static String cid = 'cid=';
  static String getLegs = 'getLegislators';
  static String candContrib = 'candContrib';
  static String newsSearch = 'Latest News';

  static String session = '116';

  static String imagesUrl =
      'https://www.google.com/search?q={query}&tbm=isch&tbs=isz:m';
  static String newsUrl = 'https://news.google.com/search?q=';

  static String fbUrl = 'https://www.facebook.com/';
  static String fbPhotoUrl =
      'https://graph.facebook.com/{id}/picture?type=large';
  static String twitUrl = 'https://www.twitter.com/';
  static String twitPhotoUrl =
      'https://twitter.com/{id}/profile_image?size=bigger';

  static String youtubeUrl = 'https://www.youtube.com/';
  static String govTrackUrl = 'https://www.govtrack.us/congress/members/';
}
