import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/splash/controller/splash_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../res/route_name/routes_name.dart';
import '../../../../utils/Constants/sizes.dart';

class SkipTextButtonWidgets extends StatelessWidget {
  const SkipTextButtonWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.defaultSpace),
      child: InkWell(
          onTap: () async {
            SharedPreferences preference = await SharedPreferences.getInstance();
            preference.setString("userUid", "value");
            finalUserUidGlobal = "value";

            Get.offAllNamed(RoutesName.homeScreen);
          },
          child: const Text(
            "Skip",
            style: TextStyle(fontSize: AppSizes.fontSizeLd),
          )),
    );
  }
}
