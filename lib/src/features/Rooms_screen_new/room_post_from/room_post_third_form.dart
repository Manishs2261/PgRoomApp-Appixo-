import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
