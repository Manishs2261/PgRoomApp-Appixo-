import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/auth_screen/sing_in_screen/sing_screen_controller/sing_screen_controller.dart';
import 'package:pgroom/src/utils/Constants/sizes.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import '../login_screen/widgets/footer_widgets.dart';
import 'Widgets/HeaderWidgets.dart';
import 'Widgets/SignFormWidget.dart';

class SingInScreen extends StatelessWidget {
  SingInScreen({super.key});

  final _controller = Get.put(SingScreenController());
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Uri urlTermsAndCondition = Uri.parse('https://docs.google'
        '.com/document/d/1saDug8Y6GXYsvlXzFkPlSvBPZ6RTX-iZAPZ5wyYPvEo/edit?usp=sharing');

    final Uri urlPrivacyPolicy =
        Uri.parse('https://docs.google.com/document/d/1NUfUoQwe4rkntC8cg-w0yjlg-Lk39cLMF6KZaCMTLok/edit?usp=sharing');

    Future<void> _launchUrlTermsAndCondition() async {
      if (!await launchUrl(urlTermsAndCondition)) {
        throw Exception('Could not launch $urlTermsAndCondition');
      }
    }

    Future<void> _launchUrlPrivacyPolicy() async {
      if (!await launchUrl(urlPrivacyPolicy)) {
        throw Exception('Could not launch $urlPrivacyPolicy');
      }
    }

    AppLoggerHelper.debug("rebuild => sing screen ");

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          _controller.emailController.value.clear();
          _controller.otpController.value.clear();
          if (_controller.emailReading.value) {
            _controller.timer.cancel();
          }
          _controller.emailReading.value = false;
          _controller.isSend.value = false;
        },
        child: GestureDetector(
          // ======on tab off the keyboard screen
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderWidgets(),
                  const Gap(40),
                  SignFormWidget(globalKey: globalKey, controller: _controller),

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
                          const TextSpan(text: 'By SignUp, you agree to our', style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: ' Terms ',
                              style: const TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()..onTap = () => _launchUrlTermsAndCondition()),
                          const TextSpan(text: ' and ', style: TextStyle(color: Colors.black)),
                          TextSpan(
                              text: ' Privacy Policy ',
                              style: const TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()..onTap = () => _launchUrlPrivacyPolicy()),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
