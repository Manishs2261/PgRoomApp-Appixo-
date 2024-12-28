import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';

import '../../../../common/widgets/com_reuse_elevated_button.dart';
import '../../../../utils/logger/logger.dart';
import '../../../../utils/validator/text_field_validator.dart';
import '../../../../utils/widgets/form_headline.dart';
import '../../../../utils/widgets/form_process_step.dart';
import '../../../../utils/widgets/my_text_form_field.dart';
import 'controller.dart';

class FirstRoomFormScreen extends StatelessWidget {
  final controller = Get.put(FirstRoomFormController());
  final List<String> bhkOptions = [
    '1 BHK',
    '2 BHK',
    '3 BHK',
    '4 BHK',
    '4+ BHK'
  ];

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - FirstRoomFormScreen......................................");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const FormProcessStep(),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 8, bottom: 64),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Room ownership type
                const FormHeadline(
                  title: 'Room Ownership Type',
                ),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text(
                            'Owner',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                          value: 'Owner',
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          visualDensity: const VisualDensity(horizontal: -4),
                          groupValue: controller.roomOwnerType.value,
                          onChanged: (value) {
                            controller.roomOwnerType.value = value!;
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text(
                            'Broker',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                          value: 'Broker',
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          visualDensity: const VisualDensity(horizontal: -4),
                          groupValue: controller.roomOwnerType.value,
                          onChanged: (value) {
                            controller.roomOwnerType.value = value!;
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text(
                            'Room Mete',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                          value: 'RoomMate',
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          visualDensity: const VisualDensity(horizontal: -4),
                          groupValue: controller.roomOwnerType.value,
                          onChanged: (value) {
                            controller.roomOwnerType.value = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                // 3. Room Name
                MyTextFormWidget(
                  controller: controller.roomNameController,
                  labelText: 'House Name',
                  icon: const Icon(
                    Icons.home,
                    color: AppColors.primary,
                  ),
                  borderRadius: BorderRadius.circular(4),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: NameValidator.validate,
                  textKeyBoard: TextInputType.text,
                  maxLength: 40,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                  ],
                ),

                // 4. Room type - Shareable or Private

                const SizedBox(
                  height: 16,
                ),
                // 5. Room category - PG, Co-living, Flat
                const FormHeadline(title: "Room Category"),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          visualDensity: const VisualDensity(horizontal: -4),
                          title: const Text('PG',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14)),
                          value: 'PG',
                          groupValue: controller.roomCategory.value,
                          onChanged: (value) {
                            controller.roomCategory.value = value!;
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          visualDensity: const VisualDensity(horizontal: -4),
                          title: const Text('Co-living',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14)),
                          value: 'Co-living',
                          groupValue: controller.roomCategory.value,
                          onChanged: (value) {
                            controller.roomCategory.value = value!;
                          },
                        ),
                      ),
                      Visibility(
                        visible: controller.roomType.value != "Shareable",
                        child: Expanded(
                          child: RadioListTile<String>(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            visualDensity: const VisualDensity(horizontal: -4),
                            title: const Text('Flat',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14)),
                            value: 'Flat',
                            groupValue: controller.roomCategory.value,
                            onChanged: (value) {
                              controller.roomCategory.value = value!;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 6. Gender types
                const SizedBox(
                  height: 16,
                ),

                Obx(
                  () => Visibility(
                      visible: controller.roomCategory.value == "PG",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FormHeadline(title: "Gender Types"),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  visualDensity:
                                      const VisualDensity(horizontal: -4),
                                  title: const Text('Boys',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14)),
                                  value: 'Boys',
                                  groupValue: controller.genderType.value,
                                  onChanged: (value) {
                                    controller.genderType.value = value!;
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  visualDensity:
                                      const VisualDensity(horizontal: -4),
                                  title: const Text('Girls',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14)),
                                  value: 'Girls',
                                  groupValue: controller.genderType.value,
                                  onChanged: (value) {
                                    controller.genderType.value = value!;
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  visualDensity:
                                      const VisualDensity(horizontal: -4),
                                  title: const Text('Both',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14)),
                                  value: 'Both',
                                  groupValue: controller.genderType.value,
                                  onChanged: (value) {
                                    controller.genderType.value = value!;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
                Obx(
                  () => Visibility(
                      visible: controller.roomCategory.value == "Flat",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FormHeadline(title: "BHK Types"),
                          Wrap(
                            children: List.generate(
                              bhkOptions.length,
                              (index) => RadioListTile<String>(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                visualDensity:
                                    const VisualDensity(horizontal: -4),
                                title: Text(
                                  bhkOptions[index],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                value: bhkOptions[index],
                                groupValue: controller.flatType.value,
                                onChanged: (value) {
                                  controller.flatType.value = value!;
                                },
                              ),
                            ),
                          ),
                        ],
                      )),
                ),

                const SizedBox(
                  height: 40,
                ),
                Obx(
                  () => Visibility(
                    visible: controller.roomCategory.value != "Flat",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FormHeadline(title: "Room Type"),
                        Obx(
                          () => Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  visualDensity:
                                      const VisualDensity(horizontal: -4),
                                  title: const Text(
                                    'Private',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  value: 'Private',
                                  groupValue: controller.roomType.value,
                                  onChanged: (value) {
                                    controller.roomType.value = value!;
                                  },
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  contentPadding: EdgeInsets.zero,
                                  visualDensity:
                                      const VisualDensity(horizontal: -4),
                                  dense: true,
                                  title: const Text('Shareable',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14)),
                                  value: 'Shareable',
                                  groupValue: controller.roomType.value,
                                  onChanged: (value) {
                                    controller.roomType.value = value!;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Obx(
                          () => controller.roomType.value == 'Shareable'
                              ? Column(
                                  children: [
                                    MyTextFormWidget(
                                      textKeyBoard: TextInputType.number,
                                      controller:
                                          controller.singleRoomPriceController,
                                      labelText: "Single Person Rent",

                                      ///  isCollapsed: true,
                                      maxLength: 6,
                                      validator: CommonUseValidator.validate,
                                      icon: const Icon(
                                        Icons.currency_rupee,
                                        size: 20,
                                        color: AppColors.primary,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                      //contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9.]")),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    MyTextFormWidget(
                                      textKeyBoard: TextInputType.number,
                                      controller:
                                          controller.doubleRoomPriceController,
                                      validator: CommonUseValidator.validate,
                                      labelText: "Double Person Rent",

                                      ///  isCollapsed: true,
                                      maxLength: 6,
                                      icon: const Icon(
                                        Icons.currency_rupee,
                                        size: 20,
                                        color: AppColors.primary,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                      //contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9.]")),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    MyTextFormWidget(
                                      textKeyBoard: TextInputType.number,
                                      controller:
                                          controller.tripleRoomPriceController,
                                      icon: const Icon(
                                        Icons.currency_rupee,
                                        size: 20,
                                        color: AppColors.primary,
                                      ),
                                      labelText: "Triple  Person Rent",

                                      ///  isCollapsed: true,
                                      maxLength: 6,

                                      borderRadius: BorderRadius.circular(4),
                                      //contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9.]")),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    MyTextFormWidget(
                                      textKeyBoard: TextInputType.number,
                                      controller: controller
                                          .threePlusRoomPriceController,

                                      labelText: "+ Triple Person Rent",

                                      ///  isCollapsed: true,
                                      maxLength: 6,
                                      icon: const Icon(
                                        Icons.currency_rupee,
                                        size: 20,
                                        color: AppColors.primary,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                      //contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9.]")),
                                      ],
                                    ),
                                  ],
                                )
                              : MyTextFormWidget(
                                  textKeyBoard: TextInputType.number,
                                  controller:
                                      controller.singleRoomPriceController,
                                  icon: const Icon(
                                    Icons.currency_rupee,
                                    size: 20,
                                    color: AppColors.primary,
                                  ),
                                  labelText: "Room Rent",
                                  validator: CommonUseValidator.validate,

                                  ///  isCollapsed: true,
                                  maxLength: 6,

                                  borderRadius: BorderRadius.circular(4),
                                  //contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9.]")),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.roomCategory.value == 'Flat',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FormHeadline(title: "BHK Cost"),
                        MyTextFormWidget(
                          textKeyBoard: TextInputType.number,
                          controller: controller.bhkCostController,
                          labelText: "BHK Cost",

                          ///  isCollapsed: true,
                          maxLength: 12,
                          validator: CommonUseValidator.validate,
                          icon: const Icon(
                            Icons.currency_rupee,
                            size: 20,
                            color: AppColors.primary,
                          ),
                          borderRadius: BorderRadius.circular(4),
                          //contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                // 2. Select images
                InkWell(
                  onTap: controller.pickImages,
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.image,
                          color: AppColors.primary,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Choose Images",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => (controller.imageFiles.isNotEmpty)
                      ? Container(
                          margin: const EdgeInsets.only(top: 16),
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.imageFiles!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                    File(controller.imageFiles![index].path)),
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: Icon(
                          Icons.image_outlined,
                          size: 80,
                          color: Colors.grey,
                        )),
                ),
                const SizedBox(
                  height: 32,
                ),

                ReuseElevButton(
                  onPressed: () => controller.onSaveAndNext(),
                  title: 'Save & Next',
                ),
                const SizedBox(height: 20),
                ReuseElevButton(
                  color: Colors.orange,
                  onPressed: () => Get.back(),
                  title: "Back",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
