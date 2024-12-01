import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../common/widgets/com_reuse_elevated_button.dart';
import '../../../../res/route_name/routes_name.dart';
import '../../../../utils/logger/logger.dart';
import '../../../../utils/widgets/form_process_step.dart';
import 'controller.dart';

class ThirdRoomFormScreen extends StatelessWidget {
  ThirdRoomFormScreen({super.key});

  final controller = Get.put(ThirdRoomFormController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - ThirdRoomFormScreen......................................");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // Increase the height to accommodate the progress indicator
        title: FormProcessStep(
          isFormOne: true,
          isFormTwo: true,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
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
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
