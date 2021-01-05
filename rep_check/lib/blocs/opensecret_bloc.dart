import 'dart:async';

import 'package:rep_check/repositories/secret_repository.dart';
import 'package:rep_check/responses/opensecrets/contributor_response.dart';
import 'package:rep_check/responses/opensecrets/legislator_response.dart';

class OpenSecretBloc {
  SecretRepository _secretRepository;

  OpenSecretBloc() {
    _secretRepository = SecretRepository();
  }

  Future<LegislatorResponse> fetchStateLegislators(String state) async {
    return await _secretRepository.fetchLegislators(state);
  }

  Future<ContributorResponse> fetchTopContributors(String id) async {
    return await _secretRepository.fetchContributors(id);
  }
}
