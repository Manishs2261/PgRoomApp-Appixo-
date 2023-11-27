import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/model/user_rent_model/user_rent_model.dart';
 import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import '../../../../data/repository/apis/apis.dart';
import '../../../../utils/widgets/flat_radio_button_wedget.dart';
import '../../../../utils/widgets/hostel_radio_button_widget.dart';

class EditFormScreenController extends GetxController {
  UserRentModel data = UserRentModel();
  var itemId;

  EditFormScreenController(this.data, this.itemId);

  Rx<TextEditingController> houseNameController = TextEditingController().obs;
  Rx<TextEditingController> houseAddressController = TextEditingController().obs;
  Rx<TextEditingController> cityNameController = TextEditingController().obs;
  Rx<TextEditingController> landMarkController = TextEditingController().obs;
  Rx<TextEditingController> contactNumberController = TextEditingController().obs;

  Rx<TextEditingController> singlePersonController = TextEditingController().obs;
  Rx<TextEditingController> doublePersonController = TextEditingController().obs;
  Rx<TextEditingController> triplePersonController = TextEditingController().obs;
  Rx<TextEditingController> fourPersonController = TextEditingController().obs;
  Rx<TextEditingController> familyPersonController = TextEditingController().obs;

  Rx<TextEditingController> restrictedController = TextEditingController(text: "").obs;

  RxBool checkboxSingle1 = false.obs;
  RxBool checkboxDouble2 = false.obs;
  RxBool checkboxTriple3 = false.obs;
  RxBool checkboxFour4 = false.obs;
  RxBool checkboxFamilyRoom = false.obs;

  // choose any one for initialize Enum variable not all
  var flatTypeEnum = FaltTypeEnum.OneBhk.obs;
  var hostelTypeEnum = HostelTypeEnum.BoysH.obs;

  RxString roomType = ''.obs;
  RxString bhk = ''.obs;

  RxBool wifi = false.obs;
  RxBool bed = false.obs;
  RxBool chair = false.obs;
  RxBool table = false.obs;
  RxBool fan = false.obs;
  RxBool gadda = false.obs;
  RxBool light = false.obs;
  RxBool locker = false.obs;
  RxBool bedSheet = false.obs;
  RxBool washingMachine = false.obs;
  RxBool parking = false.obs;
  RxBool loading = false.obs;

  RxBool electricityBill = false.obs;
  RxBool waterBill = false.obs;
  RxBool flexibleTime = false.obs;
  RxBool restrictedTime = false.obs;

  RxBool cookingAllow = false.obs;
  RxBool veg = false.obs;
  RxBool bothVegAndNonVeg = false.obs;
  RxBool girl = false.obs;
  RxBool boy = false.obs;
  RxBool familyMember = false.obs;

  var cookingType = "".obs;
  XFile? image;

  // image picker form Gallery
  RxString selectedCoverImage = "".obs;

  RxBool selectedImage = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    houseNameController = TextEditingController(text: data.houseName).obs;
    houseAddressController = TextEditingController(text: data.addres).obs;
    cityNameController = TextEditingController(text: data.city).obs;
    landMarkController = TextEditingController(text: data.landMark).obs;
    contactNumberController = TextEditingController(text: data.contactNumber).obs;

    singlePersonController = TextEditingController(text: data.singlePersonPrice).obs;
    doublePersonController = TextEditingController(text: data.doublePersionPrice).obs;
    triplePersonController = TextEditingController(text: data.triplePersionPrice).obs;
    fourPersonController = TextEditingController(text: data.fourPersionPrice).obs;
    familyPersonController = TextEditingController(text: data.faimlyPrice).obs;

    restrictedController = TextEditingController(text: data.restrictedTime).obs;

    checkboxSingle1 = (data.singlePersonPrice != null).obs;
    checkboxDouble2 = (data.doublePersionPrice != null).obs;
    checkboxTriple3 = (data.triplePersionPrice != null).obs;
    checkboxFour4 = (data.fourPersionPrice != null).obs;
    checkboxFamilyRoom = (data.faimlyPrice != null).obs;

    roomType = '${data.roomType}'.obs;
    bhk = '${data.bhkType}'.obs;

    wifi = data.wifi!.obs;
    bed = data.bed!.obs;
    chair = data.chair!.obs;
    table = data.table!.obs;
    fan = data.fan!.obs;
    gadda = data.gadda!.obs;
    light = data.light!.obs;
    locker = data.locker!.obs;
    bedSheet = data.bedSheet!.obs;
    washingMachine = data.washingMachin!.obs;
    parking = data.parking!.obs;

    electricityBill = data.electricityBill!.obs;
    waterBill = data.waterBill!.obs;
    flexibleTime = data.fexibleTime!.obs;

    cookingAllow = data.cooking!.obs;
    veg = (data.cookingType == 'veg Only').obs;
    bothVegAndNonVeg = (data.cookingType == 'veg and non-veg both allow').obs;
    girl = data.girls!.obs;
    boy = data.boy!.obs;
    familyMember = data.faimlyMember!.obs;
    restrictedTime = (data.restrictedTime != null).obs;

    cookingType = "${data.cookingType}".obs;

    // image picker form Gallery
    selectedCoverImage = "${data.coverImage}".obs;
    selectedImage = (data.coverImage != '').obs;

    super.onInit();
  }

  // for bool value false not show a image
  RxBool isBool = false.obs;
  RxBool addImage = false.obs;
  RxBool isSelected = false.obs;

  // for storing a more image in list
  RxList imageFileList = [].obs;

  Future pickCoverImageFromGallery() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image == null) return;
    selectedCoverImage.value = image!.path.toString();
  }

  cookingAllowCondition(value) {
    cookingAllow.value = value;

    if (cookingAllow.value == false) {
      veg.value = false;
      bothVegAndNonVeg.value = false;
      cookingType.value = "";
    }
  }

  vegOnlyCondition(value) {
    veg.value = value!;
    bothVegAndNonVeg.value = false;
    cookingType.value = "veg Only";
  }

  vegAndNonVegCondition(value) {
    bothVegAndNonVeg.value = value!;
    veg.value = false;
    cookingType.value = "veg and non-veg both allow";
  }

  flexibleTimeCondition(value) {
    flexibleTime.value = value!;
    restrictedTime.value = false;
    restrictedController.value.clear();
  }

  restrictedTimeCondition(value) {
    restrictedTime.value = value!;
    flexibleTime.value = false;
  }

  // for Observer the Enum class

  void updateHostelType(HostelTypeEnum? newHostelTypeEnum) {
    hostelTypeEnum.value = newHostelTypeEnum!;
  }

  void updateFlatType(FaltTypeEnum? newFlatTypeEnum) {
    flatTypeEnum.value = newFlatTypeEnum!;
  }

  Future<void> onEditCoverImageSaveButton() async {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        loading.value = true;
        ApisClass.updateCoverItemImage(File(image!.path), itemId).then((value) {
          Get.snackbar("Image Update ", "Successfully");
          loading.value = false;
          Navigator.pop(Get.context!);
          Navigator.pop(Get.context!);
          Navigator.pop(Get.context!);
        }).onError((error, stackTrace) {
          loading.value = false;
          Get.snackbar("Image Update ", "Failed");
          AppLoggerHelper.error("Update cover image Error", error);
          AppLoggerHelper.error("Update cover image Error", stackTrace);
        });
      }
    });
  }

  Future<void> onEditRentDetailsData() async {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        loading.value = true;
        ApisClass.updateRentDetilaData(
                houseNameController.value.text,
                houseAddressController.value.text,
                cityNameController.value.text,
                landMarkController.value.text,
                contactNumberController.value.text,
                itemId)
            .then((value) {
          loading.value = false;
          Get.snackbar("Update", "Successfully");
          Navigator.pop(Get.context!);
          Navigator.pop(Get.context!);
          Navigator.pop(Get.context!);
        }).onError((error, stackTrace) {
          loading.value = false;
          Get.snackbar("Update", "Failed");
          AppLoggerHelper.error("Upload Rent Details Error", error);
          AppLoggerHelper.error('$stackTrace');
        });
      }
    });
  }

  Future<void> onEditRoomTypeAndPriceData() async {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        loading.value = true;
        ApisClass.updateRoomTypeAndPrice(itemId, singlePersonController.value.text, doublePersonController.value.text,
                triplePersonController.value.text, fourPersonController.value.text, familyPersonController.value.text)
            .then((value) {
          loading.value = false;
          Get.snackbar("Update", "Successfully");
          Navigator.pop(Get.context!);
          Navigator.pop(Get.context!);
          Navigator.pop(Get.context!);
        }).onError((error, stackTrace) {
          loading.value = false;
          Get.snackbar("Update", "Failed");
          AppLoggerHelper.error("Upload Room type and price Error", error);
          AppLoggerHelper.error('$stackTrace');
        });
      }
    });
  }

  Future<void> onEditProviderFacilitiesData() async {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        loading.value = true;
        ApisClass.updateProvideFacilitiesData(
          itemId,
          wifi.value,
          bed.value,
          chair.value,
          table.value,
          fan.value,
          gadda.value,
          light.value,
          locker.value,
          bedSheet.value,
          washingMachine.value,
          parking.value,
        ).then((value) {
          loading.value = false;
          Get.snackbar("Update", "Successfully");
          Navigator.pop(Get.context!);
          Navigator.pop(Get.context!);
          Navigator.pop(Get.context!);
        }).onError((error, stackTrace) {
          loading.value = false;
          Get.snackbar("Update", "Failed");
          AppLoggerHelper.error("Upload Provider Facilities Error", error);
          AppLoggerHelper.error('$stackTrace');
        });
      }
    });
  }

  Future<void> onEditAdditionalChargesAndDoor() async {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        loading.value = true;
        ApisClass.updateAdditionalChargesAndDoorDate(
                itemId, electricityBill.value, waterBill.value, restrictedController.value.text, flexibleTime.value)
            .then((value) {
          loading.value = false;
          Get.snackbar("Update", "Successfully");
          Navigator.pop(Get.context!);
          Navigator.pop(Get.context!);
          Navigator.pop(Get.context!);
        }).onError((error, stackTrace) {
          loading.value = false;
          Get.snackbar("Update", "Failed");
          AppLoggerHelper.error("Upload Additional charges  Error", error);
          AppLoggerHelper.error('$stackTrace');
        });
      }
    });
  }

  Future<void> onEditPermissionData() async {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        loading.value = true;
        ApisClass.updatePermissionData(
                itemId, cookingType.value, cookingAllow.value, boy.value, girl.value, familyMember.value)
            .then((value) {
          loading.value = false;
          Get.snackbar("Update", "Successfully");
          Navigator.pop(Get.context!);
          Navigator.pop(Get.context!);
          Navigator.pop(Get.context!);
        }).onError((error, stackTrace) {
          loading.value = false;
          Get.snackbar("Update", "Failed");
          AppLoggerHelper.error("Upload Permission Error", error);
          AppLoggerHelper.error('$stackTrace');
        });
      }
    });
  }
}
