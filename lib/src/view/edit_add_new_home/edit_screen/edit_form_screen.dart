import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/view/edit_add_new_home/edit_screen/controller/controller.dart';
import 'package:pgroom/src/view/rent_form_screen/add_image_/add_image_screen.dart';
import 'package:pgroom/src/view/rent_form_screen/provide_facilites/provide_facilites_screen.dart';

import '../../../model/user_rent_model/user_rent_model.dart';
import '../../../uitels/image_string/image_string.dart';
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

  final controller = Get.put(EditFormScreenController(Get.arguments['list'] ,Get.arguments["id"]
  ));

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
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40,bottom:
          80),
          child: Column(
            children: [
              Form(
                key: _globlekey,
                child: Column(
                  children: [



                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Please complete the following information exactly as it appears in your rental contract",
                          style: TextStyle(color: Colors.orange),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        const Text(
                          "This Image show in your front page",
                          style: TextStyle(color: Colors.green),
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        //========stack container ============
                        Container(
                          alignment: Alignment.center,
                          height: 200,
                          width: double.infinity,

                          //======== cover image=================
                          child: Stack(
                            children: [
                              // =====for initial image when your don't choose image============

                              Obx(
                              ()=> controller.selectedImagr.value
                                ?Image(
                                  image: NetworkImage(controller.selectedCoverImage
                                      .value.toString()),
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )

                            :  Obx(
                                      () => controller.selectedCoverImage.value
                                          != ""
                                      ? Image(
                                    image: FileImage(File(controller
                                        .selectedCoverImage.value
                                        .toString())),
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                      : const Image(
                                    image: AssetImage(roomImage),
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              // ========for add a image button=========

                              Obx(
                                    () => controller.selectedCoverImage.value
                                        != ""
                                    ? const Text("")
                                    : Positioned(
                                  top: 60,
                                  left: 80,
                                  child: InkWell(
                                    onTap: () {
                                      controller.addimage.value = true;

                                      controller
                                          .pickeCoverImageFromGallery();
                                    },
                                    child: Container(
                                      height: 60,
                                      width: 200,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border:
                                          Border.all(color: Colors.white)),
                                      child: const Text(
                                        "Choose cover Image",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //==========for delete  Cover image a image===========
                              Obx(
                                    () => controller.selectedCoverImage.value
                                        != ""
                                    ? Positioned(
                                    right: 1,
                                    child: InkWell(
                                      onTap: () {
                                        controller.addimage.value = false;
                                        controller.selectedCoverImage.value =
                                        "";
                                        controller.selectedImagr.value = false;
                                      },
                                      child: const CircleAvatar(
                                        radius: 14,
                                        backgroundColor: Colors.black26,
                                        child: Text(
                                          "X",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ))
                                    : const Text(""),
                              )
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        //when a upload image show successful sign

                        Obx(
                              () => controller.addimage.value
                              ? const Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 7)),
                              Text(
                                "Add",
                                style: TextStyle(color: Colors.green),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.verified,
                                color: Colors.green,
                                size: 20,
                              )
                            ],
                          )
                              : const Text(""),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        const Text(
                          " Add a Othe images ",
                          style: TextStyle(color: Colors.green),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        //===========other image container============

                        Obx(
                              () => controller.isBool.value
                              ? Container(
                            padding: const EdgeInsets.all(10),
                            height: 120,
                            width: double.infinity,
                            decoration: const BoxDecoration(),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.imageFileList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.all(2),
                                    padding: const EdgeInsets.all(1),
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        border:
                                        Border.all(color: Colors.black26)),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.file(
                                          controller.imageFileList[index],
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                            top: 1,
                                            right: 1,
                                            child: InkWell(
                                              onTap: () {
                                                controller.imageFileList
                                                    .removeAt(index);

                                                if (controller
                                                    .imageFileList.isEmpty) {
                                                  controller.isBool.value =
                                                  false;
                                                }
                                              },
                                              child: const CircleAvatar(
                                                  radius: 11,
                                                  backgroundColor: Colors.black26,
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 18,
                                                    color: Colors.white,
                                                  )),
                                            ))
                                      ],
                                    ),
                                  );
                                }),
                          )
                              : Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                            ),
                            child: const Icon(
                              Icons.image_outlined,
                              size: 50,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        //=============choose button ===========
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                controller.pickeImageFromGallery();
                                controller.isBool.value = true;
                              },
                              child: const Text("Chosse image")),
                        ),



                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),


                    // =================Home Name================
                    MyTextFormWedgit(
                      textKeyBoard: TextInputType.text,
                      controller: controller.houseNameController.value,
                      hintText: "Enter Home / House Name",
                      lableText: 'House Name',
                      icon: const Icon(Icons.home),
                      borderRadius: BorderRadius.circular(11),
                      contentPadding: const EdgeInsets.only(top: 5, left: 10),
                      validator: EmailValidator.validate,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    //==========House Address================
                    MyTextFormWedgit(
                      textKeyBoard: TextInputType.text,
                      controller: controller.houseAddressController.value,
                      hintText: "House Address",
                      lableText: 'House addsress',
                      icon: const Icon(Icons.location_city_outlined),
                      borderRadius: BorderRadius.circular(11),
                      contentPadding: const EdgeInsets.only(top: 5, left: 10),
                      validator: AddressValidator.validate,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //===========City Name================
                    MyTextFormWedgit(
                      textKeyBoard: TextInputType.text,
                      controller: controller.cityNameController.value,
                      hintText: "City Name",
                      lableText: 'City Name',
                      icon: const Icon(Icons.location_city_rounded),
                      borderRadius: BorderRadius.circular(11),
                      contentPadding: const EdgeInsets.only(top: 5, left: 10),
                      validator: CityValidator.validate,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //============Land Mark address=================
                    MyTextFormWedgit(
                      textKeyBoard: TextInputType.text,
                      controller: controller.landdMarkController.value,
                      hintText: "Land Mark address",
                      lableText: 'Land Makr address',
                      icon: const Icon(Icons.home),
                      borderRadius: BorderRadius.circular(11),
                      contentPadding: const EdgeInsets.only(top: 5, left: 10),
                      validator: LandMarkValidator.validate,
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    //==========Contuct Number================
                    MyTextFormWedgit(
                      maxLength: 10,
                      textKeyBoard: TextInputType.phone,
                      controller: controller.contactNumberController.value,
                      hintText: "Contact Number",
                      lableText: 'Contact Number',
                      icon: const Icon(Icons.phone),
                      borderRadius: BorderRadius.circular(11),
                      contentPadding: const EdgeInsets.only(top: 5, left: 10),
                      validator: ContactNumberValidator.validate,
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
//======================================================================
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

              //==============================}

              const SizedBox(
                height: 10,
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
                              textKeyBoard: TextInputType.number,
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

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Provide a Facilities :- ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  //======for Wi-fi==========
                  Obx(
                    () => MYCheckBoxWidget(
                        title: "Wi-Fi",
                        checkBool: controller.wifi.value,
                        onChanged: (value) {
                          controller.wifi.value = value!;
                        }),
                  ),
                  //======for Bed==========
                  Obx(
                    () => MYCheckBoxWidget(
                        title: "Bed",
                        checkBool: controller.bed.value,
                        onChanged: (value) {
                          controller.bed.value = value!;
                        }),
                  ),

                  //======for chairs==========
                  Obx(
                    () => MYCheckBoxWidget(
                        title: "Chair",
                        checkBool: controller.chari.value,
                        onChanged: (value) {
                          controller.chari.value = value!;
                        }),
                  ),

                  //======for Table ==========
                  Obx(
                    () => MYCheckBoxWidget(
                        title: "Table",
                        checkBool: controller.table.value,
                        onChanged: (value) {
                          controller.table.value = value!;
                        }),
                  ),
                  //======for Fan==========
                  Obx(
                    () => MYCheckBoxWidget(
                        title: "Fan",
                        checkBool: controller.fan.value,
                        onChanged: (value) {
                          controller.fan.value = value!;
                        }),
                  ),
                  //======for Gadda==========
                  Obx(
                    () => MYCheckBoxWidget(
                        title: "Gadda",
                        checkBool: controller.gadda.value,
                        onChanged: (value) {
                          controller.gadda.value = value!;
                        }),
                  ),
                  //======for Light==========
                  Obx(
                    () => MYCheckBoxWidget(
                        title: "Light",
                        checkBool: controller.light.value,
                        onChanged: (value) {
                          controller.light.value = value!;
                        }),
                  ),
                  //======for Locker==========
                  Obx(
                    () => MYCheckBoxWidget(
                        title: "Locker",
                        checkBool: controller.locker.value,
                        onChanged: (value) {
                          controller.locker.value = value!;
                        }),
                  ),
                  //======for Bedsheet==========
                  Obx(
                    () => MYCheckBoxWidget(
                        title: "Bed Sheet",
                        checkBool: controller.bedSheet.value,
                        onChanged: (value) {
                          controller.bedSheet.value = value!;
                        }),
                  ),
                  //======for washing machine==========
                  Obx(
                    () => MYCheckBoxWidget(
                        title: "Washing Machine",
                        checkBool: controller.washingMachin.value,
                        onChanged: (value) {
                          controller.washingMachin.value = value!;
                        }),
                  ),
                  //======for parking==========
                  Obx(
                    () => MYCheckBoxWidget(
                        title: "Parking",
                        checkBool: controller.parking.value,
                        onChanged: (value) {
                          controller.parking.value = value!;
                        }),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Column(
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

                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),

              Column(
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
                                            controller
                                                .vegAndNonVegCondition(value);
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
                          // saveController.uploadData();

                          controller.onSubmitButton();


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
            ],
          ),
        )),
      ),
    );
  }
}
