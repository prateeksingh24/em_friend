import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LiveLocation {
  Future<Position> getCurrentLocation() async {
    await requestPermission();
    final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
    Position? position = await geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high));
    return position;
  }

  Future<void> requestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    while (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        continue;
      } else {
        break;
      }
    }
  }
}
