class MemberResponse {
  String status;
  String copyright;
  List<Member> results;

  MemberResponse({this.status, this.copyright, this.results});

  MemberResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    copyright = json['copyright'];
    if (json['results'] != null) {
      results = new List<Member>();
      json['results'].forEach((v) {
        results.add(new Member.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['copyright'] = this.copyright;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Member {
  String id;
  String name;
  String firstName;
  Null middleName;
  String lastName;
  Null suffix;
  String role;
  String gender;
  String party;
  String timesTopicsUrl;
  String twitterId;
  String facebookAccount;
  String youtubeId;
  String seniority;
  String nextElection;
  String apiUri;

  Member(
      {this.id,
      this.name,
      this.firstName,
      this.middleName,
      this.lastName,
      this.suffix,
      this.role,
      this.gender,
      this.party,
      this.timesTopicsUrl,
      this.twitterId,
      this.facebookAccount,
      this.youtubeId,
      this.seniority,
      this.nextElection,
      this.apiUri});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    suffix = json['suffix'];
    role = json['role'];
    gender = json['gender'];
    party = json['party'];
    timesTopicsUrl = json['times_topics_url'];
    twitterId = json['twitter_id'];
    facebookAccount = json['facebook_account'];
    youtubeId = json['youtube_id'];
    seniority = json['seniority'];
    nextElection = json['next_election'];
    apiUri = json['api_uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['suffix'] = this.suffix;
    data['role'] = this.role;
    data['gender'] = this.gender;
    data['party'] = this.party;
    data['times_topics_url'] = this.timesTopicsUrl;
    data['twitter_id'] = this.twitterId;
    data['facebook_account'] = this.facebookAccount;
    data['youtube_id'] = this.youtubeId;
    data['seniority'] = this.seniority;
    data['next_election'] = this.nextElection;
    data['api_uri'] = this.apiUri;
    return data;
  }
}
