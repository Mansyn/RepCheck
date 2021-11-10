import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
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

  static String apiKey = dotenv.env['API_KEY'] != null
      ? dotenv.env['API_KEY'].toString()
      : 'key needed';
  static String osApiKey = dotenv.env['OS_KEY'] != null
      ? dotenv.env['OS_KEY'].toString()
      : 'key needed';
  static String pbApiKey = dotenv.env['pbApiKey'] != null
      ? dotenv.env['API_KEY'].toString()
      : 'key needed';
  static String geoKey = dotenv.env['GEO_KEY'] != null
      ? dotenv.env['GEO_KEY'].toString()
      : 'key needed';

  static String title = 'Rep Check';

  /// e.t.c.
  static String defaultAvatar = 'assets/images/avatar.png';
  static String defaultResult = 'assets/images/the-legislative-branch.jpg';
  static String logo = 'assets/images/logo.png';
  static String flag = 'assets/images/flag.png';
  static String flagColor = 'assets/images/flag_color.png';
  static String logoMuted = 'assets/images/logo_muted.png';
  static String commonDateFormat = 'dd MMM yyyy, hh:mm a';
  static String sep = '/';
  static String query = '?';
  static String amp = '&';

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
}
