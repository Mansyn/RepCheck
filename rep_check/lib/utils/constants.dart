class Constants {
  static bool testing = true;

  /// general setup
  static String appId = "com.unleashed.rep_check";
  static String iosAppId = "com.unleashed.rep_check";
  static String appName = "Rep Check";
  static String appTagLine = "Be aware of who represents you";
  static String appBio = "Built to help people know who represents them";
  static String contactEmail = "iwalktheline@live.com";
  static String logoKey = "assets/images/logo.png";
  static String rootsKey = 'assets/images/roots.png';
  static String loadingKey = "assets/images/loading.gif";
  static String defaultProfile = "assets/images/congressman_avatar.png";
  static String appAbout =
      "The was built to help people easily discover who represents them, and will let them see what they do in Congress.";

  /// Share message
  static String shareLink = "http://unleasheddevelopement.com";
  static String shareMessage = "Check out this Amazing App at " + shareLink;
  static String shareSubject = "Best App Ever!";
  static String twitterUrl = "https://twitter.com/rhymenocerus";

// ad config
  static List<String> testing_devices = ['emulator-5554'];
  static String ad_unit_id = 'ca-app-pub-4892089932850014/8913053714';
  static String app_id = 'ca-app-pub-4892089932850014~6638244163';
  static List<String> keywords = ['voting', 'government', 'information'];

  /// http headers
  static Object apiHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-API-Key': proPublicaApiKey
  };

  Map<String, String> backendHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer val'
  };

  /// FCM notification keys & topics
  static String publicTopicKey = testing ? "testing" : "public";

  /// e.t.c.
  static double commonPadding = 15.0;
  static String commonDateFormat = "dd MMM yyyy, hh:mm a";
  static String sep = "/";

  /// param keys
  static String appPreviouslyRunKey = "seen";
  static String members = "members";
  static String congress = "congress";
  static String house = "house";
  static String senate = "senate";
  static String chamber = "chamber";
  static String state = "state";
  static String district = "district";
  static String current = "current";

  static String session = "116";

  // api keys
  static String proPublicaApiKey = "NXPaOcfs3gRy8WabavuC9LyP0w2GNYbm5w6hBAhd";

  /// api routes
  static String apiBaseUrl = "https://api.propublica.org/congress/v1/";

  static String fbUrl = 'https://www.facebook.com/';
  static String fbPhotoUrl =
      'https://graph.facebook.com/{id}/picture?type=large';
  static String twitUrl = 'https://www.twitter.com/';
  static String twitPhotoUrl =
      'https://twitter.com/{id}/profile_image?size=bigger';

  static String youtubeUrl = 'https://www.youtube.com/';
  static String govTrackUrl = 'https://www.govtrack.us/congress/members/';
}
