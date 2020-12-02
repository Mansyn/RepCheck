class Member {
  String id;
  String title;
  String shortTitle;
  String apiUri;
  String firstName;
  String middleName;
  String lastName;
  String suffix;
  String dateOfBirth;
  String gender;
  String party;
  String leadershipRole;
  String twitterAccount;
  String facebookAccount;
  String youtubeAccount;
  String govtrackId;
  String cspanId;
  String votesmartId;
  String icpsrId;
  String crpId;
  String googleEntityId;
  String fecCandidateId;
  String url;
  String rssUrl;
  String contactForm;
  bool inOffice;
  String cookPvi;
  double dwNominate;
  String idealPoint;
  String seniority;
  String nextElection;
  int totalVotes;
  int missedVotes;
  int totalPresent;
  String lastUpdated;
  String ocdId;
  String office;
  String phone;
  String fax;
  String state;
  String senateClass;
  String stateRank;
  String lisId;
  double missedVotesPct;
  double votesWithPartyPct;
  double votesAgainstPartyPct;

  Member(
      {this.id,
      this.title,
      this.shortTitle,
      this.apiUri,
      this.firstName,
      this.middleName,
      this.lastName,
      this.suffix,
      this.dateOfBirth,
      this.gender,
      this.party,
      this.leadershipRole,
      this.twitterAccount,
      this.facebookAccount,
      this.youtubeAccount,
      this.govtrackId,
      this.cspanId,
      this.votesmartId,
      this.icpsrId,
      this.crpId,
      this.googleEntityId,
      this.fecCandidateId,
      this.url,
      this.rssUrl,
      this.contactForm,
      this.inOffice,
      this.cookPvi,
      this.dwNominate,
      this.idealPoint,
      this.seniority,
      this.nextElection,
      this.totalVotes,
      this.missedVotes,
      this.totalPresent,
      this.lastUpdated,
      this.ocdId,
      this.office,
      this.phone,
      this.fax,
      this.state,
      this.senateClass,
      this.stateRank,
      this.lisId,
      this.missedVotesPct,
      this.votesWithPartyPct,
      this.votesAgainstPartyPct});

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortTitle = json['short_title'];
    apiUri = json['api_uri'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    suffix = json['suffix'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    party = json['party'];
    leadershipRole = json['leadership_role'];
    twitterAccount = json['twitter_account'];
    facebookAccount = json['facebook_account'];
    youtubeAccount = json['youtube_account'];
    govtrackId = json['govtrack_id'];
    cspanId = json['cspan_id'];
    votesmartId = json['votesmart_id'];
    icpsrId = json['icpsr_id'];
    crpId = json['crp_id'];
    googleEntityId = json['google_entity_id'];
    fecCandidateId = json['fec_candidate_id'];
    url = json['url'];
    rssUrl = json['rss_url'];
    contactForm = json['contact_form'];
    inOffice = json['in_office'];
    cookPvi = json['cook_pvi'];
    dwNominate = json['dw_nominate'];
    idealPoint = json['ideal_point'];
    seniority = json['seniority'];
    nextElection = json['next_election'];
    totalVotes = json['total_votes'];
    missedVotes = json['missed_votes'];
    totalPresent = json['total_present'];
    lastUpdated = json['last_updated'];
    ocdId = json['ocd_id'];
    office = json['office'];
    phone = json['phone'];
    fax = json['fax'];
    state = json['state'];
    senateClass = json['senate_class'];
    stateRank = json['state_rank'];
    lisId = json['lis_id'];
    missedVotesPct = json['missed_votes_pct'];
    votesWithPartyPct = json['votes_with_party_pct'];
    votesAgainstPartyPct = json['votes_against_party_pct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['short_title'] = this.shortTitle;
    data['api_uri'] = this.apiUri;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['suffix'] = this.suffix;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['party'] = this.party;
    data['leadership_role'] = this.leadershipRole;
    data['twitter_account'] = this.twitterAccount;
    data['facebook_account'] = this.facebookAccount;
    data['youtube_account'] = this.youtubeAccount;
    data['govtrack_id'] = this.govtrackId;
    data['cspan_id'] = this.cspanId;
    data['votesmart_id'] = this.votesmartId;
    data['icpsr_id'] = this.icpsrId;
    data['crp_id'] = this.crpId;
    data['google_entity_id'] = this.googleEntityId;
    data['fec_candidate_id'] = this.fecCandidateId;
    data['url'] = this.url;
    data['rss_url'] = this.rssUrl;
    data['contact_form'] = this.contactForm;
    data['in_office'] = this.inOffice;
    data['cook_pvi'] = this.cookPvi;
    data['dw_nominate'] = this.dwNominate;
    data['ideal_point'] = this.idealPoint;
    data['seniority'] = this.seniority;
    data['next_election'] = this.nextElection;
    data['total_votes'] = this.totalVotes;
    data['missed_votes'] = this.missedVotes;
    data['total_present'] = this.totalPresent;
    data['last_updated'] = this.lastUpdated;
    data['ocd_id'] = this.ocdId;
    data['office'] = this.office;
    data['phone'] = this.phone;
    data['fax'] = this.fax;
    data['state'] = this.state;
    data['senate_class'] = this.senateClass;
    data['state_rank'] = this.stateRank;
    data['lis_id'] = this.lisId;
    data['missed_votes_pct'] = this.missedVotesPct;
    data['votes_with_party_pct'] = this.votesWithPartyPct;
    data['votes_against_party_pct'] = this.votesAgainstPartyPct;
    return data;
  }
}
