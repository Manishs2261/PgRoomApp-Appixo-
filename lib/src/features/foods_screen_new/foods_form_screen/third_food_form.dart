import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/widgets/com_reuse_elevated_button.dart';
import '../../../res/route_name/routes_name.dart';

class ThirdFoodForm extends StatefulWidget {
  const ThirdFoodForm({super.key});

  @override
  State<ThirdFoodForm> createState() => _ThirdFoodFormState();
}

class _ThirdFoodFormState extends State<ThirdFoodForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("third food form"),),

      body: Column(
        children: [

          const SizedBox(
            height: 16,
          ),

          SizedBox(height: 20),
          ReuseElevButton(
            onPressed: () => Get.toNamed(RoutesName.fourthFoodFormScreen),
            title: "Save & Next",
          ),

          SizedBox(height: 20),
          ReuseElevButton(
            color: Colors.orange,
            onPressed: () => Get.back(),
            title: "Back",
          ),
        ],
      ),
    );
  }
}
