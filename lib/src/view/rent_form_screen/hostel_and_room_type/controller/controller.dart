import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';

import '../../../../repositiry/apis/apis.dart';
import '../../widget/flat_radio_button_wedget.dart';
import '../../widget/hostel_radio_button_widget.dart';

class HostelAndRoomController extends GetxController {
  // choose any one for initialize Enum verible not all
  var faltTypeEnum = FaltTypeEnum.OneBhk.obs;
  var hostelTypeEnum = HostelTypeEnum.BoysH.obs;

  RxBool isBool = false.obs;
  RxBool checkboxSingle1 = false.obs;
  RxBool checkboxDoble2 = false.obs;
  RxBool checkboxTriple3 = false.obs;
  RxBool checkboxFour4 = false.obs;
  RxBool checkboxFaimalyRoom = false.obs;

  final singlePersonContrller = TextEditingController().obs;
  final doublePersonContrller = TextEditingController().obs;
  final triplePersonContrller = TextEditingController().obs;
  final fourPersonContrller = TextEditingController().obs;
  final faimlyPersonContrller = TextEditingController().obs;

  RxString roomType = ''.obs;
  RxString bhk = ''.obs;

  RxBool loading = false.obs;

  // for Obsever the Enum class

  void updateHostelType(HostelTypeEnum? newHostelTypeEnum) {
    hostelTypeEnum.value = newHostelTypeEnum!;
  }

  void updateFlatType(FaltTypeEnum? newFlatTypeEnum) {
    faltTypeEnum.value = newFlatTypeEnum!;
  }

  boysHostelContions(value) {
    updateHostelType(value);
    isBool.value = false;
    roomType.value = "Boys";
    bhk.value = '';
  }

  girlsHostelContions(value) {
    updateHostelType(value);
    isBool.value = false;
    roomType.value = "Girls";
    bhk.value = '';
  }

  flatTypeContionas(value) {
    updateHostelType(value);
    isBool.value = true;
    roomType.value = "Faimly";
  }

  oneBhkCondition(value) {
    updateFlatType(value);
    bhk.value = '1BHK';
  }

  twoBhkCondition(value) {
    updateFlatType(value);
    bhk.value = '2BHK';
  }

  threeBhkCondition(value) {
    updateFlatType(value);
    bhk.value = '3BHK';
  }

  // onSubmitButton() {
  //
  //   Get.toNamed(RoutesName.providsFacilitesScreen);

    // loading.value = true;
    // ApisClass.pgRoomAndFlatTypePrice(
    //         roomType.value,
    //         bhk.value,
    //         singlePersonContrller.value.text,
    //         doublePersonContrller.value.text,
    //         triplePersonContrller.value.text,
    //         fourPersonContrller.value.text,
    //         faimlyPersonContrller.value.text)
    //     .then((value) {
    //   loading.value = false;
    //   Get.snackbar("add", "sussfulley");
    //   Get.toNamed(RoutesName.providsFacilitesScreen);
    // }).onError((error, stackTrace) {
    //   loading.value = false;
    //   Get.snackbar("errror", "errpr");
    //   if (kDebugMode) {
    //     print("error 🔴$error");
    //   }
    // });
  //}
}
