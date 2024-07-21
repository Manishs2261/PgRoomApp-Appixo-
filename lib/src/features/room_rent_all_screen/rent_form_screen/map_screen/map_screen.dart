 import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import '../../../../res/route_name/routes_name.dart';
import '../../../../utils/Constants/colors.dart';
import 'controller/controller.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => super.widget));
              });
            },
          ),
        ),
        body: Stack(
          children: [
            FlutterLocationPicker(
              showSearchBar: false,
              selectLocationButtonStyle: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.primary),
              ),
              initZoom: 11,
              minZoomLevel: 1,
              maxZoomLevel: 16,
              trackMyPosition: true,
              selectedLocationButtonTextstyle: const TextStyle(fontSize: 18),
              mapLanguage: 'en',

              countryFilter: 'India',
              markerIcon: const Icon(
                Icons.location_on_sharp,
                color: Colors.red,
                size: 60,
              ),
              selectLocationButtonLeadingIcon: const Icon(
                Icons.check,
              ),
              onPicked: (pickedData) {
                if (kDebugMode) {
                  print(pickedData.latLong.latitude);
                }
                if (kDebugMode) {
                  print(pickedData.latLong.longitude);
                }
                controller.latitude.value = pickedData.latLong.latitude.toString();
                controller.longitude.value = pickedData.latLong.longitude.toString();
                Get.toNamed(RoutesName.perimissionScreen);
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
                  },
                ),
              ),
            )
          ],
        ));
  }
}
