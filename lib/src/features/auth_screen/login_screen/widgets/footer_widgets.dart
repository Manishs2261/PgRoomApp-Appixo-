import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../data/repository/auth_apis/auth_apis.dart';
import '../../../../utils/Constants/image_string.dart';
import '../../../../utils/Constants/sizes.dart';
import '../../sing_in_screen/sing_screen_controller/sing_screen_controller.dart';

class FooterWidgets extends StatelessWidget {
  const FooterWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          //google sing code

          AuthApisClass.handleGoogleButtonClick(context);
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
              "Continue with Google",
            )
          ],
        ),
      ),
    );
  }
}
