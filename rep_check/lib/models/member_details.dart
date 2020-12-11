import 'package:rep_check/models/role.dart';

class MemberDetails {
  String id;
  String memberId;
  String firstName;
  String middleName;
  String lastName;
  String suffix;
  String dateOfBirth;
  String gender;
  String url;
  String timesTopicsUrl;
  String timesTag;
  String govtrackId;
  String cspanId;
  String votesmartId;
  String icpsrId;
  String twitterAccount;
  String facebookAccount;
  String youtubeAccount;
  String crpId;
  String googleEntityId;
  String rssUrl;
  bool inOffice;
  String currentParty;
  String mostRecentVote;
  String lastUpdated;
  List<Role> roles;

  MemberDetails(
      {this.id,
      this.memberId,
      this.firstName,
      this.middleName,
      this.lastName,
      this.suffix,
      this.dateOfBirth,
      this.gender,
      this.url,
      this.timesTopicsUrl,
      this.timesTag,
      this.govtrackId,
      this.cspanId,
      this.votesmartId,
      this.icpsrId,
      this.twitterAccount,
      this.facebookAccount,
      this.youtubeAccount,
      this.crpId,
      this.googleEntityId,
      this.rssUrl,
      this.inOffice,
      this.currentParty,
      this.mostRecentVote,
      this.lastUpdated,
      this.roles});

  MemberDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    suffix = json['suffix'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    url = json['url'];
    timesTopicsUrl = json['times_topics_url'];
    timesTag = json['times_tag'];
    govtrackId = json['govtrack_id'];
    cspanId = json['cspan_id'];
    votesmartId = json['votesmart_id'];
    icpsrId = json['icpsr_id'];
    twitterAccount = json['twitter_account'];
    facebookAccount = json['facebook_account'];
    youtubeAccount = json['youtube_account'];
    crpId = json['crp_id'];
    googleEntityId = json['google_entity_id'];
    rssUrl = json['rss_url'];
    inOffice = json['in_office'];
    currentParty = json['current_party'];
    mostRecentVote = json['most_recent_vote'];
    lastUpdated = json['last_updated'];
    if (json['roles'] != null) {
      roles = new List<Role>();
      json['roles'].forEach((v) {
        roles.add(new Role.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['member_id'] = this.memberId;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['suffix'] = this.suffix;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['url'] = this.url;
    data['times_topics_url'] = this.timesTopicsUrl;
    data['times_tag'] = this.timesTag;
    data['govtrack_id'] = this.govtrackId;
    data['cspan_id'] = this.cspanId;
    data['votesmart_id'] = this.votesmartId;
    data['icpsr_id'] = this.icpsrId;
    data['twitter_account'] = this.twitterAccount;
    data['facebook_account'] = this.facebookAccount;
    data['youtube_account'] = this.youtubeAccount;
    data['crp_id'] = this.crpId;
    data['google_entity_id'] = this.googleEntityId;
    data['rss_url'] = this.rssUrl;
    data['in_office'] = this.inOffice;
    data['current_party'] = this.currentParty;
    data['most_recent_vote'] = this.mostRecentVote;
    data['last_updated'] = this.lastUpdated;
    if (this.roles != null) {
      data['roles'] = this.roles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
