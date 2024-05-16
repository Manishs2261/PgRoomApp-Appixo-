import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../utils/Constants/colors.dart';
import '../../../utils/helpers/helper_function.dart';

class StartButtonWidget extends StatelessWidget {
  const StartButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          Get.offNamed(RoutesName.loginScreen);
        },
        child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            alignment: Alignment.center,
            width: AppHelperFunction.screenWidth() * 0.6,
            height: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.primary),
            child: const Text(
              "Start",
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
      ),
    );
  }
}
