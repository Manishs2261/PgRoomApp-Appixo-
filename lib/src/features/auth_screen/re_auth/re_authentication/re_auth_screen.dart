import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../data/repository/auth_apis/auth_apis.dart';
import '../../../../res/route_name/routes_name.dart';
import '../../../../utils/Constants/colors.dart';
import '../../../../utils/Constants/image_string.dart';
import '../../../../utils/Constants/sizes.dart';
import '../../../../utils/logger/logger.dart';
import '../../../../utils/validator/text_field_validator.dart';
import 'controller/re_auth_controller.dart';

class ReAuthScreen extends StatelessWidget {
  ReAuthScreen({super.key});

  final globalKey = GlobalKey<FormState>();
  final controller = Get.put(ReAuthScreenController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("re auth screen ");
    return Scaffold(
      appBar: AppBar(
        //=======skip button ========
        backgroundColor: Colors.transparent,
        actions: const [
          // SkipTextButtonWidgets(),
        ],
      ),
      body: GestureDetector(
        // ======on tab off the keyboard screen
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Re-authenticate a user",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const Gap(20),
                  const Text(
                      "To deactivate your account, please verify your identity by re-entering the registered email ID and password."),

                  const Gap(80),
                  Form(
                      key: globalKey,
                      child: Column(
                        children: [
                          //===========Email and phone number  text
                          // field===============
                          TextFormField(
                            controller: controller.emailControllerLogin.value,
                            validator: EmailValidator.validate,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              hintText: "Enter Registered Email id ",
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
                              controller: controller.passwordControllerLogin.value,
                              obscureText: controller.passView.value,
                              validator: PasswordValidator.validate,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Enter Password",
                                prefixIcon: const Icon(Icons.lock, color: AppColors.primary),
                                suffixIcon: (controller.passView.value)
                                    ? InkWell(
                                        onTap: () {
                                          controller.passView.value = false;
                                        },
                                        child: const Icon(Icons.visibility_off, color: AppColors.primary))
                                    : InkWell(
                                        onTap: () {
                                          controller.passView.value = true;
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
                            controller.onReAuthButton(context);
                          }
                        },
                        child: (controller.loading.value)
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Re-Authenticate "),
                      ),
                    ),
                  ),

                  const Gap(30),
                  //=========divider ==================
                  const Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: Colors.grey,
                        thickness: AppSizes.dividerHeight,
                      )),
                      Text("  Or  "),
                      Expanded(
                          child: Divider(
                        color: Colors.grey,
                        thickness: AppSizes.dividerHeight,
                      )),
                    ],
                  ),

                  const Gap(20),

                  const Text("If you are already signed in with Google, please proceed by re-authenticating your "
                      "account with Google."),
                  const Gap(40),
                  //========continue with google ======
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        //google sing code

                        AuthApisClass.reAuthenticateInWithGoogle();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(AppImage.loginGoogleImage),
                            height: 28,
                            width: 30,
                          ),
                          SizedBox(
                            width: AppSizes.spaceBtwItems,
                          ),
                          Text(
                            "Re-Authenticate with Google",
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
