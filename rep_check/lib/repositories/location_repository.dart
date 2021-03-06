import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class LocationRepository {
  Future<Address> getLocation() async {
    LocationData _locationData = await Location().getLocation();

    final coordinates =
        Coordinates(_locationData.latitude, _locationData.longitude);

    debugPrint(
        'latitude: ${_locationData.latitude} longitude: ${_locationData.longitude}');

    List<Address> addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
  }
}
