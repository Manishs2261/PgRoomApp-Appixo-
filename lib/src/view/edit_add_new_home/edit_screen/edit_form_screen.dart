import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/view/edit_add_new_home/edit_screen/controller/controller.dart';
import 'package:pgroom/src/view/rent_form_screen/add_image_/add_image_screen.dart';
import 'package:pgroom/src/view/rent_form_screen/provide_facilites/provide_facilites_screen.dart';

import '../../../model/user_rent_model/user_rent_model.dart';
import '../../../uitels/text_field_validator/text_field_validator.dart';

import '../../../uitels/widgets/my_check_boxwidget.dart';
import '../../rent_form_screen/hostel_and_room_type/controller/controller.dart';
import '../../rent_form_screen/hostel_and_room_type/hostel_and_room_type_screen.dart';
import '../../rent_form_screen/rent_details/controller/controller.dart';
import '../../rent_form_screen/rent_details/rent_details_screen.dart';
import '../../../uitels/widgets/my_text_form_field.dart';
import '../../../uitels/widgets/flat_radio_button_wedget.dart';
import '../../../uitels/widgets/hostel_radio_button_widget.dart';

class EditFormScreen extends StatelessWidget {
  EditFormScreen({super.key});



  final itemId = Get.arguments["id"];
  final UserRentModel data = Get.arguments['list'];



  final controller = Get.put(EditFormScreenController(Get.arguments['list']));






  final houseNameController =
      TextEditingController(text: Get.arguments['list'].houseName);
  final houseAddressController =
      TextEditingController(text: Get.arguments['list'].addres);
  final cityNameController =
      TextEditingController(text: Get.arguments['list'].city);
  final landdMarkController =
      TextEditingController(text: Get.arguments['list'].landMark);
  final contactNumberController =
      TextEditingController(text: Get.arguments['list'].contactNumber);

  final singlePersonContrller =
      TextEditingController(text: Get.arguments['list'].singlePersonPrice);
  final doublePersonContrller =
      TextEditingController(text: Get.arguments['list'].doublePersionPrice);
  final triplePersonContrller =
      TextEditingController(text: Get.arguments['list'].triplePersionPrice);
  final fourPersonContrller =
      TextEditingController(text: Get.arguments['list'].fourPersionPrice);
  final faimlyPersonContrller =
      TextEditingController(text: Get.arguments['list'].faimlyPrice);

  final _globlekey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("Build Screen => Edit_Form_Screen ❤");
    print(data.addres);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
          child: Column(
            children: [
              Form(
                key: _globlekey,
                child: Column(
                  children: [
                    // =================Home Name================
                    MyTextFormWedgit(
                      controller: houseNameController,
                      hintText: "Enter Home / House Name",
                      lableText: 'House Name',
                      icon: const Icon(Icons.home),
                      borderRadius: BorderRadius.circular(11),
                      contentPadding: const EdgeInsets.only(top: 5, left: 10),
                      validator: EmailValidator.validate,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //==========House Address================
                    MyTextFormWedgit(
                      controller: houseAddressController,
                      hintText: "House Address",
                      lableText: 'House addsress',
                      icon: const Icon(Icons.location_city_outlined),
                      borderRadius: BorderRadius.circular(11),
                      contentPadding: const EdgeInsets.only(top: 5, left: 10),
                      validator: AddressValidator.validate,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //===========City Name================
                    MyTextFormWedgit(
                      controller: cityNameController,
                      hintText: "City Name",
                      lableText: 'City Name',
                      icon: const Icon(Icons.location_city_rounded),
                      borderRadius: BorderRadius.circular(11),
                      contentPadding: const EdgeInsets.only(top: 5, left: 10),
                      validator: CityValidator.validate,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //============Land Mark address=================
                    MyTextFormWedgit(
                      controller: landdMarkController,
                      hintText: "Land Mark address",
                      lableText: 'Land Makr address',
                      icon: const Icon(Icons.home),
                      borderRadius: BorderRadius.circular(11),
                      contentPadding: const EdgeInsets.only(top: 5, left: 10),
                      validator: LandMarkValidator.validate,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //==========Contuct Number================
                    MyTextFormWedgit(
                      controller: contactNumberController,
                      hintText: "Contact Number",
                      lableText: 'Contact Number',
                      icon: const Icon(Icons.phone),
                      borderRadius: BorderRadius.circular(11),
                      contentPadding: const EdgeInsets.only(top: 5, left: 10),
                      validator: ContactNumberValidator.validate,
                    ),

                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
//======================================================================
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
                                controller: singlePersonContrller,
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
                                controller: doublePersonContrller,
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
                                controller: triplePersonContrller,
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
                                controller: fourPersonContrller,
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
                              controller: faimlyPersonContrller,
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
                      controller.onprint();
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
        )),
      ),
    );
  }
}
