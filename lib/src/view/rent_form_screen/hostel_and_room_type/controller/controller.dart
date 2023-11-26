import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';

import '../../../../utils/widgets/flat_radio_button_wedget.dart';
import '../../../../utils/widgets/hostel_radio_button_widget.dart';

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

  onSubimitButton() {
    loading.value = true;
    Get.toNamed(RoutesName.providsFacilitesScreen)?.then((value) {
      loading.value = false;
    }).onError((error, stackTrace) {
      loading.value = false;
    });
  }
}
