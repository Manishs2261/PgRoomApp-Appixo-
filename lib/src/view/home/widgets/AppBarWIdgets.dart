import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repositiry/apis/apis.dart';
import '../../../res/route_name/routes_name.dart';
import '../../splash/controller/splash_controller.dart';

class AppBarWIdgets extends StatelessWidget {
  const AppBarWIdgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        //   ===post room free   ==================
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () {
              (ApisClass.auth.currentUser?.uid == finalUserUidGloble)
                  ? Get.toNamed(RoutesName.addYourHomeScreen)
                  : Get.defaultDialog(
                      title: "Login please",
                      middleText: "Without login your are not post home",
                      actions: [
                          ElevatedButton(
                              onPressed: () {
                                Get.offAllNamed(RoutesName.loginScreen);
                              },
                              child: const Text("Login"))
                        ]);
            },
            child: Container(
              alignment: Alignment.center,
              height: 25,
              width: 135,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all()),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Post Room", textAlign: TextAlign.center),

                  //===========free container =============
                  Container(
                    alignment: Alignment.center,
                    height: 15,
                    width: 40,
                    decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(12)),
                    child: const Text(
                      "Free",
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
