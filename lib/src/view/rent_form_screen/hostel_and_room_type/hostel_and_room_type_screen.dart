import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/uitels/text_field_validator/text_field_validator.dart';
import 'package:pgroom/src/view/rent_form_screen/add_image_/controller/controller.dart';
import 'package:pgroom/src/view/rent_form_screen/hostel_and_room_type/controller/controller.dart';
import 'package:pgroom/src/view/rent_form_screen/rent_details/controller/controller.dart';
import 'package:pgroom/src/uitels/widgets/flat_radio_button_wedget.dart';
import 'package:pgroom/src/uitels/widgets/hostel_radio_button_widget.dart';
import 'package:pgroom/src/uitels/widgets/my_check_boxwidget.dart';
import 'package:pgroom/src/uitels/widgets/my_text_form_field.dart';

import '../../../res/route_name/routes_name.dart';

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
          padding: const EdgeInsets.only(left: 25, right: 15, top: 10),
          child: SingleChildScrollView(
            child: HostelAndRoomWidgets(hostelController: controller),
          ),
        ),
      ),
    );
  }
}

class HostelAndRoomWidgets extends StatelessWidget {
  const HostelAndRoomWidgets({
    super.key,
    required this.hostelController,
  });

  final HostelAndRoomController hostelController;

  @override
  Widget build(BuildContext context) {
    return Column(
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
              hostelTypeEnum: hostelController.hostelTypeEnum.value,
              onChange: (value) {
                hostelController.boysHostelContions(value);
              }),
        ),

        // ======Girls hostel =====
        Obx(
          () => MyHostelRadioButtonWidget(
              titel: "Girls Hostel",
              value: HostelTypeEnum.GirlsH,
              hostelTypeEnum: hostelController.hostelTypeEnum.value,
              onChange: (value) {
                hostelController.girlsHostelContions(value);
              }),
        ),

        // ======Flat Room =====
        Obx(
          () => MyHostelRadioButtonWidget(
              titel: "Flat",
              value: HostelTypeEnum.Faimaly,
              hostelTypeEnum: hostelController.hostelTypeEnum.value,
              onChange: (value) {
                hostelController.flatTypeContionas(value);
              }),
        ),

        Obx(() => (hostelController.isBool.value)
            ? Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Column(
                  children: [
                    // ==========check a flat  conditiion==========

                    Obx(
                      () => MyFlatRadioButtonWidget(
                          titel: "1BHK",
                          value: FaltTypeEnum.OneBhk,
                          flatTypeEnum: hostelController.faltTypeEnum.value,
                          onChange: (value) {
                            hostelController.oneBhkCondition(value);
                          }),
                    ),

                    Obx(
                      () => MyFlatRadioButtonWidget(
                          titel: "2BHK",
                          value: FaltTypeEnum.TwoBhk,
                          flatTypeEnum: hostelController.faltTypeEnum.value,
                          onChange: (value) {
                            hostelController.twoBhkCondition(value);
                          }),
                    ),

                    Obx(
                      () => MyFlatRadioButtonWidget(
                          titel: "3BHK",
                          value: FaltTypeEnum.ThreeBhk,
                          flatTypeEnum: hostelController.faltTypeEnum.value,
                          onChange: (value) {
                            hostelController.threeBhkCondition(value);
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
                  checkBool: hostelController.checkboxSingle1.value,
                  onChanged: (value) {
                    hostelController.checkboxSingle1.value = value!;
                  }),
              Obx(
                () => (hostelController.checkboxSingle1.value)
                    ? Flexible(
                        child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MyTextFormWedgit(
                          textKeyBoard: TextInputType.number,
                          controller:
                              hostelController.singlePersonContrller.value,
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
                  checkBool: hostelController.checkboxDoble2.value,
                  onChanged: (value) {
                    hostelController.checkboxDoble2.value = value!;
                  }),
              Obx(
                () => (hostelController.checkboxDoble2.value)
                    ? Flexible(
                        child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MyTextFormWedgit(
                          textKeyBoard: TextInputType.number,
                          controller:
                              hostelController.doublePersonContrller.value,
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
                  checkBool: hostelController.checkboxTriple3.value,
                  onChanged: (value) {
                    hostelController.checkboxTriple3.value = value!;
                  }),
              Obx(
                () => (hostelController.checkboxTriple3.value)
                    ? Flexible(
                        child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MyTextFormWedgit(
                          textKeyBoard: TextInputType.number,
                          controller:
                              hostelController.triplePersonContrller.value,
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
                  checkBool: hostelController.checkboxFour4.value,
                  onChanged: (value) {
                    hostelController.checkboxFour4.value = value!;
                  }),
              Obx(
                () => (hostelController.checkboxFour4.value)
                    ? Flexible(
                        child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MyTextFormWedgit(
                          textKeyBoard: TextInputType.number,
                          controller:
                              hostelController.fourPersonContrller.value,
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
                  checkBool: hostelController.checkboxFaimalyRoom.value,
                  onChanged: (value) {
                    hostelController.checkboxFaimalyRoom.value = value!;
                  }),
              Obx(() => (hostelController.checkboxFaimalyRoom.value)
                  ? Flexible(
                      child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MyTextFormWedgit(
                        textKeyBoard: TextInputType.number,
                        controller:
                            hostelController.faimlyPersonContrller.value,
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
                //contorller method
                hostelController.onSubimitButton();
              },
              child: Obx(
                () => (hostelController.loading.value)
                    ? const CircularProgressIndicator(
                        color: Colors.blue,
                      )
                    : const Text("Save & Next"),
              )),
        )
      ],
    );
  }
}
