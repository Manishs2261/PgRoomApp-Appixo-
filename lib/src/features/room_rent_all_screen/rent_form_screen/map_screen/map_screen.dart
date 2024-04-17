import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../../../res/route_name/routes_name.dart';
import '../../../../utils/Constants/colors.dart';
import 'controller/controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final controller = Get.put(MapScreenController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Map view"),
      ),
      body: FlutterLocationPicker(
        showSearchBar: false,
        searchbarBorderRadius: BorderRadius.circular(50),
        selectLocationButtonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.primary),
        ),
        initZoom: 11,
        minZoomLevel: 1,
        maxZoomLevel: 16,
        trackMyPosition: true,
        selectedLocationButtonTextstyle: const TextStyle(fontSize: 18),
        mapLanguage: 'en',
        onError: (e) => print(e),
        countryFilter: 'In',
        markerIcon: Icon(
          Icons.location_on_sharp,
          color: Colors.red,
          size: 60,
        ),
        selectLocationButtonLeadingIcon: const Icon(
          Icons.check,
        ),
        onPicked: (pickedData) {
          print(pickedData.latLong.latitude);
          print(pickedData.latLong.longitude);
          controller.latitude.value = pickedData.latLong.latitude.toString();
          controller.longitude.value = pickedData.latLong.longitude.toString();
          Get.toNamed(RoutesName.perimissionScreen);
        },
        showContributorBadgeForOSM: true,
      ),
    );
  }
}
