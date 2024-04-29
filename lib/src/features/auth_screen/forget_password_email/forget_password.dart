import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/features/auth_screen/forget_password_email/controller/controller.dart';
import 'package:pgroom/src/utils/app_validators/app_validators.dart';

import '../../../utils/Constants/image_string.dart';

class ForgetPasswordEmailScreen extends StatelessWidget {
  ForgetPasswordEmailScreen({super.key});

  final controller = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
                width: 220,
                child: Image(
                  image: AssetImage(
                    AppImage.loginImage,
                  ),
                ),
              ),
              const Gap(30),
              const Text(
                "Forget Password",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400, letterSpacing: 1),
              ),
              const Gap(10),
              const Text(
                "Type in your register e-mail below to receive a reset "
                "password Email.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 80,
              ),
              Form(
                key: controller.globalKey.value,
                child: TextFormField(
                  controller: controller.emailControlerLogin.value,
                  keyboardType: TextInputType.text,
                  validator: (value) => AppValidator.validateEmail(value),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    hintText: "Enter Register Email id",
                    prefixIcon: const Icon(Icons.email_outlined),
                    contentPadding: const EdgeInsets.only(top: 5),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ComReuseElevButton(onPressed: () => controller.sendEmailForgetPassword(), title: "Submit")
            ],
          ),
        ));
  }
}
