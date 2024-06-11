import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import '../../../utils/validator/text_field_validator.dart';
import 'controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final globalKey = GlobalKey<FormState>();
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build -EditProfileScreen ");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
          child: Column(
            children: [
              Form(
                key: globalKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.updateNameController.value,
                      keyboardType: TextInputType.text,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                      ],
                      validator: NameValidator.validate,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintText: "Enter Name",
                        prefixIcon: const Icon(Icons.person),
                        contentPadding: const EdgeInsets.only(top: 5),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    TextFormField(
                      controller: controller.updateCityController.value,
                      keyboardType: TextInputType.text,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                      ],
                      validator: NameValidator.validate,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintText: "Enter City",
                        prefixIcon: const Icon(Icons.location_city),
                        contentPadding: const EdgeInsets.only(top: 5),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.1,
              ),
              ComReuseElevButton(
                onPressed: () {
                  if (globalKey.currentState!.validate()) {
                    controller.updateProfileData();
                  }
                },
                title: "Update",
                loading: controller.loading.value,
              )
            ],
          ),
        ),
      ),
    );
  }
}
