import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/features/auth_screen/sing_profile_screen/controller/controller.dart';
import 'package:pinput/pinput.dart';

import '../../../utils/Constants/colors.dart';
import '../../../utils/validator/text_field_validator.dart';

class SignProfileScreen extends StatelessWidget {
  SignProfileScreen({super.key});

  final globalKey = GlobalKey<FormState>();
  final controller = Get.put(SignProfileScreenControllter());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80, left: 15, right: 15, bottom: 30),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 200,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Obx(
                        () => (controller.image.value.isNotEmpty)
                            ? Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    width: 180.0,
                                    height: 180.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.fill, image: FileImage(File(controller.image.value))))),
                              )
                            : const Align(
                                alignment: Alignment.topCenter,
                                child: CircleAvatar(
                                  radius: 85,
                                  backgroundColor: AppColors.primary,
                                  child: Icon(
                                    Icons.person,
                                    size: 70,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 38, right: 24),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return ListView(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(bottom: Get.width * 0.1),
                                    children: [
                                      //pick profile picture label
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              InkWell(
                                                child: const CircleAvatar(
                                                  radius: 40,
                                                  child: Icon(
                                                    Icons.image,
                                                    size: 40,
                                                  ),
                                                ),
                                                onTap: () {
                                                  controller.getImageFromImagePicker(ImageSource.gallery);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              const Gap(10),
                                              const Text(
                                                "Gallery",
                                                style: TextStyle(fontSize: 16),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              InkWell(
                                                child: const CircleAvatar(
                                                  radius: 40,
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    size: 40,
                                                  ),
                                                ),
                                                onTap: () {
                                                  controller.getImageFromImagePicker(ImageSource.camera);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              const Gap(10),
                                              const Text(
                                                "Camera",
                                                style: TextStyle(fontSize: 16),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: AppColors.white, width: 2)),
                              child: const Icon(
                                Icons.camera_alt,
                                color: AppColors.white,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Form(
                  key: globalKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      TextFormField(
                        controller: controller.nameController.value,
                        keyboardType: TextInputType.text,
                        validator: NameValidator.validate,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText: "Enter Name",
                          prefixIcon: const Icon(
                            Icons.person,
                            color: AppColors.primary,
                          ),
                          contentPadding: const EdgeInsets.only(top: 5),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: controller.cityNameController.value,
                        keyboardType: TextInputType.text,
                        validator: CityValidator.validate,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText: "Enter city name",
                          prefixIcon: const Icon(
                            Icons.location_city,
                            color: AppColors.primary,
                          ),
                          contentPadding: const EdgeInsets.only(top: 5),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: controller.passwordController.value,
                        keyboardType: TextInputType.text,
                        validator: (value) => PasswordValidator.validate(value),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText: "Enter at least 6 characters for the password.",
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColors.primary,
                          ),
                          contentPadding: const EdgeInsets.only(top: 5),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: Get.height * 0.1,
              ),
              ComReuseElevButton(
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      controller.onSubmitButton();
                    }
                  },
                  title: "Submit"),
            ],
          ),
        ),
      ),
    );
  }
}
