import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/com_reuse_elevated_button.dart';
import '../../../../utils/Constants/colors.dart';
import '../../../../utils/logger/logger.dart';
import '../../../../utils/validator/text_field_validator.dart';
import '../../../../utils/widgets/form_headline.dart';
import '../../../../utils/widgets/form_process_step.dart';
import '../../../../utils/widgets/my_text_form_field.dart';
import 'controller.dart';

class FirstFoodForm extends StatelessWidget {
  FirstFoodForm({super.key});

  final controller = Get.put(FirstFoodFormController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - FirstFoodForm......................................");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // Increase the height to accommodate the progress indicator
        title: const FormProcessStep(),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 64),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FormHeadline(title: 'Food Type'),
                Obx(
                  () => Wrap(
                    spacing: 8.0, // Optional: Add space between i
                    runSpacing: 8.0,
                    children: [
                      _buildRadioListTile('Mess', 'Mess'),
                      _buildRadioListTile('Restaurants', 'Restaurants'),
                      _buildRadioListTile('Street Food', 'StreetFood'),
                    ],
                  ),
                ),

                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  controller: controller.nameController,
                  labelText: 'Restaurant/Mess Name',
                  icon: const Icon(Icons.home, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  maxLength: 50,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),

                TextFormField(
                  controller: controller.descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Description (Optional)",
                    prefixIcon: const Icon(
                      Icons.description_outlined,
                      color: AppColors.primary,
                    ),
                    contentPadding: const EdgeInsets.all(12),
                    suffixStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),
                  ),
                ),

                const SizedBox(height: 16),
                //==========House Address================
                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  controller: controller.addressController,
                  labelText: 'Enter Address',
                  icon: const Icon(Icons.home, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  maxLength: 100,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),
                //===========City Name================
                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  controller: controller.landmarkController,
                  labelText: 'Enter landmark',
                  icon: const Icon(Icons.location_on, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  maxLength: 40,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                //============Land Mark address=================
                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  controller: controller.cityController,
                  labelText: 'Enter City',
                  icon: const Icon(Icons.location_city_outlined,
                      color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  maxLength: 100,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),

                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  controller: controller.stateController,
                  labelText: 'Enter State',
                  icon: const Icon(Icons.map, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  maxLength: 100,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
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
                  () => (controller.images.isNotEmpty)
                      ? Container(
                          margin: const EdgeInsets.only(top: 16),
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.images.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                    File(controller.images[index].path)),
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
                  height: 16,
                ),

                const SizedBox(height: 20),
                ReuseElevButton(
                  onPressed: () =>  controller.onSaveAndNext(),
                  title: "Save & Next",
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

  /// Radio List Tile for food type
  Widget _buildRadioListTile(String title, String value) {
    return SizedBox(
      width: 150,
      child: RadioListTile<String>(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        value: value,
        dense: false,
        contentPadding: EdgeInsets.zero,
        visualDensity: const VisualDensity(
          horizontal: -4,
        ),
        groupValue: controller.foodShopType.value,
        onChanged: (value) {
          controller.foodShopType.value = value!;
        },
      ),
    );
  }
}