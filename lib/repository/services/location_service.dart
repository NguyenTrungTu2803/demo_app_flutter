import 'dart:async';

import 'package:flutter_app_beats/data_model/user_location.dart';
import 'package:location/location.dart';

class LocationService {
  UserLocation? _currentLocation;
  var location = Location();
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();
  Stream<UserLocation> get locationStream => _locationController.stream;
  LocationService() {
    location.requestPermission().then((granted) {
      // ignore: unrelated_type_equality_checks
      if (granted != null) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationController.add(UserLocation(
                latitude: locationData.latitude,
                longitude: locationData.longitude));
          }else{

          }
        }).onError((handleError){

        });
      }
    }).catchError((onError){

    });
  }

  Future<UserLocation?> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
          latitude: userLocation.latitude, longitude: userLocation.longitude);
    } catch (e) {
      print("Could not get  the location $e");
    }
    return _currentLocation;
  }
}
