

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../utils/logger/logger.dart';
import '../../../../../utils/widgets/com_reuse_elevated_button.dart';
import '../../../../../utils/widgets/form_process_step.dart';
import 'controller/controller.dart';

class ThirdRoomUpdateFormScreen extends StatelessWidget {
  ThirdRoomUpdateFormScreen({super.key});

  final controller = Get.put(ThirdRoomUpdateFormController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - ThirdRoomFormScreen......................................");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Map',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
                  () => GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: controller.kGooglePlex,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                compassEnabled: true,
                markers: controller.markers.toSet(),
                // Use toSet() to get a standard Set
                onMapCreated: (GoogleMapController controller1) {
                  controller.mapController.complete(controller1);
                },
                onTap: controller.handleTap,
              ),
            ),
          ),
          // Save button
          const SizedBox(height: 20),
          ReuseElevButton(
            onPressed: () =>  controller.onSaveAndNext(),
            title: "Save & Next",
          ),
          const SizedBox(height: 20),
          ReuseElevButton(
            color: Colors.orange,
            onPressed: () => Get.back(),
            title: "Back",
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

