class Attributes {
  String? cid;
  String? firstlast;
  String? lastname;
  String? party;
  String? office;
  String? gender;
  String? firstElected;
  String? exitCode;
  String? comments;
  String? phone;
  String? fax;
  String? website;
  String? webform;
  String? congressOffice;
  String? bioguideId;
  String? votesmartId;
  String? feccandid;
  String? twitterId;
  String? youtubeUrl;
  String? facebookId;
  String? birthdate;

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
    this.cid = json["cid"];
    this.firstlast = json["firstlast"];
    this.lastname = json["lastname"];
    this.party = json["party"];
    this.office = json["office"];
    this.gender = json["gender"];
    this.firstElected = json["first_elected"];
    this.exitCode = json["exit_code"];
    this.comments = json["comments"];
    this.phone = json["phone"];
    this.fax = json["fax"];
    this.website = json["website"];
    this.webform = json["webform"];
    this.congressOffice = json["congress_office"];
    this.bioguideId = json["bioguide_id"];
    this.votesmartId = json["votesmart_id"];
    this.feccandid = json["feccandid"];
    this.twitterId = json["twitter_id"];
    this.youtubeUrl = json["youtube_url"];
    this.facebookId = json["facebook_id"];
    this.birthdate = json["birthdate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["cid"] = this.cid;
    data["firstlast"] = this.firstlast;
    data["lastname"] = this.lastname;
    data["party"] = this.party;
    data["office"] = this.office;
    data["gender"] = this.gender;
    data["first_elected"] = this.firstElected;
    data["exit_code"] = this.exitCode;
    data["comments"] = this.comments;
    data["phone"] = this.phone;
    data["fax"] = this.fax;
    data["website"] = this.website;
    data["webform"] = this.webform;
    data["congress_office"] = this.congressOffice;
    data["bioguide_id"] = this.bioguideId;
    data["votesmart_id"] = this.votesmartId;
    data["feccandid"] = this.feccandid;
    data["twitter_id"] = this.twitterId;
    data["youtube_url"] = this.youtubeUrl;
    data["facebook_id"] = this.facebookId;
    data["birthdate"] = this.birthdate;
    return data;
  }
}
