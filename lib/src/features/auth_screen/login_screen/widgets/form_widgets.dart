import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';

import '../../../../res/route_name/routes_name.dart';
import '../../../../utils/Constants/sizes.dart';
import '../../../../utils/validator/text_field_validator.dart';
import '../login_screen_controller/login_controller.dart';

class FormWidgets extends StatelessWidget {
  const FormWidgets({
    super.key,
    required this.globalKey,
    required LoginScreenController controller,
  }) : _controller = controller;

  final GlobalKey<FormState> globalKey;
  final LoginScreenController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: globalKey,
            child: Column(
              children: [
                //===========Email and phone number  text
                // field===============
                TextFormField(
                  controller: _controller.emailControllerLogin.value,
                  validator: EmailValidator.validate,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    hintText: "Enter Email id ",
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: AppColors.primary,
                    ),
                    contentPadding: const EdgeInsets.only(top: 5),
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
                //==========password text field==============
                Obx(
                  () => TextFormField(
                    controller: _controller.passwordControllerLogin.value,
                    obscureText: _controller.passView.value,
                    validator: PasswordValidator.validate,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Enter Password",
                      prefixIcon: const Icon(Icons.lock, color: AppColors.primary),
                      suffixIcon: (_controller.passView.value)
                          ? InkWell(
                              onTap: () {
                                _controller.passView.value = false;
                              },
                              child: const Icon(Icons.visibility_off, color: AppColors.primary))
                          : InkWell(
                              onTap: () {
                                _controller.passView.value = true;
                              },
                              child: const Icon(Icons.visibility, color: AppColors.primary)),
                      contentPadding: const EdgeInsets.only(top: 5),
                    ),
                  ),
                ),
              ],
            )),

        //=======forget password text button=====
        Align(
            heightFactor: 2,
            alignment: Alignment.centerRight,
            child: InkWell(
                onTap: () {
                  Get.toNamed(RoutesName.emailForgetPassScreen);
                },
                child: const Text(
                  "Forget Password ? ",
                  style: TextStyle(color: Colors.blue),
                ))),
        const SizedBox(
          height: AppSizes.spaceBtwSSections,
        ),

        // ===========login button ==============
        SizedBox(
          height: 40,
          width: double.infinity,
          child: Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (globalKey.currentState!.validate()) {
                  _controller.onLoginButton(context);
                }
              },
              child: (_controller.loading.value)
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text("Login"),
            ),
          ),
        ),
        const SizedBox(
          height: AppSizes.spaceBtwSSections,
        ),

        // =======Don't have an account button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account ? "),
            InkWell(
                onTap: () {
                  Get.toNamed(RoutesName.singScreen);
                },
                child: const Text(
                  "Sign-up",
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        ),
      ],
    );
  }
}
