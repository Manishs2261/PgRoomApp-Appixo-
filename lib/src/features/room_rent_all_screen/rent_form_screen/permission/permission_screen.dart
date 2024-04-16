import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

 import '../../../../utils/widgets/my_check_box_widget.dart';
import '../data_save_controller/data_save_controller.dart';
import 'controller/permission_controller.dart';

class PermissionScreen extends StatelessWidget {
  PermissionScreen({super.key});

  final controller = Get.put(PermissionController());
  final saveController = Get.put(DataSaveController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - PermissionScreen ");

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 15, top: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Permission :- ",
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              //=======Permission ===============
              Column(
                children: [
                  //=============for cooking ============
                  Obx(
                    () => MYCheckBoxWidget(
                        title: "Cooking allow",
                        checkBool: controller.cookingAllow.value,
                        onChanged: (value) {
                          //controller method
                          controller.cookingAllowCondition(value);
                        }),
                  ),

                  // ===========for cooking conditions  ===============
                  Obx(
                    () => Visibility(
                      visible: (controller.cookingAllow.value),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Column(
                          children: [
                            //=============for veg allows============
                            Obx(
                              () => MYCheckBoxWidget(
                                  title: "veg only ",
                                  checkBool: controller.veg.value,
                                  onChanged: (value) {
                                    // controller method
                                    controller.vegOnlyCondition(value);
                                  }),
                            ),

                            //=============for Non-veg allows============

                            //=============for Both allows============
                            Obx(
                              () => MYCheckBoxWidget(
                                  title: "veg and non-veg both allow",
                                  checkBool: controller.bothVegAndNonVeg.value,
                                  onChanged: (value) {
                                    controller.vegAndNonVegCondition(value);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //=============for Girls allows============
              Obx(
                () => MYCheckBoxWidget(
                    title: "Girl allow",
                    checkBool: controller.girl.value,
                    onChanged: (value) {
                      controller.girl.value = value!;
                    }),
              ),

              //=============for Boys allows============
              Obx(
                () => MYCheckBoxWidget(
                    title: "Boy allow",
                    checkBool: controller.boy.value,
                    onChanged: (value) {
                      controller.boy.value = value!;
                    }),
              ),

              //=============for Family member allows============

              Obx(
                () => MYCheckBoxWidget(
                    title: "Family member  allow",
                    checkBool: controller.familyMember.value,
                    onChanged: (value) {
                      controller.familyMember.value = value!;
                    }),
              ),

              const SizedBox(
                height: 30,
              ),

              Obx(
                () => ComReuseElevButton(
                  onPressed: () => saveController.uploadData(),
                  title: "Save",
                  loading: saveController.loading.value,
                ),
              ),

               

            ],
          ),
        ),
      ),
    );
  }
}
