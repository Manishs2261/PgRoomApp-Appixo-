import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/features/room_rent_all_screen/rent_form_screen/hostel_and_room_type/widgets/HostelTypeWidgets.dart';
import 'package:pgroom/src/features/room_rent_all_screen/rent_form_screen/hostel_and_room_type/widgets/RoomPriceWidgets.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'controller/controller.dart';

class HostelAndRoomTypeScreen extends StatelessWidget {
  HostelAndRoomTypeScreen({super.key});

  final hostelController = Get.put(HostelAndRoomController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - HostelAndRoomTypeScreen");

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 15, top: 10),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===========Hostel type================={

              HostelTypeWidgets(hostelController: hostelController),

              const SizedBox(
                height: 20,
              ),

              RoomPriceWidgets(hostelController: hostelController),

              const SizedBox(
                height: 20,
              ),

              // Next button

              ReuseElevButton(
                onPressed: () => hostelController.onSubmitButton(),
                title: "Next",
                loading: hostelController.loading.value,
              )
            ],
          )),
        ),
      ),
    );
  }
}
