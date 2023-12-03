import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/features/auth_screen/sing_profile_screen/controller/controller.dart';

import '../../../data/repository/apis/apis.dart';
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
          padding: const EdgeInsets.only(top: 80, left: 15, right: 15,bottom: 30),
          child: Column(
            children: [
              Stack(
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
                        : Align(
                            alignment: Alignment.topCenter,
                            child: CircleAvatar(
                              child: Icon(
                                Icons.person,
                                size: 70,
                              ),
                              radius: 85,
                            ),
                          ),
                  ),
                  Positioned(
                      bottom: 7,
                      right: 115,
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
                                        InkWell(
                                          child: CircleAvatar(
                                            child: Icon(
                                              Icons.image,
                                              size: 40,
                                            ),
                                            radius: 40,
                                          ),
                                          onTap: () {
                                            controller.getImageFromImagePicker(ImageSource.gallery);
                                            Navigator.pop(context);
                                          },
                                        ),
                                        InkWell(
                                          child: CircleAvatar(
                                            child: Icon(
                                              Icons.camera_alt,
                                              size: 40,
                                            ),
                                            radius: 40,
                                          ),
                                          onTap: () {
                                            controller.getImageFromImagePicker(ImageSource.camera);
                                            Navigator.pop(context);
                                          },
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
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: AppColors.primary, width: 2)),
                            child: Icon(
                              Icons.camera_alt,
                              color: AppColors.primary,
                            )),
                      )),
                ],
              ),
              Form(
                  key: globalKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      TextFormField(
                        controller: controller.nameController.value,
                        keyboardType: TextInputType.text,
                        validator: NameValidator.validate,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText: "Enter Name",
                          prefixIcon: const Icon(Icons.person),
                          contentPadding: const EdgeInsets.only(top: 5),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: controller.cityNameController.value,
                        keyboardType: TextInputType.text,
                        validator: CityValidator.validate,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText: "Enter city name",
                          prefixIcon: const Icon(Icons.location_city),
                          contentPadding: const EdgeInsets.only(top: 5),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: controller.passwordController.value,
                        keyboardType: TextInputType.text,
                        validator: PasswordValidator.validate,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText: "Enter min 6 character of  password",
                          prefixIcon: const Icon(Icons.lock),
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
