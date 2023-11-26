import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'package:pgroom/src/view/rent_form_screen/hostel_and_room_type/controller/controller.dart';
import 'package:pgroom/src/view/rent_form_screen/hostel_and_room_type/widgets/HostelTypeWidgets.dart';
import 'package:pgroom/src/view/rent_form_screen/hostel_and_room_type/widgets/RoomPriceWidgets.dart';

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
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      hostelController.onSubimitButton();
                    },
                    child: Obx(
                      () => (hostelController.loading.value)
                          ? const CircularProgressIndicator(
                              color: Colors.blue,
                            )
                          : const Text("Next"),
                    )),
              )
            ],
          )),
        ),
      ),
    );
  }
}
