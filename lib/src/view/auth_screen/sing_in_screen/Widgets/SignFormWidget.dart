import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';

import '../../../../uitels/Constants/sizes.dart';
import '../../../../uitels/validator/text_field_validator.dart';
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
                    validator: EmailValidator.validate,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintText: "Enter Email id ",
                        prefixIcon: const Icon(Icons.email_outlined),
                        contentPadding: const EdgeInsets.only(top: 5),
                        //=====send the otp text button ==========
                        suffix:

                            /// in there have two condition
                            ///first condition
                            ///if otp is verified than remove a SEND
                            /// otp
                            /// text button and re_send text button
                            /// second condition
                            ///send opt and resend otp button
                            /// first condition
                            Obx(
                          () => (_controller.isVerify.value)
                              ? const Text("")
                              // second condition
                              : (_controller.isSend.value)
                                  ? Obx(
                                      () => (_controller.counter.value != 0)
                                          ? Obx(
                                              () => Padding(
                                                padding: const EdgeInsets.only(right: 22),
                                                child: Text("${_controller.counter.value}"),
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () async {
                                                //====RE-send otp code
                                                _controller.onReSendOtpButton(context);
                                              },
                                              child: Obx(
                                                () => (_controller.otpLoading.value)
                                                    ? const Padding(
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
                                                    : const Text(
                                                        "| RE-SEND   ",
                                                        style: TextStyle(
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                              )),
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        //====send otp code ==========
                                        _controller.onSendOtpButton();
                                      },
                                      child: Obx(
                                        () => (_controller.otpLoading.value)
                                            ? const Padding(
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
                                            : const Text("| "
                                                "SEND OTP   "),
                                      )),
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
                      suffix: Obx(
                        () => (_controller.isOtp.value)
                            ? const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.verified,
                                  color: Colors.green,
                                ),
                              )
                            : InkWell(
                                onTap: () async {
                                  //============verify otp
                                  // controller methods ===========
                                  _controller.onOtpSubmitVerifyButton();
                                },
                                child: const Text(
                                  "| Submit   ",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                      )),
                ),

                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),
                // ===========Enter Password text field =============
                Obx(
                  () => (_controller.isOtp.value)
                      ? TextFormField(
                          controller: _controller.passwordController.value,
                          keyboardType: TextInputType.text,
                          validator: PasswordValidator.validate,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            hintText: "Enter min 6 character of  password",
                            prefixIcon: const Icon(Icons.lock),
                            contentPadding: const EdgeInsets.only(top: 5),
                          ),
                        )
                      : const Text(""),
                ),

                Obx(
                  () => (_controller.isOtp.value)
                      ? const SizedBox(
                          height: AppSizes.spaceBtwItems,
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                ),

                Obx(
                  () => (_controller.isOtp.value)
                      ? //===========enter name text field ================
                      TextFormField(
                          controller: _controller.nameController.value,
                          keyboardType: TextInputType.text,
                          validator: NameValidator.validate,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            hintText: "Enter Name",
                            prefixIcon: const Icon(Icons.person),
                            contentPadding: const EdgeInsets.only(top: 5),
                          ),
                        )
                      : const Text(""),
                ),
                Obx(
                  () => (_controller.isOtp.value)
                      ? const SizedBox(
                          height: AppSizes.spaceBtwItems,
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                ),

                Obx(
                  () => (_controller.isOtp.value)
                      //=============enter city name text field =============
                      ? TextFormField(
                          controller: _controller.cityNameController.value,
                          keyboardType: TextInputType.text,
                          validator: CityValidator.validate,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            hintText: "Enter city name",
                            prefixIcon: const Icon(Icons.location_city),
                            contentPadding: const EdgeInsets.only(top: 5),
                          ),
                        )
                      : const Text(""),
                ),

                Obx(
                  () => (_controller.isOtp.value)
                      ? const SizedBox(
                          height: 15,
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                ),

                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),

                //===========submit button ===============
                Obx(
                  () => SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: Opacity(
                      opacity: _controller.isVerify.value ? 1 : 0.5,
                      child: IgnorePointer(
                        ignoring: (_controller.isVerify.value == false),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (globalKey.currentState!.validate()) {
                               _controller.onSubmitButton();

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
                          "Sign-in",
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                ),

                const SizedBox(
                  height:  AppSizes.spaceBtwItems * 3,
                )
              ],
            )),
      ],
    );
  }
}
