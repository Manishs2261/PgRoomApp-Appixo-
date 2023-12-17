import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pinput/pinput.dart';

class RentDetailsController extends GetxController {
  final houseNameController = TextEditingController().obs;
  final houseAddressController = TextEditingController().obs;
  final cityNameController = TextEditingController().obs;
  final landMarkController = TextEditingController().obs;
  final contactNumberController = TextEditingController().obs;
  final numberOfRoomsController = TextEditingController().obs;
  RxBool loading = false.obs;

  onSubmitButton() async {
    if (contactNumberController.value.length != 10) {
      AppHelperFunction.showSnackBar("Please Enter 10 digit of number");
    } else {
      loading.value = true;
      Get.toNamed(RoutesName.hostelAndRoomTypeScreen)?.then((value) {
        loading.value = false;
      }).onError((error, stackTrace) {
        loading.value = false;
      });
    }
  }
}
