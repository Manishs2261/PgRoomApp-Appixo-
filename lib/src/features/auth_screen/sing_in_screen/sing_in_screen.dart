import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/auth_screen/sing_in_screen/sing_screen_controller/sing_screen_controller.dart';
import 'package:pgroom/src/features/auth_screen/sing_profile_screen/sing_profile_screen.dart';
import 'package:pgroom/src/utils/Constants/sizes.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
 import '../../../res/route_name/routes_name.dart';
import '../otp_phone_screen/otp_phone_screen.dart';
import 'Widgets/HeaderWidgets.dart';
import 'Widgets/SignFormWidget.dart';

class SingInScreen extends StatelessWidget {
  SingInScreen({super.key});

  final globalKey = GlobalKey<FormState>();
  final _controller = Get.put(SingScreenController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("rebuild => sing screen ");

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: GestureDetector(
        // ======on tab off the keyboard screen
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderWidgets(),
                const SizedBox(
                  height: AppSizes.defaultSpace,
                ),
                SignFormWidget(globalKey: globalKey, controller: _controller),

                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SignProfileScreen()));
                }, child: Text("opt"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
