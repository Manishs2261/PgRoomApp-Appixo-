import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/model/user_rent_model/user_rent_model.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';

import '../../../../res/route_name/routes_name.dart';
import '../../../../uitels/widgets/flat_radio_button_wedget.dart';
import '../../../../uitels/widgets/hostel_radio_button_widget.dart';

class EditFormScreenController extends GetxController {
  UserRentModel data = UserRentModel();

  var itemId;

  EditFormScreenController(this.data, this.itemId);


   Rx<TextEditingController> houseNameController = TextEditingController().obs;
   Rx<TextEditingController> houseAddressController = TextEditingController().obs;
   Rx<TextEditingController> cityNameController = TextEditingController().obs;
   Rx<TextEditingController> landdMarkController = TextEditingController().obs;
   Rx<TextEditingController> contactNumberController = TextEditingController().obs;

   Rx<TextEditingController> singlePersonContrller = TextEditingController().obs;
   Rx<TextEditingController> doublePersonContrller = TextEditingController().obs;
   Rx<TextEditingController> triplePersonContrller = TextEditingController().obs;
   Rx<TextEditingController> fourPersonContrller = TextEditingController().obs;
   Rx<TextEditingController> faimlyPersonContrller = TextEditingController().obs;


   Rx<TextEditingController> restrictedController = TextEditingController(text: "").obs;


  RxBool checkboxSingle1 = false.obs;
  RxBool checkboxDoble2 = false.obs;
  RxBool checkboxTriple3 =false.obs;
   RxBool checkboxFour4 = false.obs;
  RxBool checkboxFaimalyRoom = false.obs;

  // choose any one for initialize Enum verible not all
  var faltTypeEnum = FaltTypeEnum.OneBhk.obs;
  var hostelTypeEnum = HostelTypeEnum.BoysH.obs;

  RxString roomType = ''.obs;
  RxString bhk = ''.obs;



  RxBool wifi = false.obs;
  RxBool bed = false.obs;
  RxBool chari = false.obs;
  RxBool table = false.obs;
  RxBool fan = false.obs;
  RxBool gadda = false.obs;
  RxBool light = false.obs;
  RxBool locker = false.obs;
  RxBool bedSheet = false.obs;
  RxBool washingMachin = false.obs;
  RxBool parking = false.obs;
  RxBool loading = false.obs;


  RxBool electricityBill = false.obs;
  RxBool waterBill = false.obs;
  RxBool fexibleTime = false.obs;
  RxBool restrictedTime = false.obs;


  RxBool cookingAllow = false.obs;
  RxBool veg = false.obs;
  RxBool bothVegAndNonVeg = false.obs;
  RxBool girl = false.obs;
  RxBool boy = false.obs;
  RxBool faimlyMamber = false.obs;

  var cookingType = "".obs;
  XFile? image;

  // image picker form Gallary
  RxString selectedCoverImage = "".obs;

  RxBool selectedImagr = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit


     houseNameController = TextEditingController(text: data.houseName).obs;
     houseAddressController = TextEditingController(text: data.addres).obs;
     cityNameController = TextEditingController(text: data.city).obs;
     landdMarkController = TextEditingController(text: data.landMark).obs;
     contactNumberController = TextEditingController(text: data.contactNumber).obs;


      singlePersonContrller = TextEditingController(text: data.singlePersonPrice).obs;
      doublePersonContrller = TextEditingController(text: data.doublePersionPrice).obs;
      triplePersonContrller = TextEditingController(text: data.triplePersionPrice).obs;
      fourPersonContrller = TextEditingController(text: data.fourPersionPrice).obs;
      faimlyPersonContrller = TextEditingController(text: data.faimlyPrice).obs;


      restrictedController = TextEditingController(text: data.restrictedTime).obs;



    checkboxSingle1 = (data.singlePersonPrice != null).obs;
     checkboxDoble2 = (data.doublePersionPrice != null).obs;
     checkboxTriple3 =(data.triplePersionPrice != null).obs;
     checkboxFour4 = (data.fourPersionPrice != null).obs;
     checkboxFaimalyRoom =(data.faimlyPrice != null).obs;

   roomType = '${data.roomType}'.obs;
    bhk = '${data.bhkType}'.obs;


     wifi = data.wifi!.obs;
     bed = data.bed!.obs;
     chari = data.chair!.obs;
     table = data.table!.obs;
     fan = data.fan!.obs;
     gadda = data.gadda!.obs;
     light = data.light!.obs;
     locker = data.locker!.obs;
     bedSheet = data.bedSheet!.obs;
     washingMachin = data.washingMachin!.obs;
     parking = data.parking!.obs;


     electricityBill = data.electricityBill!.obs;
     waterBill = data.waterBill!.obs;
     fexibleTime = data.fexibleTime!.obs;

     cookingAllow = data.cooking!.obs;
     veg = (data.cookingType == 'veg Only').obs;
     bothVegAndNonVeg = (data.cookingType == 'veg and non-veg both allow').obs;
     girl = data.girls!.obs;
     boy = data.boy!.obs;
     faimlyMamber = data.faimlyMember!.obs;
      restrictedTime = (data.restrictedTime != null).obs;

     cookingType = "${data.cookingType}".obs;

     // image picker form Gallary
      selectedCoverImage = "${data.coverImage}".obs;
      selectedImagr = (data.coverImage != '').obs;



    super.onInit();
  }


  // for bool value false not show a image
  RxBool isBool = false.obs;
  RxBool addimage = false.obs;
  RxBool isSelected = false.obs;


  // for storing a more image in list
  RxList imageFileList = [].obs;




  Future pickeImageFromGallery() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image == null) return;
    imageFileList.add(File(image.path));

    await ApisClass.uploadOtherImage(File(image.path)).then((value) {
      Get.snackbar("upload ", "other image");
    }).onError((error, stackTrace) {
      Get.snackbar("error", "error");
      print("errror => $error");
    });
  }

  //===========================================
  Future pickeCoverImageFromGallery() async {
    image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image == null) return;
    selectedCoverImage.value = image!.path.toString();
  }


  Future uploadCoverImage() async {
    await ApisClass.uploadCoverImage(File(image!.path)).then((value) {
      Get.snackbar("upload ", "cover  image");
    }).onError((error, stackTrace) {
      Get.snackbar("error", "error");
      print("errror => $error");
    });
  }
  //============================================

  // om submit button
  // onSubmitButton() {
  //   if (selectedCoverImage.isEmpty) {
  //     Get.snackbar("cover image", "not emplty");
  //   } else {
  //     Get.toNamed(RoutesName.rentDetailsFormScreen);
  //   }
  // }








  cookingAllowCondition(value) {
    cookingAllow.value = value;

    if (cookingAllow.value == false) {
      veg.value = false;
      bothVegAndNonVeg.value = false;
      cookingType.value = "";
    }
  }


  vegOnlyCondition(value){

    veg.value = value!;
    bothVegAndNonVeg.value =
    false;
    cookingType.value =
    "veg Only";
  }

  vegAndNonVegCondition(value){

    bothVegAndNonVeg.value =
    value!;
    veg.value = false;
    cookingType.value =
    "veg and non-veg both allow";
  }


  fexibleTimeCondition(value) {
    fexibleTime.value = value!;
    restrictedTime.value = false;
    restrictedController.value.clear();
  }

  restrictedTimeCondition(value) {
    restrictedTime.value = value!;
    fexibleTime.value = false;
  }




  // for Obsever the Enum class

  void updateHostelType(HostelTypeEnum? newHostelTypeEnum) {
    hostelTypeEnum.value = newHostelTypeEnum!;
  }

  void updateFlatType(FaltTypeEnum? newFlatTypeEnum) {
    faltTypeEnum.value = newFlatTypeEnum!;
  }


  onSubmitButton() {


   // print(selectedCoverImage);

    ApisClass.updateRentData(
      itemId,
      selectedCoverImage,
      houseAddressController,
      houseAddressController,
      cityNameController,
      landdMarkController,
      contactNumberController,
      bhk,
      roomType,
      singlePersonContrller,
      doublePersonContrller,
      triplePersonContrller,
      fourPersonContrller,
      faimlyPersonContrller,
      restrictedTime,
      '3.5',
      wifi,
      bed,
      chari,
      table,
      fan,
      gadda,
      light,
      locker,
      bedSheet,
      washingMachin,
      parking,
      electricityBill,
      waterBill,
      fexibleTime,
      cookingAllow,
      cookingType,
      boy,
      girl,
      faimlyMamber,
      false,
    ).then((value) {

      Get.snackbar("Update ", "successfully");
    }).onError((error, stackTrace) {

      print(error);
      print(stackTrace);
      Get.snackbar("error", "udatae",);
    });


  }
}
