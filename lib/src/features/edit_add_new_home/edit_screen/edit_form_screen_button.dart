import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
 import '../../../model/user_rent_model/user_rent_model.dart';
import 'controller/controller.dart';

class EditFormScreenButton extends StatelessWidget {
  EditFormScreenButton({super.key});

  final itemId = Get.arguments["id"];
  final UserRentModel data = Get.arguments['list'];

  final controller = Get.put(EditFormScreenController(Get.arguments['list'], Get.arguments["id"]));

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build -EditFormScreenButton ");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Page"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ItemEditButtonWidgets(
                data: data,
                itemId: itemId,
                title: "Edit Images",
                screenName: RoutesName.editImagesScreen,
              ),
              ItemEditButtonWidgets(
                data: data,
                itemId: itemId,
                title: "Edit Other image",
                screenName: RoutesName.editOtherImageScareen,
              ),
              ItemEditButtonWidgets(
                data: data,
                itemId: itemId,
                title: "Edit Details ",
                screenName: RoutesName.editRentDetailScreen,
              ),
              ItemEditButtonWidgets(
                data: data,
                itemId: itemId,
                title: "Edit House Type and Price ",
                screenName: RoutesName.editRoomTyprAndPriceScreen,
              ),
              ItemEditButtonWidgets(
                data: data,
                itemId: itemId,
                title: "Edit Provides Facilities",
                screenName: RoutesName.editFaciliteProviderScreen,
              ),
              ItemEditButtonWidgets(
                data: data,
                itemId: itemId,
                title: "Edit Additional Charges and Time",
                screenName: RoutesName.editChargesScreen,
              ),
              ItemEditButtonWidgets(
                data: data,
                itemId: itemId,
                title: "Edit Permission",
                screenName: RoutesName.editPermissionScreen,
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class ItemEditButtonWidgets extends StatelessWidget {
  const ItemEditButtonWidgets({
    super.key,
    required this.data,
    required this.itemId,
    required this.title,
    required this.screenName,
  });

  final UserRentModel data;
  final itemId;
  final String title;
  final String screenName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {
              Get.toNamed(screenName, arguments: {'list': data, 'id': itemId});
            },
            child: Text(title)),
      ),
    );
  }
}
