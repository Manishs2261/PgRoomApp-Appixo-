import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../model/user_rent_model/user_rent_model.dart';
import '../../../../uitels/widgets/my_check_boxwidget.dart';
import '../../../../uitels/widgets/my_text_form_field.dart';
import '../controller/controller.dart';

class EditAdditionalChargesAndDoorTime extends StatelessWidget {
  EditAdditionalChargesAndDoorTime({super.key});


  final itemId = Get.arguments["id"];
  final UserRentModel data = Get.arguments['list'];

  final controller = Get.put(
      EditFormScreenController(Get.arguments['list'], Get.arguments["id"]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Charges and Time"),),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Additional charges :- ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "In this chargs include your roon rent or not",
              style: TextStyle(color: Colors.orange),
            ),
            const SizedBox(
              height: 30,
            ),

            //======for Electricity bill =============
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                      () => MYCheckBoxWidget(
                      materialTapTargetSize:
                      MaterialTapTargetSize.shrinkWrap,
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
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
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
                Obx(() => (controller.restrictedTime.value)
                    ? Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MyTextFormWedgit(
                        textKeyBoard: TextInputType.number,
                        controller:
                        controller.restrictedController.value,
                        hintText: "Enter at time",
                        lableText: "Time",
                        isDense: true,
                        isCollapsed: true,
                        borderRadius: BorderRadius.zero,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                      ),
                    ))
                    : const Text(""))
              ],
            ),
            //=============for fexible time ============
            Obx(
                  () => MYCheckBoxWidget(
                  title: "Fexible time",
                  checkBool: controller.fexibleTime.value,
                  onChanged: (value) {
                    controller.fexibleTimeCondition(value);
                  }),
            ),

            SizedBox(
              height: 50,
            ),

            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {

                    controller.EditAdditionalChargesAndDoor().then((value) {
                      Get.back();
                      Get.back();

                    }).onError((error, stackTrace) {

                      Get.snackbar("error", "error");
                    });

                  }, child: Text("Update")),
            )
          ],
        ),
      ),
    );
  }
}
