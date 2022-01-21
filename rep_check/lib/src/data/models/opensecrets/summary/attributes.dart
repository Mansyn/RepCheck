class Attributes {
  Attributes({
    required this.candName,
    required this.cid,
    required this.cycle,
    required this.state,
    required this.party,
    required this.chamber,
    required this.firstElected,
    required this.nextElection,
    required this.total,
    required this.spent,
    required this.cashOnHand,
    required this.debt,
    required this.origin,
    required this.source,
    required this.lastUpdated,
  });
  late final String candName;
  late final String cid;
  late final String cycle;
  late final String state;
  late final String party;
  late final String chamber;
  late final String firstElected;
  late final String nextElection;
  late final String total;
  late final String spent;
  late final String cashOnHand;
  late final String debt;
  late final String origin;
  late final String source;
  late final String lastUpdated;

  Attributes.fromJson(Map<String, dynamic> json) {
    candName = json['cand_name'];
    cid = json['cid'];
    cycle = json['cycle'];
    state = json['state'];
    party = json['party'];
    chamber = json['chamber'];
    firstElected = json['first_elected'];
    nextElection = json['next_election'];
    total = json['total'];
    spent = json['spent'];
    cashOnHand = json['cash_on_hand'];
    debt = json['debt'];
    origin = json['origin'];
    source = json['source'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cand_name'] = candName;
    _data['cid'] = cid;
    _data['cycle'] = cycle;
    _data['state'] = state;
    _data['party'] = party;
    _data['chamber'] = chamber;
    _data['first_elected'] = firstElected;
    _data['next_election'] = nextElection;
    _data['total'] = total;
    _data['spent'] = spent;
    _data['cash_on_hand'] = cashOnHand;
    _data['debt'] = debt;
    _data['origin'] = origin;
    _data['source'] = source;
    _data['last_updated'] = lastUpdated;
    return _data;
  }
}
