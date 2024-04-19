import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/auth_apis/auth_apis.dart';
import '../../../res/route_name/routes_name.dart';

class AppBarOldGoodsWidgets extends StatelessWidget {
  const  AppBarOldGoodsWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Old Goods"),
      actions: [
        //   ===post room free   ==================
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () {
              AuthApisClass.checkUserLogin().then((value) {
                if (value) {
                  Get.toNamed(RoutesName.addYourOldGoodsScreen);
                }
              });
            },
            child: Container(
              alignment: Alignment.center,
              height: 25,
              width: 135,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(.7), offset: const Offset(0, 3)),
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Post Service",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),

                  //===========free container =============
                  Container(
                    alignment: Alignment.center,
                    height: 15,
                    width: 40,
                    decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(12)),
                    child: const Text(
                      "Free",
                      style: TextStyle(fontSize: 10, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        // IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
      ],
    );
  }
}
