import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/utils/Constants/sizes.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import '../../../../../model/user_rent_model/user_rent_model.dart';
import '../../../../../utils/widgets/my_check_box_widget.dart';
import '../../../../../utils/widgets/my_text_form_field.dart';
import '../controller/controller.dart';

class EditAdditionalChargesAndDoorTime extends StatelessWidget {
  EditAdditionalChargesAndDoorTime({super.key});

  final itemId = Get.arguments["id"];
  final UserRentModel data = Get.arguments['list'];

  final controller = Get.put(EditFormScreenController(Get.arguments['list'], Get.arguments["id"]));

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - EditAdditionalChargesAndDoorTime");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Charges and Time"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Additional charges :- ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                "In this charges include your room rent or not",
                style: TextStyle(color: Colors.orange),
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSSections,
              ),

              //======for Electricity bill =============
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => MYCheckBoxWidget(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        title: "Electricity Bill",
                        checkBool: controller.electricityBill.value,
                        onChanged: (value) {
                          controller.electricityBill.value = value!;
                        }),
                  ),

                  // ==========for checking Electricity bill condition=======
                  Obx(
                    () => controller.electricityBill.value
                        ? const Text(
                            "Electricity bill are include in your room rent",
                            style: TextStyle(color: Colors.green),
                          )
                        : const Text(
                            "Electricity bill are not include in your room rent",
                            style: TextStyle(color: Colors.orange),
                          ),
                  )
                ],
              ),

              //======for water bill =============
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => MYCheckBoxWidget(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            title: "Water Bill",
                            checkBool: controller.waterBill.value,
                            onChanged: (value) {
                              controller.waterBill.value = value!;
                            }),
                      ),
                    ],
                  ),
                  //=========for checking water bill condition============
                  Obx(
                    () => controller.waterBill.value
                        ? const Text(
                            "Water bill are  include in your room rent",
                            style: TextStyle(color: Colors.green),
                          )
                        : const Text(
                            "Water bill are not include in your room rent",
                            style: TextStyle(color: Colors.orange),
                          ),
                  )
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              const Text(
                "Door Closing Time :- ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  //=============for Restricted Time ============
                  Obx(
                    () => MYCheckBoxWidget(
                        title: "Restricted Time",
                        checkBool: controller.restrictedTime.value,
                        onChanged: (value) {
                          controller.restrictedTimeCondition(value);
                        }),
                  ),
                  // =======for checking a condition ===========
                  Visibility(
                    visible: (controller.restrictedTime.value),
                    child: Flexible(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MyTextFormWidget(
                        textKeyBoard: TextInputType.text,
                        controller: controller.restrictedController.value,
                        hintText: "Enter at time",
                        labelText: "Time",
                        isDense: true,
                        maxLength: 8,
                        isCollapsed: true,
                        borderRadius: BorderRadius.zero,
                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                        ],
                      ),
                    )),
                  )
                ],
              ),
              //=============for flexible time ============
              Obx(
                () => MYCheckBoxWidget(
                    title: "Flexible time",
                    checkBool: controller.flexibleTime.value,
                    onChanged: (value) {
                      controller.flexibleTimeCondition(value);
                    }),
              ),

              const SizedBox(
                height: 50,
              ),

              ReuseElevButton(
                onPressed: () => controller.onEditAdditionalChargesAndDoor(),
                title: "Update",
              )
            ],
          ),
        ),
      ),
    );
  }
}
