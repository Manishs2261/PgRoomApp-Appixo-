import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../../../../model/user_rent_model/user_rent_model.dart';
import '../../../../../res/route_name/routes_name.dart';
import '../../../../../utils/Constants/colors.dart';
import '../controller/controller.dart';

class EditMapViewScreen extends StatefulWidget {
  const EditMapViewScreen({super.key});

  @override
  State<EditMapViewScreen> createState() => _EditMapViewScreenState();
}

class _EditMapViewScreenState extends State<EditMapViewScreen> {

  final itemId = Get.arguments["id"];
  final UserRentModel data = Get.arguments['list'];

  final controller = Get.put(EditFormScreenController( Get.arguments['list'],Get.arguments["id"]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose Map view"),),
      body: FlutterLocationPicker(
        showSearchBar: false,
        searchbarBorderRadius: BorderRadius.circular(50),
        selectLocationButtonText: 'set a Location',

        selectLocationButtonStyle: ButtonStyle(

          backgroundColor: MaterialStateProperty.all(AppColors.primary),
        ),
        initZoom: 11,
        minZoomLevel: 1,
        maxZoomLevel: 16,
        trackMyPosition: true,
         countryFilter: 'India',

        searchBarBackgroundColor: Colors.white,

        selectedLocationButtonTextstyle: const TextStyle(fontSize: 18),
        mapLanguage: 'en',
        onError: (e) => print(e),

        selectLocationButtonLeadingIcon: const Icon(Icons.check),
        onPicked: (pickedData) {
          print(pickedData.latLong.latitude);
          print(pickedData.latLong.longitude);
          controller.latitude.value = pickedData.latLong.latitude.toString();
          controller.longitude.value = pickedData.latLong.longitude.toString();
         controller.onEditMapViewData();

        },

        showContributorBadgeForOSM: true,
      ),
    );
  }
}
