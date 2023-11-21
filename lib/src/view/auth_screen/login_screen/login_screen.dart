
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/uitels/Constants/sizes.dart';
import 'package:pgroom/src/view/auth_screen/login_screen/login_screen_controller/login_controller.dart';
import 'package:pgroom/src/view/auth_screen/login_screen/widgets/footer_widgets.dart';
import 'package:pgroom/src/view/auth_screen/login_screen/widgets/form_widgets.dart';
import 'package:pgroom/src/view/auth_screen/login_screen/widgets/header_widgets.dart';
import 'package:pgroom/src/view/auth_screen/login_screen/widgets/skip_button.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final globleKey = GlobalKey<FormState>();
  final _controller = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("rebUild => login screen 🔴");
    }
    return Scaffold(
      appBar: AppBar(
        //=======skip buttton ========
        actions: const [
          SkipTextButtonWidgets(),
        ],
      ),
      body: GestureDetector(
        // ======on tab off the keybord screen
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

                FormWidgets(globleKey: globleKey, controller: _controller),

                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),

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

                const SizedBox(
                  height: AppSizes.spaceBtwSSections,
                ),
                //========continue with google ======
                const FooterWidgets(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
