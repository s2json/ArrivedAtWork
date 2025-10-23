import 'package:geolocator/geolocator.dart';

/// Determine the current position of the device.
Future<Position?> determinePosition() async {
  bool serviceEnabled;
  late LocationPermission permission;
  final Position position;
  const LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.bestForNavigation,
    distanceFilter: 10,
  );

  try {
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
    return position;
  } catch (e) {
    rethrow;
  }
}
