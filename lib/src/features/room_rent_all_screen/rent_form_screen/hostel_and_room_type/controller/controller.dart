import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';

import '../../../../../utils/widgets/flat_radio_button_wedget.dart';
import '../../../../../utils/widgets/hostel_radio_button_widget.dart';


class HostelAndRoomController extends GetxController {
  // choose any one for initialize Enum veritable not all
  var flatTypeEnum = FaltTypeEnum.OneBhk.obs;
  var hostelTypeEnum = HostelTypeEnum.BoysH.obs;

  RxBool isBool = false.obs;
  RxBool checkboxSingle1 = false.obs;
  RxBool checkboxDouble2 = false.obs;
  RxBool checkboxTriple3 = false.obs;
  RxBool checkboxFour4 = false.obs;
  RxBool checkboxFamilyRoom = false.obs;

  final singlePersonController = TextEditingController().obs;
  final doublePersonController = TextEditingController().obs;
  final triplePersonController = TextEditingController().obs;
  final fourPersonController = TextEditingController().obs;
  final familyPersonController = TextEditingController().obs;

  RxString roomType = 'Boys'.obs;
  RxString bhk = ''.obs;

  RxBool loading = false.obs;

  // for Observer the Enum class

  void updateHostelType(HostelTypeEnum? newHostelTypeEnum) {
    hostelTypeEnum.value = newHostelTypeEnum!;
  }

  void updateFlatType(FaltTypeEnum? newFlatTypeEnum) {
    flatTypeEnum.value = newFlatTypeEnum!;
  }

  boysHostelConditions(value) {
    updateHostelType(value);
    isBool.value = false;
    roomType.value = "Boys";
    bhk.value = '';
  }

  girlsHostelConditions(value) {
    updateHostelType(value);
    isBool.value = false;
    roomType.value = "Girls";
    bhk.value = '';
  }

  flatTypeConditions(value) {
    updateHostelType(value);
    isBool.value = true;
    roomType.value = "Family";
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

  onSubmitButton() {
    Get.toNamed(RoutesName.provideFacilitiesScreen);
  }
}
