import 'dart:async';

import 'package:geocoder/model.dart';
import 'package:rep_check/repositories/location_repository.dart';

class LocationBloc {
  LocationRepository _locationRepository;

  LocationBloc() {
    _locationRepository = LocationRepository();
    fetchLocation();
  }

  Future<Address> fetchLocation() async {
    return await _locationRepository.getLocation();
  }
}
