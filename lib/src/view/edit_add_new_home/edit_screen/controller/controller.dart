import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/model/user_rent_model/user_rent_model.dart';

import '../../../../uitels/widgets/flat_radio_button_wedget.dart';
import '../../../../uitels/widgets/hostel_radio_button_widget.dart';

class EditFormScreenController extends GetxController {
  UserRentModel data;

  EditFormScreenController(this.data);

  RxBool checkboxSingle1 = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    onprint();
    checkboxSingle1 = (data.singlePersonPrice != null).obs;
    super.onInit();
  }

  final houseNameController = TextEditingController().obs;
  final houseAddressController = TextEditingController().obs;
  final cityNameController = TextEditingController().obs;
  final landdMarkController = TextEditingController().obs;
  final contactNumberController = TextEditingController().obs;

  // choose any one for initialize Enum verible not all
  var faltTypeEnum = FaltTypeEnum.OneBhk.obs;
  var hostelTypeEnum = HostelTypeEnum.BoysH.obs;

  RxBool isBool = false.obs;

  RxBool checkboxDoble2 = false.obs;
  RxBool checkboxTriple3 = false.obs;
  RxBool checkboxFour4 = false.obs;
  RxBool checkboxFaimalyRoom = false.obs;

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

  onprint() {
    print(data.houseName);
  }
}
