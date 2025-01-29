import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pgroom/src/features/foods_screen_new/model/food_model.dart';
import 'package:pgroom/src/features/services_screen/model/services_model.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

import '../../../../../res/route_name/routes_name.dart';

class ThirdFoodUpdateController extends GetxController {
  final Completer<GoogleMapController> mapController =
  Completer<GoogleMapController>();

  final RxSet<Marker> markers = <Marker>{}.obs;

  LatLng? lastTappedPosition;

  final FoodModel  foodModel = Get.arguments;

  late CameraPosition kGooglePlex;

  @override
  void onInit() {
    super.onInit();

    // Initialize the camera position to the service data location
    kGooglePlex = CameraPosition(
      target: LatLng(
        double.parse(foodModel.latitude.toString()),
        double.parse(foodModel.longitude.toString()),
      ),
      zoom: 5,
    );

    // Add an initial marker at the service data location
    _addInitialMarker();

    // Check and update location permissions
    _determinePosition();
  }

  void _addInitialMarker() {
    final initialPosition = LatLng(
      double.parse(foodModel.latitude.toString()),
      double.parse(foodModel.longitude.toString()),
    );

    markers.add(
      Marker(
        markerId: const MarkerId('initial_marker'),
        position: initialPosition,
        infoWindow: const InfoWindow(title: 'Initial Location'),
      ),
    );

    // Update last tapped position
    lastTappedPosition = initialPosition;
  }

  Future<void> _determinePosition() async {
    // Check and request location permissions
    final permissionGranted = await _checkLocationPermissions();
    if (!permissionGranted) return;

    // Get the current location
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (kDebugMode) {
      print('Current Position: ${position.latitude}, ${position.longitude}');
    }

    // Animate the camera to the current location
    final controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(position.latitude, position.longitude),
      ),
    );

    // Add a marker for the current location
    markers.add(
      Marker(
        markerId: const MarkerId('current_location'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(
          title: 'Current Location',
          snippet: 'Lat: ${position.latitude}, Lng: ${position.longitude}',
        ),
      ),
    );
  }

  Future<bool> _checkLocationPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationSettingsDialog();
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (kDebugMode) {
          print('Location permissions are denied.');
        }
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showPermissionDeniedForeverDialog();
      return false;
    }

    return true;
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
    // Update markers with a single new marker at the tapped position
    markers
      ..clear()
      ..add(
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

    if (kDebugMode) {
      print(
          'Tapped position: ${tappedPoint.latitude}, ${tappedPoint.longitude}');
    }
  }

  void onSaveAndNext() {
    if (lastTappedPosition == null) {
      AppHelperFunction.showSnackBar('Please Select Location Marker');
      return;
    }

    Get.toNamed(RoutesName.fourthFoodUpdateForm, arguments: foodModel);
  }
}
