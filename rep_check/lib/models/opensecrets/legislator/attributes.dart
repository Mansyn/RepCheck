class Attributes {
  String cid;
  String firstlast;
  String lastname;
  String party;
  String office;
  String gender;
  String firstElected;
  String exitCode;
  String comments;
  String phone;
  String fax;
  String website;
  String webform;
  String congressOffice;
  String bioguideId;
  String votesmartId;
  String feccandid;
  String twitterId;
  String youtubeUrl;
  String facebookId;
  String birthdate;

  Attributes(
      {this.cid,
      this.firstlast,
      this.lastname,
      this.party,
      this.office,
      this.gender,
      this.firstElected,
      this.exitCode,
      this.comments,
      this.phone,
      this.fax,
      this.website,
      this.webform,
      this.congressOffice,
      this.bioguideId,
      this.votesmartId,
      this.feccandid,
      this.twitterId,
      this.youtubeUrl,
      this.facebookId,
      this.birthdate});

  Attributes.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    firstlast = json['firstlast'];
    lastname = json['lastname'];
    party = json['party'];
    office = json['office'];
    gender = json['gender'];
    firstElected = json['first_elected'];
    exitCode = json['exit_code'];
    comments = json['comments'];
    phone = json['phone'];
    fax = json['fax'];
    website = json['website'];
    webform = json['webform'];
    congressOffice = json['congress_office'];
    bioguideId = json['bioguide_id'];
    votesmartId = json['votesmart_id'];
    feccandid = json['feccandid'];
    twitterId = json['twitter_id'];
    youtubeUrl = json['youtube_url'];
    facebookId = json['facebook_id'];
    birthdate = json['birthdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['firstlast'] = this.firstlast;
    data['lastname'] = this.lastname;
    data['party'] = this.party;
    data['office'] = this.office;
    data['gender'] = this.gender;
    data['first_elected'] = this.firstElected;
    data['exit_code'] = this.exitCode;
    data['comments'] = this.comments;
    data['phone'] = this.phone;
    data['fax'] = this.fax;
    data['website'] = this.website;
    data['webform'] = this.webform;
    data['congress_office'] = this.congressOffice;
    data['bioguide_id'] = this.bioguideId;
    data['votesmart_id'] = this.votesmartId;
    data['feccandid'] = this.feccandid;
    data['twitter_id'] = this.twitterId;
    data['youtube_url'] = this.youtubeUrl;
    data['facebook_id'] = this.facebookId;
    data['birthdate'] = this.birthdate;
    return data;
  }
}
