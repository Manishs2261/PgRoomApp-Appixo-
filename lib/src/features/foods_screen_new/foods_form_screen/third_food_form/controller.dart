import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

import '../../../../res/route_name/routes_name.dart';

class ThirdFoodFormController extends GetxController {
  final Completer<GoogleMapController> mapController =
  Completer<GoogleMapController>();

  final RxSet<Marker> markers = <Marker>{}.obs;

  LatLng? lastTappedPosition;

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(22.092196846135895, 82.12939292192459),
    zoom: 5,
  );

  @override
  void onInit() {
    // TODO: implement onInit
    _determinePosition();
    super.onInit();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Show dialog prompting user to enable location services
      _showLocationSettingsDialog();
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (kDebugMode) {
          print('Location permissions are denied.');
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Show dialog explaining the need for permissions
      _showPermissionDeniedForeverDialog();
      return;
    }

    // Fetch the current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Log current position
    if (kDebugMode) {
      print('Current Position: ${position.latitude}, ${position.longitude}');
    }

    // Update camera to current location
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(position.latitude, position.longitude),
      ),
    );

    // Add marker for current location
    markers.add(
      Marker(
        // ignore: prefer_const_constructors
        markerId: MarkerId('current_location'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(
          title: 'Current Location',
          snippet: 'Lat: ${position.latitude}, Lng: ${position.longitude}',
        ),
      ),
    );
  }

  void _showLocationSettingsDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text('Location Services Disabled'),
        content: const Text(
            'Location services are disabled. Please enable them in your device settings.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await Geolocator.openLocationSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _showPermissionDeniedForeverDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text('Location Permissions Denied'),
        content: const Text(
            'Location permissions are permanently denied. Please enable them in your device settings.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await Geolocator.openAppSettings();
            },
            child: const Text('Open App Settings'),
          ),
        ],
      ),
    );
  }

  void handleTap(LatLng tappedPoint) {
    // Clear previous markers if you only want one marker at a time
    markers.clear();

    // Add a new marker at the tapped position
    markers.add(
      Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        infoWindow: InfoWindow(
          title: 'Selected Location',
          snippet:
          'Lat: ${tappedPoint.latitude}, Lng: ${tappedPoint.longitude}',
        ),
      ),
    );

    // Save the last tapped position
    lastTappedPosition = tappedPoint;

    // Log the latitude and longitude
    if (kDebugMode) {
      print(
          'Tapped position: ${tappedPoint.latitude}, ${tappedPoint.longitude}');
    }
  }

  onSaveAndNext() {
    if (lastTappedPosition == null) {
      AppHelperFunction.showSnackBar("Please Select Location Marker");
      return;
    }

    Get.toNamed(RoutesName.fourthFoodFormScreen);
  }
}
