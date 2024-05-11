import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../../../../model/user_rent_model/user_rent_model.dart';

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

  final controller = Get.put(EditFormScreenController(Get.arguments['list'], Get.arguments["id"]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Choose Map view"),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 280),
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.refresh_outlined,
              color: Colors.white,
            ),
            onPressed: () {


              setState(() {

              });
            },
          ),
        ),
        body: Stack(
          children: [
            FlutterLocationPicker(
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
              markerIcon: const Icon(
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
                controller.onEditMapViewData();
              },
              showContributorBadgeForOSM: true,
            ),
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Agne',
                ),
                child: AnimatedTextKit(
                  totalRepeatCount: 100,
                  animatedTexts: [
                    TypewriterAnimatedText('Please wait a moment while I fetch a marker 📍.',
                        textStyle: const TextStyle(color: Colors.red)),
                    TypewriterAnimatedText('If I can not fetch it', textStyle: const TextStyle(color: Colors.red)),
                    TypewriterAnimatedText('It will refresh the page.',
                        textStyle: const TextStyle(color: Colors.green)),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
              ),
            )
          ],
        ));
  }
}
