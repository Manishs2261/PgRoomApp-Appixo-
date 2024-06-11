import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreenController extends GetxController {
  RxString roomsType = ''.obs;

  // var nameCity;
  // Placemark? place;
  //
  // Position? position;
  //
  // Future<Position> determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //
  //   if (!serviceEnabled) {
  //     Geolocator.requestPermission();
  //   }
  //
  //   // Check location permission status
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     // Request location permission using permission_handler
  //     PermissionStatus permissionStatus = await Permission.location.request();
  //
  //     if (permissionStatus.isDenied) {
  //       return Future.error('Location permissions are denied. Please grant location permissions.');
  //     } else if (permissionStatus.isPermanentlyDenied) {
  //       return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  //     }
  //   } else if (permission == LocationPermission.deniedForever) {
  //     return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   // When we reach here, permissions are granted and we can continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition();
  // }
  //
  // Future<void> getAddressFromLatLong(Position position) async {
  //   List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
  //
  //   place = placemark[0];
  //   if (kDebugMode) {
  //     print(place?.locality);
  //   }
  // }
  //
  // Future<void> getPosition() async {
  //   // This is your function
  //   position = await determinePosition();
  //   getAddressFromLatLong(position!);
  // }
}
