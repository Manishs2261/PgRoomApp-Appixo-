import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/app_validators/app_validators.dart';
import '../../../../utils/Constants/sizes.dart';
import '../../../../utils/validator/text_field_validator.dart';
import '../sing_screen_controller/sing_screen_controller.dart';

class SignFormWidget extends StatelessWidget {
  const SignFormWidget({
    super.key,
    required this.globalKey,
    required SingScreenController controller,
  }) : _controller = controller;

  final GlobalKey<FormState> globalKey;

  final SingScreenController _controller;

  @override
  Widget build(BuildContext context) {
    final globalKeyEmail = GlobalKey<FormState>();
    return Column(
      children: [
        Form(
            key: globalKey,
            child: Column(
              children: [
                //=========enter email text field =============
                Form(
                  key: globalKeyEmail,
                  child: Obx(
                    () => TextFormField(
                      controller: _controller.emailController.value,
                      keyboardType: TextInputType.emailAddress,
                      readOnly: _controller.emailReading.value,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@.+]")),],
                      validator: (value) => AppValidator.validateEmail(value),
                      decoration: InputDecoration(
                          filled: _controller.emailReading.value,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText: "Enter Email id ",
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: AppColors.primary,
                          ),
                          contentPadding: const EdgeInsets.only(top: 5),
                          suffixStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.blue)),
                    ),
                  ),
                ),

                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),
                //========enter otp text field =============
                TextFormField(
                  controller: _controller.passController.value,
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
                ),

                const SizedBox(
                  height: 50,
                ),

                //===========submit button ===============
                Obx(
                  () => SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (globalKey.currentState!.validate()) {
                          //_controller.onSubmitButton();

                          _controller.onOtpSubmitVerifyButton();
                        }
                      },
                      child: (_controller.loading.value)
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text("Submit"),
                    ),
                  ),
                ),

                const SizedBox(
                  height: AppSizes.spaceBtwSSections,
                ),

                // =======Don't have an account button=========
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account ? "),
                    InkWell(
                        onTap: () async {
                          _controller.emailController.value.clear();
                          _controller.passController.value.clear();

                          if (_controller.emailReading.value) {
                            _controller.timer.cancel();
                          }
                          _controller.emailReading.value = false;

                          _controller.isSend.value = false;

                          Get.toNamed(RoutesName.loginScreen);
                        },
                        child: const Text(
                          " Log-in",
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
