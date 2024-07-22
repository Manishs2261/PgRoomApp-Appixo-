import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'package:pgroom/src/utils/widgets/my_text_form_field.dart';
import '../../../../utils/widgets/my_check_box_widget.dart';
import 'controller/controller.dart';

class ChargesAndDoorTime extends StatelessWidget {
  ChargesAndDoorTime({super.key});

  final controller = Get.put(AdditionalChargesController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - ChargesAndDoorTime ");
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 15, top: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Additional charges :- ",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Text(
                    "In this charges include your room rent or not",
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
                  Text(
                    "Door Closing Time :- ",
                    style: Theme.of(context).textTheme.headlineSmall,
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
                      Obx(
                        () => Visibility(
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
                              isCollapsed: true,
                              maxLength: 8,
                              borderRadius: BorderRadius.zero,
                              contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                              ],
                            ),
                          )),
                        ),
                      ),
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
                    height: 20,
                  ),

                  ComReuseElevButton(
                    onPressed: () => controller.onSubmitButton(),
                    title: "Next",
                    loading: controller.loading.value,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
