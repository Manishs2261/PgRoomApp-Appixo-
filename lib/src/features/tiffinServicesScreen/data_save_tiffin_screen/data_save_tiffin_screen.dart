import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:pgroom/src/utils/device/device_utility.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import '../../../common/widgets/com_reuse_elevated_button.dart';
import '../../../utils/Constants/colors.dart';
import '../../../utils/Constants/image_string.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../../utils/validator/text_field_validator.dart';
import '../../../utils/widgets/my_text_form_field.dart';
import 'controller/controller.dart';

class DataSaveTiffineScreen extends StatelessWidget {
  const DataSaveTiffineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - AddTiffineScreen");
    final controller = Get.put(AddYourTiffineController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add your foods services"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      "This Image show in your Cover page",
                      style: TextStyle(color: Colors.green),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    //========stack container ============

                    //cover image
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),

                      //======== cover image=================
                      child: Stack(
                        children: [
                          // =====for initial image when your don't choose image============
                          Obx(
                            () => controller.selectedCoverImage.value != ""
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: Image(
                                      image: FileImage(File(controller.selectedCoverImage.value.toString())),
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: const Image(
                                      image: AssetImage(AppImage.foodImage),
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),

                          // ========for add a image button=========

                          Obx(
                            () => Visibility(
                              visible: (controller.selectedCoverImage.value == ""),
                              child: Positioned(
                                top: 60,
                                left: 80,
                                child: InkWell(
                                  onTap: () {
                                    controller.pickCoverImageFromGallery();
                                  },
                                  child: Container(
                                    height: 60,
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.white),
                                        color: Colors.black.withOpacity(.7)),
                                    child: const Text(
                                      "Choose cover Image",
                                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //==========for delete  Cover image a image===========
                          Obx(() => Visibility(
                                visible: (controller.selectedCoverImage.value != ""),
                                child: Positioned(
                                    right: 7,
                                    top: 7,
                                    child: InkWell(
                                      onTap: () {
                                        controller.selectedCoverImage.value = "";
                                      },
                                      child: const CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.black26,
                                        child: Text(
                                          "X",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )),
                              ))
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    //=============================================================
                    const Text(
                      "Choose the menu Image",
                      style: TextStyle(color: Colors.green),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    //========stack container ============
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),

                      //======== cover image=================
                      child: Stack(
                        children: [
                          // =====for initial image when your don't choose image============
                          Obx(
                            () => controller.selectedMenuImage.value != ""
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: Image(
                                      image: FileImage(File(controller.selectedMenuImage.value.toString())),
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: const Image(
                                      image: AssetImage(AppImage.menuImage),
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                          ),

                          // ========for add a image button=========

                          Obx(
                            () => Visibility(
                              visible: (controller.selectedMenuImage.value == ""),
                              child: Positioned(
                                top: 60,
                                left: 80,
                                child: InkWell(
                                  onTap: () {
                                    controller.pickMenuImageFromGallery();
                                  },
                                  child: Container(
                                    height: 60,
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.white),
                                        color: Colors.black.withOpacity(.7)),
                                    child: const Text(
                                      "Choose Menu Image",
                                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //==========for delete  Cover image a image===========
                          Obx(() => Visibility(
                                visible: (controller.selectedMenuImage.value != ""),
                                child: Positioned(
                                    right: 7,
                                    top: 7,
                                    child: InkWell(
                                      onTap: () {
                                        controller.selectedMenuImage.value = "";
                                      },
                                      child: const CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.black26,
                                        child: Text(
                                          "X",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 50,
                ),

                Form(
                    key: controller.globalKey,
                    child: Column(
                      children: [
                        MyTextFormWedgit(
                          controller: controller.servicesNameController.value,
                          hintText: "Enter Tiffine Service Name",
                          lableText: 'Service Name',
                          icon: const Icon(Icons.food_bank_sharp),
                          borderRadius: BorderRadius.circular(11),
                          contentPadding: const EdgeInsets.only(top: 5, left: 10),
                          validator: NameValidator.validate,
                          textKeyBoard: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyTextFormWedgit(
                          controller: controller.addressController.value,
                          hintText: "Enter address",
                          lableText: 'Address',
                          icon: const Icon(Icons.location_city),
                          borderRadius: BorderRadius.circular(11),
                          contentPadding: const EdgeInsets.only(top: 5, left: 10),
                          validator: NameValidator.validate,
                          textKeyBoard: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        //==========Contact Number================
                        MyTextFormWedgit(
                          textKeyBoard: TextInputType.phone,
                          maxLength: 10,
                          controller: controller.numberController.value,
                          hintText: "Contact Number",
                          lableText: 'Contact Number',
                          icon: const Icon(Icons.phone),
                          borderRadius: BorderRadius.circular(11),
                          contentPadding: const EdgeInsets.only(top: 5, left: 10),
                          validator: ContactNumberValidator.validate,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyTextFormWedgit(
                          controller: controller.priceController.value,
                          hintText: "Enter Price according day  ",
                          lableText: 'Price Month',
                          icon: const Icon(Icons.currency_rupee),
                          borderRadius: BorderRadius.circular(11),
                          contentPadding: const EdgeInsets.only(top: 5, left: 10),
                          validator: NameValidator.validate,
                          textKeyBoard: TextInputType.number,
                        ),
                      ],
                    )),

                //=========save & next button ===============

                const SizedBox(
                  height: 40,
                ),

                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
                  child: FlutterLocationPicker(
                    showSearchBar: false,
                    searchbarBorderRadius: BorderRadius.circular(50),
                    selectLocationButtonStyle: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                    ),
                    selectLocationButtonText: "Set a Location",
                    initZoom: 11,
                    minZoomLevel: 1,
                    maxZoomLevel: 16,
                    trackMyPosition: true,
                    selectedLocationButtonTextstyle: const TextStyle(fontSize: 18),
                    mapLanguage: 'en',
                    onError: (e) => print(e),
                    countryFilter: 'In',
                    markerIcon: const Icon(
                      Icons.location_on_sharp,
                      color: Colors.red,
                      size: 60,
                    ),
                    selectLocationButtonLeadingIcon: const Icon(
                      Icons.check,
                    ),
                    onPicked: (pickedData) {
                      print(pickedData.latLong.latitude);
                      print(pickedData.latLong.longitude);
                      controller.latitude.value = pickedData.latLong.latitude.toString();
                      controller.longitude.value = pickedData.latLong.longitude.toString();
                      AppHelperFunction.showSnackBar("Location set successfully");
                    },
                    showContributorBadgeForOSM: true,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),

                ComReuseElevButton(
                  onPressed: () => controller.onSubmitButton(),
                  title: "Save",
                ),

                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
