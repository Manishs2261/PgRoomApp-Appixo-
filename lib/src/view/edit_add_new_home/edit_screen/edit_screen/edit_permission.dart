import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../model/user_rent_model/user_rent_model.dart';
import '../../../../uitels/widgets/my_check_boxwidget.dart';
import '../controller/controller.dart';

class EditPermissiionScreen extends StatelessWidget {
  EditPermissiionScreen({super.key});

  final itemId = Get.arguments["id"];
  final UserRentModel data = Get.arguments['list'];

  final controller = Get.put(
      EditFormScreenController(Get.arguments['list'], Get.arguments["id"]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Permission"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
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
                      controller.EditPermissionData().then((value) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }).onError((error, stackTrace) {
                        Get.snackbar("error", "error");
                      });
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
