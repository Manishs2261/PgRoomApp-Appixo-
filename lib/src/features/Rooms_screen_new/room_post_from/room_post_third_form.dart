import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../common/widgets/com_reuse_elevated_button.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../utils/logger/logger.dart';
import '../../../utils/widgets/form_process_step.dart';

class ThirdRoomFormScreen extends StatefulWidget {
  const ThirdRoomFormScreen({super.key});

  @override
  State<ThirdRoomFormScreen> createState() => _ThirdRoomFormScreenState();
}

class _ThirdRoomFormScreenState extends State<ThirdRoomFormScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  Set<Marker> _markers = {}; // To hold the markers
  late LatLng _lastTappedPosition; // To store last tapped position

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng( 21.281420, 82.811522),
    zoom: 12.4746,
  );


  void _handleTap(LatLng tappedPoint) {
    setState(() {
      // Clear previous markers if you only want one marker at a time
      _markers.clear();

      // Add a new marker at the tapped position
      _markers.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          infoWindow: InfoWindow(
            title: 'Selected Location',
            snippet: 'Lat: ${tappedPoint.latitude}, Lng: ${tappedPoint.longitude}',
          ),
        ),
      );

      // Save the last tapped position
      _lastTappedPosition = tappedPoint;
    });

    // Log the latitude and longitude
    print('Tapped position: ${tappedPoint.latitude}, ${tappedPoint.longitude}');
  }



  @override
  Widget build(BuildContext context) {

    AppLoggerHelper.debug(
        "Build - ThirdRoomFormScreen......................................");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // Increase the height to accommodate the progress indicator
        title: FormProcessStep(isFormOne: true, isFormTwo: true, ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),


      body: Column(
        children: [

          Expanded(
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              markers: _markers, // Display markers on the map
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: _handleTap,


            ),
          ),
          // Save button
          SizedBox(height: 20),
          ReuseElevButton(
            onPressed: () =>Get.toNamed(RoutesName.fourthRoomFormScreen),
            title: "Save & Next",
          ),

          SizedBox(height: 20),
          ReuseElevButton(
            color: Colors.orange,
            onPressed: () =>Get.toNamed(RoutesName.fourthRoomFormScreen),
            title: "Back",
          ),
        ],
      ),
    );

  }


}

