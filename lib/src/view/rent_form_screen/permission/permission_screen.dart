import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/view/rent_form_screen/data_save_controller/data_save_controller.dart';

 import 'package:pgroom/src/view/rent_form_screen/widget/my_check_boxwidget'
     '.dart';

import '../../../res/route_name/routes_name.dart';
import '../add_image_/controller/controller.dart';
import '../hostel_and_room_type/controller/controller.dart';
import '../rent_details/controller/controller.dart';
import 'controller/permission_controller.dart';

class PermissioinScreen extends StatelessWidget {
  PermissioinScreen({super.key});

  final controller = Get.put(PermissionController());
  final saveController = Get.put(DataSaveController());


  @override
  Widget build(BuildContext context) {

    if (kDebugMode) {
      print("build screen => permission 🔴");
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Permission :- ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              //=======PErmission ===============
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

                  // ===========for coocking conditions  ===============
                  Obx(
                    () => (controller.cookingAllow.value)
                        ? Padding(
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
                                      checkBool:
                                          controller.bothVegAndNonVeg.value,
                                      onChanged: (value) {
                                        controller.vegAndNonVegCondition(value);
                                      }),
                                ),
                              ],
                            ),
                          )
                        : const Text(""),
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
                    checkBool: controller.faimlyMamber.value,
                    onChanged: (value) {
                      controller.faimlyMamber.value = value!;
                    }),
              ),

              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      //call controller method
                      saveController.uploadData();


                    },
                    child: Obx(
                      () => (controller.loading.value)
                          ? const CircularProgressIndicator(
                              color: Colors.blue,
                            )
                          : const Text("Save "),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
