import 'package:geolocator/geolocator.dart';

class Location {
  double ? latitude;
  double ?longitude;


   Future<void > getCurrentlocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.low, distanceFilter: 100));
     latitude=position.latitude;
     longitude=position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
