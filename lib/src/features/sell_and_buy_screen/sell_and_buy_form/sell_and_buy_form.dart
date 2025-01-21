import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/widgets/com_reuse_elevated_button.dart';
import '../../../utils/Constants/colors.dart';
import '../../../utils/logger/logger.dart';
import '../../../utils/validator/text_field_validator.dart';
import '../../../utils/widgets/my_text_form_field.dart';
import 'controller/controller.dart';

class SellAndBuyForm extends StatelessWidget {
  SellAndBuyForm({super.key});

  final controller = Get.put(SellAndBuyController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - SellAndBuyForm ......................................");
    return Scaffold(
      appBar: AppBar(
        // Increase the height to accommodate the progress indicator
        title: Text(
          'Sell and Buy from',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 64, top: 13),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  controller: controller.nameController,
                  labelText: 'Name of Item',
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
                MyTextFormWidget(
                  textKeyBoard: TextInputType.number,
                  controller: controller.priceController,
                  labelText: 'price',
                  icon: const Icon(Icons.currency_rupee, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  maxLength: 50,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),

                TextFormField(
                  controller: controller.descriptionController,
                  minLines: 1,
                  maxLines: 10,
                  maxLength: 500,
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
                  height: 40,
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
                            itemCount: controller.imageFiles.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                    File(controller.imageFiles[index].path)),
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
                  onPressed: () => controller.onSaveAndNext(),
                  title: "Save & Next",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
