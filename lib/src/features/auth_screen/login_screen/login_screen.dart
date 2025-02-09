import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/user_collection.dart';
import 'package:pgroom/src/features/auth_screen/login_screen/widgets/footer_widgets.dart';
import 'package:pgroom/src/features/auth_screen/login_screen/widgets/form_widgets.dart';
import 'package:pgroom/src/features/auth_screen/login_screen/widgets/header_widgets.dart';
import 'package:pgroom/src/utils/Constants/sizes.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login_screen_controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final globalKey = GlobalKey<FormState>();

  final _controller = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    UserApis.getUserData();


    final Uri urlTermsAndCondition = Uri.parse('https://docs.google'
        '.com/document/d/1saDug8Y6GXYsvlXzFkPlSvBPZ6RTX-iZAPZ5wyYPvEo/edit?usp=sharing');

    final Uri urlPrivacyPolicy = Uri.parse(
        'https://docs.google.com/document/d/1NUfUoQwe4rkntC8cg-w0yjlg-Lk39cLMF6KZaCMTLok/edit?usp=sharing');

    Future<void> launchUrlTermsAndCondition() async {
      if (!await launchUrl(urlTermsAndCondition)) {
        throw Exception('Could not launch $urlTermsAndCondition');
      }
    }

    Future<void> launchUrlPrivacyPolicy() async {
      if (!await launchUrl(urlPrivacyPolicy)) {
        throw Exception('Could not launch $urlPrivacyPolicy');
      }
    }

    AppLoggerHelper.debug("Login screen ");
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HederWidgets(),

                const SizedBox(
                  height: AppSizes.spaceBtwSSections,
                ),

                const Gap(30),
                FormWidgets(globalKey: globalKey, controller: _controller),

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

                const Gap(40),
                //========continue with google ======
                const FooterWidgets(),

                const SizedBox(
                  height: AppSizes.spaceBtwSSections,
                ),

                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                            text: 'By Login, you agree to our',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: ' Terms ',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launchUrlTermsAndCondition()),
                        const TextSpan(
                            text: ' and ',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: ' Privacy Policy ',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launchUrlPrivacyPolicy()),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
