import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/widgets/com_reuse_elevated_button.dart';
import '../../../../res/route_name/routes_name.dart';
import '../../../../utils/Constants/colors.dart';
import '../../../../utils/logger/logger.dart';
import '../../../../utils/validator/text_field_validator.dart';
import '../../../../utils/widgets/form_headline.dart';
import '../../../../utils/widgets/form_process_step.dart';
import '../../../../utils/widgets/my_text_form_field.dart';

class FirstFoodForm extends StatelessWidget {
  FirstFoodForm({super.key});

  final _formKey = GlobalKey<FormState>();

  // food type
  RxString roomOwnerType = 'Mess'.obs;

  // Multiple image picker
  final RxList<XFile> images = <XFile>[].obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();

    if (selectedImages != null) {
      if (selectedImages.length > 10) {
        // Show a message or alert if more than 10 images are selected
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(content: Text('You can only select up to 10 images!')));

        // Limit the list to 10 images
        images.value = selectedImages.sublist(0, 10);
      } else {
        images.value = selectedImages;
      }
    }
  }

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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FormHeadline( title: 'Food Type'),
                Obx(
                  ()=> Wrap(
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
                  //   controller: controller.houseAddressController.value,

                  labelText: 'Restaurant/Mess Name',
                  icon: const Icon(Icons.home, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator:  CommonUseValidator.validate,
                  maxLength: 100,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),

                TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Description (Optional)",

                    prefixIcon: const Icon(
                      Icons.description_outlined,
                      color: AppColors.primary,
                    ),
                    contentPadding: const EdgeInsets.only(top: 5),
                    suffixStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),
                  ),
                ),

                SizedBox(height: 16),
                //==========House Address================
                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  //   controller: controller.houseAddressController.value,

                  labelText: 'Enter Address',
                  icon: const Icon(Icons.home, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator .validate,
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
                  //   controller: controller.cityNameController.value,

                  labelText: 'Enter landmark',
                  icon: const Icon(Icons.location_on, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  maxLength: 40,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                //============Land Mark address=================
                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  //    controller: controller.landMarkController.value,
                  labelText: 'Enter City',
                  icon: const Icon(Icons.location_city_outlined,
                      color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: LandMarkValidator.validate,
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
                  //    controller: controller.landMarkController.value,
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


                SizedBox(
                  height: 16,
                ),
                // 2. Select images
                InkWell(
                  onTap: _pickImages,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
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
                (images != null && images!.isNotEmpty)
                    ? Container(
                  margin: EdgeInsets.only(top: 16),
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(File(images![index].path)),
                      );
                    },
                  ),
                )
                    : Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 80,
                      color: Colors.grey,
                    )),


                const SizedBox(
                  height: 16,
                ),

                SizedBox(height: 20),
                ReuseElevButton(
                  onPressed: () => Get.toNamed(RoutesName.secondFoodFormScreen),
                  title: "Save & Next",
                ),

                SizedBox(height: 20),
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
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        value: value,
        dense: false,
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity(
          horizontal: -4,
        ),
        groupValue: roomOwnerType.value,
        onChanged: (value) {
          roomOwnerType.value = value!;

        },
      ),
    );
  }
}
