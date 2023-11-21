import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/route_name/routes_name.dart';
import '../../../uitels/Constants/colors.dart';
import '../../../uitels/Constants/sizes.dart';
import '../../../uitels/device/device_utility.dart';
import '../../../uitels/helpers/heiper_function.dart';

class StartButtonWidget extends StatelessWidget {
  const StartButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: AppSizes.defaultSpace,
      right: AppDeviceUtils.getBottomNavigationBarHeight(),
      child: InkWell(
        onTap: () {
          Get.offNamed(RoutesName.loginScreen);
        },
        child: Container(
            alignment: Alignment.center,
            width: AppHelperFunction.screenWidth() * 0.6,
            height: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.primary),
            child: const Text(
              "Start",
              style: TextStyle(fontSize: 20,color: Colors.white),
            )),
      ),
    );
  }
}
