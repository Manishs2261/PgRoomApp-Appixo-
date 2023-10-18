import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/view/rent_form_screen/hostel_and_room_type/controller/controller.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/flat_radio_button_wedget.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/hostel_radio_button_widget.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/my_check_boxwidget.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/my_text_form_field.dart';

class HostelAndRoomTypeScreen extends StatelessWidget {
  HostelAndRoomTypeScreen({super.key});

  final controller = Get.put(HostelAndRoomController());

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("build sceen => hostel screen 🔴");
    }
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===========Hostel type================={

                const Text(
                  "Hostel Type :- ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                // ======boys hostel =====
                Obx(
                  () => MyHostelRadioButtonWidget(
                      titel: "Boys Hostel",
                      value: HostelTypeEnum.BoysH,
                      hostelTypeEnum: controller.hostelTypeEnum.value,
                      onChange: (value) {
                        controller.boysHostelContions(value);
                      }),
                ),

                // ======Girls hostel =====
                Obx(
                  () => MyHostelRadioButtonWidget(
                      titel: "Girls Hostel",
                      value: HostelTypeEnum.GirlsH,
                      hostelTypeEnum: controller.hostelTypeEnum.value,
                      onChange: (value) {
                        controller.girlsHostelContions(value);
                      }),
                ),

                // ======Flat Room =====
                Obx(
                  () => MyHostelRadioButtonWidget(
                      titel: "Flat",
                      value: HostelTypeEnum.Faimaly,
                      hostelTypeEnum: controller.hostelTypeEnum.value,
                      onChange: (value) {
                        controller.flatTypeContionas(value);
                      }),
                ),

                Obx(() => (controller.isBool.value)
                    ? Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Column(
                          children: [
                            // ==========check a flat  conditiion==========

                            Obx(
                              () => MyFlatRadioButtonWidget(
                                  titel: "1BHK",
                                  value: FaltTypeEnum.OneBhk,
                                  flatTypeEnum: controller.faltTypeEnum.value,
                                  onChange: (value) {
                                    controller.oneBhkCondition(value);
                                  }),
                            ),

                            Obx(
                              () => MyFlatRadioButtonWidget(
                                  titel: "2BHK",
                                  value: FaltTypeEnum.TwoBhk,
                                  flatTypeEnum: controller.faltTypeEnum.value,
                                  onChange: (value) {
                                    controller.twoBhkCondition(value);
                                  }),
                            ),

                            Obx(
                              () => MyFlatRadioButtonWidget(
                                  titel: "3BHK",
                                  value: FaltTypeEnum.ThreeBhk,
                                  flatTypeEnum: controller.faltTypeEnum.value,
                                  onChange: (value) {
                                    controller.threeBhkCondition(value);
                                  }),
                            ),
                          ],
                        ),
                      )
                    : const Text("")),

                //==============================}

                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Room Type & Monthly Price :- ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                                  controller:
                                      controller.fourPersonContrller.value,
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
                                controller:
                                    controller.faimlyPersonContrller.value,
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
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        controller.onSubmitButton();

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             ProvideFacilitesScreen()));
                      },
                      child: Obx(
                        () => (controller.loading.value)
                            ? const CircularProgressIndicator(
                                color: Colors.blue,
                              )
                            : const Text("Save & Next"),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
