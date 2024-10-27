import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import '../../../../../model/user_rent_model/user_rent_model.dart';
import '../../../../../utils/widgets/my_check_box_widget.dart';
import '../../../../../utils/widgets/my_text_form_field.dart';
import '../controller/controller.dart';

class EditRoomTypeAndPrice extends StatelessWidget {
  EditRoomTypeAndPrice({super.key});

  final itemId = Get.arguments["id"];
  final UserRentModel data = Get.arguments['list'];

  final controller = Get.put(EditFormScreenController(Get.arguments['list'], Get.arguments["id"]));

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - EditRoomTypeAndPrice");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Room Type And Price"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hostel Type :- ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              (controller.bhk.value == "")
                  ? Row(
                      children: [
                        const Padding(padding: EdgeInsets.only(left: 15, top: 80)),
                        Text("${data.roomType}",
                            style: const TextStyle(
                              fontSize: 20,
                            )),
                      ],
                    )
                  : Row(
                      children: [
                        const Padding(padding: EdgeInsets.only(left: 15, top: 80)),
                        Text("${data.roomType}  - ",
                            style: const TextStyle(
                              fontSize: 20,
                            )),
                        Text("${data.bhkType}",
                            style: const TextStyle(
                              fontSize: 18,
                            )),
                      ],
                    ),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
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
                      () => Visibility(
                        visible: (controller.checkboxSingle1.value),
                        child: Flexible(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MyTextFormWidget(
                            textKeyBoard: TextInputType.number,
                            controller: controller.singlePersonController.value,
                            hintText: "Price",
                            labelText: "Price",
                            isCollapsed: true,
                            isDense: true,
                            maxLength: 6,
                            borderRadius: BorderRadius.circular(11),
                            contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                            ],
                          ),
                        )),
                      ),
                    )
                  ],
                ),
              ),

              //====== double person===========
              Obx(
                () => Row(
                  children: [
                    MYCheckBoxWidget(
                        title: "Double Person",
                        checkBool: controller.checkboxDouble2.value,
                        onChanged: (value) {
                          controller.checkboxDouble2.value = value!;
                        }),
                    Obx(() => Visibility(
                          visible: (controller.checkboxDouble2.value),
                          child: Flexible(
                              child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: MyTextFormWidget(
                              textKeyBoard: TextInputType.number,
                              controller: controller.doublePersonController.value,
                              hintText: "Price",
                              labelText: "Price",
                              isCollapsed: true,
                              maxLength: 6,
                              isDense: true,
                              borderRadius: BorderRadius.circular(11),
                              contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                              ],
                            ),
                          )),
                        ))
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
                      () => Visibility(
                        visible: (controller.checkboxTriple3.value),
                        child: Flexible(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MyTextFormWidget(
                            textKeyBoard: TextInputType.number,
                            controller: controller.triplePersonController.value,
                            hintText: "Price",
                            labelText: "Price",
                            isCollapsed: true,
                            isDense: true,
                            maxLength: 6,
                            borderRadius: BorderRadius.circular(11),
                            contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                            ],
                          ),
                        )),
                      ),
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
                      () => Visibility(
                        visible: (controller.checkboxFour4.value),
                        child: Flexible(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MyTextFormWidget(
                            textKeyBoard: TextInputType.number,
                            controller: controller.fourPersonController.value,
                            hintText: "Price",
                            labelText: "Price",
                            isCollapsed: true,
                            isDense: true,
                            maxLength: 6,
                            borderRadius: BorderRadius.circular(11),
                            contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                            ],
                          ),
                        )),
                      ),
                    )
                  ],
                ),
              ),

              //==========family Room ===========
              Obx(
                () => Row(
                  children: [
                    MYCheckBoxWidget(
                        title: "Family Room / Flat",
                        checkBool: controller.checkboxFamilyRoom.value,
                        onChanged: (value) {
                          controller.checkboxFamilyRoom.value = value!;
                        }),
                    Obx(
                      () => Visibility(
                        visible: (controller.checkboxFamilyRoom.value),
                        child: Flexible(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MyTextFormWidget(
                            textKeyBoard: TextInputType.number,
                            controller: controller.familyPersonController.value,
                            hintText: "Price",
                            labelText: "Price",
                            isCollapsed: true,
                            isDense: true,
                            maxLength: 6,
                            borderRadius: BorderRadius.circular(11),
                            contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              ReuseElevButton(onPressed: () => controller.onEditRoomTypeAndPriceData(), title: 'Update')
            ],
          ),
        ),
      ),
    );
  }
}
