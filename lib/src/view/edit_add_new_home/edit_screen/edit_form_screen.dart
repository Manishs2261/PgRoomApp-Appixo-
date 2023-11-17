import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/view/edit_add_new_home/edit_screen/controller/controller.dart';

import '../../../model/user_rent_model/user_rent_model.dart';

class EditFormScreen extends StatelessWidget {
  EditFormScreen({super.key});

  final itemId = Get.arguments["id"];
  final UserRentModel data = Get.arguments['list'];

  final controller = Get.put(
      EditFormScreenController(Get.arguments['list'], Get.arguments["id"]));

  @override
  Widget build(BuildContext context) {
    print("Build Screen => Edit_Form_Screen ❤");
    print(data.addres);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
            child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 80),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(RoutesName.editImagesScreen,
                          arguments: {'list': data, 'id': itemId});
                    },
                    child: Text(" Edit Images")),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(RoutesName.editOtherImageScareen,
                          arguments: {'list': data, 'id': itemId});
                    },
                    child: Text(" Edit Other image ")),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(RoutesName.editRentDetailScreen,
                          arguments: {'list': data, 'id': itemId});
                    },
                    child: Text("Edit Details ")),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(RoutesName.editRoomTyprAndPriceScreen,
                          arguments: {'list': data, 'id': itemId});
                    },
                    child: Text(" Edit House Type and Price ")),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(RoutesName.editFaciliteProviderScreen,
                          arguments: {'list': data, 'id': itemId});
                    },
                    child: Text(" Edit Provides Facilites")),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(RoutesName.editChargesScreen,
                          arguments: {'list': data, 'id': itemId});
                    },
                    child: Text(" Edit Additional Chareges and Time")),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(RoutesName.editPermissionScreen,
                          arguments: {'list': data, 'id': itemId});
                    },
                    child: Text(" Edit Permission")),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
