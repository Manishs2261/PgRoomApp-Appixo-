import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../model/user_rent_model/user_rent_model.dart';
import '../../../../uitels/widgets/my_check_boxwidget.dart';
import '../../../../uitels/widgets/my_text_form_field.dart';
import '../controller/controller.dart';

class EditRoomTypeAndPrice extends StatelessWidget {
  EditRoomTypeAndPrice({super.key});

  final itemId = Get.arguments["id"];
  final UserRentModel data = Get.arguments['list'];

  final controller = Get.put(
      EditFormScreenController(Get.arguments['list'], Get.arguments["id"]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Edit Room Type And Price"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Hostel Type :- ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            (controller.bhk == "")
                ? Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 15, top: 80)),
                      Text("${data.roomType}",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ],
                  )
                : Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 15, top: 80)),
                      Text("${data.roomType}  - ",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      Text("${data.bhkType}",
                          style: TextStyle(
                            fontSize: 18,
                          )),
                    ],
                  ),

            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Room Type & Monthly Price :- ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            //========for Single Person ============
            Obx(
              () => Row(
                children: [
                  MYCheckBoxWidget(
                      title: "Single Person",
                      checkBool: controller.checkboxSingle1.value,
                      onChanged: (value) {
                        controller.checkboxSingle1.value = value!;
                      }),
                  Obx(
                    () => (controller.checkboxSingle1.value)
                        ? Flexible(
                            child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: MyTextFormWedgit(
                              textKeyBoard: TextInputType.number,
                              controller:
                                  controller.singlePersonContrller.value,
                              hintText: "Price",
                              lableText: "Price",
                              isCollapsed: true,
                              isDense: true,
                              borderRadius: BorderRadius.circular(11),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                            ),
                          ))
                        : const Text(""),
                  )
                ],
              ),
            ),

            //====== double person===========
            Obx(
              () => Row(
                children: [
                  MYCheckBoxWidget(
                      title: "Doble Person",
                      checkBool: controller.checkboxDoble2.value,
                      onChanged: (value) {
                        controller.checkboxDoble2.value = value!;
                      }),
                  Obx(
                    () => (controller.checkboxDoble2.value)
                        ? Flexible(
                            child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: MyTextFormWedgit(
                              textKeyBoard: TextInputType.number,
                              controller:
                                  controller.doublePersonContrller.value,
                              hintText: "Price",
                              lableText: "Price",
                              isCollapsed: true,
                              isDense: true,
                              borderRadius: BorderRadius.circular(11),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                            ),
                          ))
                        : const Text(""),
                  )
                ],
              ),
            ),
            //==========for Triple person ==========
            Obx(
              () => Row(
                children: [
                  MYCheckBoxWidget(
                      title: "Triple Person",
                      checkBool: controller.checkboxTriple3.value,
                      onChanged: (value) {
                        controller.checkboxTriple3.value = value!;
                      }),
                  Obx(
                    () => (controller.checkboxTriple3.value)
                        ? Flexible(
                            child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: MyTextFormWedgit(
                              textKeyBoard: TextInputType.number,
                              controller:
                                  controller.triplePersonContrller.value,
                              hintText: "Price",
                              lableText: "Price",
                              isCollapsed: true,
                              isDense: true,
                              borderRadius: BorderRadius.circular(11),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                            ),
                          ))
                        : const Text(""),
                  )
                ],
              ),
            ),
            //======four person room type =========
            Obx(
              () => Row(
                children: [
                  MYCheckBoxWidget(
                      title: "Four Person +",
                      checkBool: controller.checkboxFour4.value,
                      onChanged: (value) {
                        controller.checkboxFour4.value = value!;
                      }),
                  Obx(
                    () => (controller.checkboxFour4.value)
                        ? Flexible(
                            child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: MyTextFormWedgit(
                              textKeyBoard: TextInputType.number,
                              controller: controller.fourPersonContrller.value,
                              hintText: "Price",
                              lableText: "Price",
                              isCollapsed: true,
                              isDense: true,
                              borderRadius: BorderRadius.circular(11),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                            ),
                          ))
                        : const Text(""),
                  )
                ],
              ),
            ),

            //==========faimaly Room ===========
            Obx(
              () => Row(
                children: [
                  MYCheckBoxWidget(
                      title: "Faimaly Room / Flat",
                      checkBool: controller.checkboxFaimalyRoom.value,
                      onChanged: (value) {
                        controller.checkboxFaimalyRoom.value = value!;
                      }),
                  Obx(() => (controller.checkboxFaimalyRoom.value)
                      ? Flexible(
                          child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MyTextFormWedgit(
                            textKeyBoard: TextInputType.number,
                            controller: controller.faimlyPersonContrller.value,
                            hintText: "Price",
                            lableText: "Price",
                            isCollapsed: true,
                            isDense: true,
                            borderRadius: BorderRadius.circular(11),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                          ),
                        ))
                      : const Text(""))
                ],
              ),
            ),

            const SizedBox(
              height: 50,
            ),

            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    controller.EditRoomTypeAndPriceData().then((value) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }).onError((error, stackTrace) {
                      Get.snackbar("error", "error");
                    });
                  },
                  child: Text("Update")),
            )
          ],
        ),
      ),
    );
  }
}
