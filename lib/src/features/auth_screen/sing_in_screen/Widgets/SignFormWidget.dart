import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';

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
    return Column(
      children: [
        Form(
            key: globalKey,
            child: Column(
              children: [
                //=========enter email text field =============
                Obx(
                  () => TextFormField(
                    controller: _controller.emailController.value,
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    readOnly: _controller.emailReading.value,
                    validator: EmailValidator.validate,
                    decoration: InputDecoration(
                        filled: _controller.emailReading.value,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintText: "Enter Email id ",
                        prefixIcon: const Icon(Icons.email_outlined),
                        contentPadding: const EdgeInsets.only(top: 5),

                        //=====send the otp text button ==========
                        suffix: Obx(
                          () => (_controller.isSend.value)
                              ? const Text("")
                              : (_controller.otpSendLoading.value)
                                  ? Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.blue,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        //====send otp code ==========
                                        _controller.onSendOtpButton();
                                      },
                                      child: Text("| "
                                          "SEND OTP   "),
                                    ),
                        ),
                        suffixStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.blue)),
                  ),
                ),

                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),
                //========enter otp text field =============
                TextFormField(
                  controller: _controller.otpController.value,
                  keyboardType: TextInputType.number,
                  validator: OtpValidator.validate,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    hintText: "Enter OTP",
                    prefixIcon: const Icon(Icons.password),
                    contentPadding: const EdgeInsets.only(top: 5),
                  ),
                ),
                // ===========Enter Password text field =============

                SizedBox(
                  height: 14,
                ),
                Obx(
                  () => (_controller.isSend.value)
                      ? Obx(
                          () => (_controller.counter.value != 0)
                              ? Obx(
                                  () => Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Time out :- ",
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                      Text(
                                        "${_controller.counter.value}",
                                        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              : (_controller.otpReSendLoading.value)
                                  ? Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.blue,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        //====RE-send otp code
                                        _controller.onReSendOtpButton(context);
                                      },
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "| RE-SEND   ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                        )
                      : Text(""),
                ),

                SizedBox(
                  height: 80,
                ),

                //===========submit button ===============
                Obx(
                  () => SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (globalKey.currentState!.validate()) {
                          // _controller.onSubmitButton();

                          _controller.onOtpSubmitVerifyButton();
                        }
                      },
                      child: (_controller.loading.value)
                          ? const CircularProgressIndicator(
                              color: Colors.blue,
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
                          Get.toNamed(RoutesName.loginScreen);
                        },
                        child: const Text(
                          " Login-in",
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
