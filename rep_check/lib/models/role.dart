import 'comittee.dart';
import 'sub_committee.dart';

class Role {
  String congress;
  String chamber;
  String title;
  String shortTitle;
  String state;
  String party;
  String leadershipRole;
  String fecCandidateId;
  String seniority;
  String district;
  bool atLarge;
  String ocdId;
  String startDate;
  String endDate;
  String office;
  String phone;
  String fax;
  String contactForm;
  String cookPvi;
  double dwNominate;
  double idealPoint;
  String nextElection;
  int totalVotes;
  int missedVotes;
  int totalPresent;
  String senateClass;
  String stateRank;
  String lisId;
  int billsSponsored;
  int billsCosponsored;
  double missedVotesPct;
  double votesWithPartyPct;
  double votesAgainstPartyPct;
  List<Committee> committees;
  List<Subcommittee> subcommittees;

  Role(
      {this.congress,
      this.chamber,
      this.title,
      this.shortTitle,
      this.state,
      this.party,
      this.leadershipRole,
      this.fecCandidateId,
      this.seniority,
      this.district,
      this.atLarge,
      this.ocdId,
      this.startDate,
      this.endDate,
      this.office,
      this.phone,
      this.fax,
      this.contactForm,
      this.cookPvi,
      this.dwNominate,
      this.idealPoint,
      this.nextElection,
      this.totalVotes,
      this.missedVotes,
      this.totalPresent,
      this.senateClass,
      this.stateRank,
      this.lisId,
      this.billsSponsored,
      this.billsCosponsored,
      this.missedVotesPct,
      this.votesWithPartyPct,
      this.votesAgainstPartyPct,
      this.committees,
      this.subcommittees});

  Role.fromJson(Map<String, dynamic> json) {
    congress = json['congress'];
    chamber = json['chamber'];
    title = json['title'];
    shortTitle = json['short_title'];
    state = json['state'];
    party = json['party'];
    leadershipRole = json['leadership_role'];
    fecCandidateId = json['fec_candidate_id'];
    seniority = json['seniority'];
    district = json['district'];
    atLarge = json['at_large'];
    ocdId = json['ocd_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    office = json['office'];
    phone = json['phone'];
    fax = json['fax'];
    contactForm = json['contact_form'];
    cookPvi = json['cook_pvi'];
    dwNominate = json['dw_nominate'];
    idealPoint = json['ideal_point'];
    nextElection = json['next_election'];
    totalVotes = json['total_votes'];
    missedVotes = json['missed_votes'];
    totalPresent = json['total_present'];
    senateClass = json['senate_class'];
    stateRank = json['state_rank'];
    lisId = json['lis_id'];
    billsSponsored = json['bills_sponsored'];
    billsCosponsored = json['bills_cosponsored'];
    missedVotesPct = json['missed_votes_pct'];
    votesWithPartyPct = json['votes_with_party_pct'];
    votesAgainstPartyPct = json['votes_against_party_pct'];
    if (json['committees'] != null) {
      committees = new List<Committee>();
      json['committees'].forEach((v) {
        committees.add(new Committee.fromJson(v));
      });
    }
    if (json['subcommittees'] != null) {
      subcommittees = new List<Subcommittee>();
      json['subcommittees'].forEach((v) {
        subcommittees.add(new Subcommittee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['congress'] = this.congress;
    data['chamber'] = this.chamber;
    data['title'] = this.title;
    data['short_title'] = this.shortTitle;
    data['state'] = this.state;
    data['party'] = this.party;
    data['leadership_role'] = this.leadershipRole;
    data['fec_candidate_id'] = this.fecCandidateId;
    data['seniority'] = this.seniority;
    data['district'] = this.district;
    data['at_large'] = this.atLarge;
    data['ocd_id'] = this.ocdId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['office'] = this.office;
    data['phone'] = this.phone;
    data['fax'] = this.fax;
    data['contact_form'] = this.contactForm;
    data['cook_pvi'] = this.cookPvi;
    data['dw_nominate'] = this.dwNominate;
    data['ideal_point'] = this.idealPoint;
    data['next_election'] = this.nextElection;
    data['total_votes'] = this.totalVotes;
    data['missed_votes'] = this.missedVotes;
    data['total_present'] = this.totalPresent;
    data['senate_class'] = this.senateClass;
    data['state_rank'] = this.stateRank;
    data['lis_id'] = this.lisId;
    data['bills_sponsored'] = this.billsSponsored;
    data['bills_cosponsored'] = this.billsCosponsored;
    data['missed_votes_pct'] = this.missedVotesPct;
    data['votes_with_party_pct'] = this.votesWithPartyPct;
    data['votes_against_party_pct'] = this.votesAgainstPartyPct;
    if (this.committees != null) {
      data['committees'] = this.committees.map((v) => v.toJson()).toList();
    }
    if (this.subcommittees != null) {
      data['subcommittees'] =
          this.subcommittees.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
