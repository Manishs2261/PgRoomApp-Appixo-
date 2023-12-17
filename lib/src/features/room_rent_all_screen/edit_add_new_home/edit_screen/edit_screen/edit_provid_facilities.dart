import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../../../model/user_rent_model/user_rent_model.dart';
import '../../../../../utils/widgets/my_check_box_widget.dart';
import '../controller/controller.dart';

class EditProvideFacilites extends StatelessWidget {
  EditProvideFacilites({super.key});

  final itemId = Get.arguments["id"];
  final UserRentModel data = Get.arguments['list'];

  final controller = Get.put(EditFormScreenController(Get.arguments['list'], Get.arguments["id"]));

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - EditProvideFacilities");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Provide Facilities"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Provide a Facilities :- ",
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              //======for Wi-fi==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Wi-Fi",
                    checkBool: controller.wifi.value,
                    onChanged: (value) {
                      controller.wifi.value = value!;
                    }),
              ),
              //======for Bed==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Bed",
                    checkBool: controller.bed.value,
                    onChanged: (value) {
                      controller.bed.value = value!;
                    }),
              ),

              //======for chairs==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Chair",
                    checkBool: controller.chair.value,
                    onChanged: (value) {
                      controller.chair.value = value!;
                    }),
              ),

              //======for Table ==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Table",
                    checkBool: controller.table.value,
                    onChanged: (value) {
                      controller.table.value = value!;
                    }),
              ),
              //======for Fan==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Fan",
                    checkBool: controller.fan.value,
                    onChanged: (value) {
                      controller.fan.value = value!;
                    }),
              ),
              //======for Gadda==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Gadda",
                    checkBool: controller.gadda.value,
                    onChanged: (value) {
                      controller.gadda.value = value!;
                    }),
              ),
              //======for Light==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Light",
                    checkBool: controller.light.value,
                    onChanged: (value) {
                      controller.light.value = value!;
                    }),
              ),
              //======for Locker==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Locker",
                    checkBool: controller.locker.value,
                    onChanged: (value) {
                      controller.locker.value = value!;
                    }),
              ),
              //======for Bedsheet==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Bed Sheet",
                    checkBool: controller.bedSheet.value,
                    onChanged: (value) {
                      controller.bedSheet.value = value!;
                    }),
              ),
              //======for washing machine==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Washing Machine",
                    checkBool: controller.washingMachine.value,
                    onChanged: (value) {
                      controller.washingMachine.value = value!;
                    }),
              ),
              //======for parking==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Parking",
                    checkBool: controller.parking.value,
                    onChanged: (value) {
                      controller.parking.value = value!;
                    }),
              ),
              Obx(
                () => MYCheckBoxWidget(
                    title: "attach Bathroom",
                    checkBool: controller.attachBathroom.value,
                    onChanged: (value) {
                      controller.attachBathroom.value = value!;
                    }),
              ),
              Obx(
                () => MYCheckBoxWidget(
                    title: "shareable Bathroom",
                    checkBool: controller.shareableBathroom.value,
                    onChanged: (value) {
                      controller.shareableBathroom.value = value!;
                    }),
              ),

              const SizedBox(
                height: 50,
              ),

              ComReuseElevButton(onPressed: () => controller.onEditProviderFacilitiesData(), title: "Update")
            ],
          ),
        ),
      ),
    );
  }
}
