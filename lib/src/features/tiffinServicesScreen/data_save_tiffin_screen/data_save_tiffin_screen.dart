import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import '../../../common/widgets/com_reuse_elevated_button.dart';
import '../../../utils/Constants/image_string.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../../utils/validator/text_field_validator.dart';
import '../../../utils/widgets/my_text_form_field.dart';
import 'controller/controller.dart';

class DataSaveTiffineScreen extends StatefulWidget {
  const DataSaveTiffineScreen({super.key});

  @override
  State<DataSaveTiffineScreen> createState() => _DataSaveTiffineScreenState();
}

class _DataSaveTiffineScreenState extends State<DataSaveTiffineScreen> {
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
                        alignment: Alignment.center,
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
                              child: InkWell(
                                onTap: () {
                                  controller.pickCoverImageFromGallery();
                                },
                                child: Container(
                                  height: 60,
                                  width: 230,
                                  padding: const EdgeInsets.all(10),
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
                        alignment: Alignment.center,
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
                              child: InkWell(
                                onTap: () {
                                  controller.pickMenuImageFromGallery();
                                },
                                child: Container(
                                  height: 60,
                                  width: 220,
                                  padding: const EdgeInsets.all(10),
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
                        MyTextFormWidget(
                          controller: controller.servicesNameController.value,
                          hintText: "Enter Service Name",
                          labelText: 'Service Name',
                          icon: const Icon(Icons.food_bank_sharp),
                          borderRadius: BorderRadius.circular(11),
                          contentPadding: const EdgeInsets.only(top: 5, left: 10),
                          validator: NameValidator.validate,
                          textKeyBoard: TextInputType.text,
                          maxLength: 40,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyTextFormWidget(
                          controller: controller.addressController.value,
                          hintText: "Enter address",
                          labelText: 'Address',
                          icon: const Icon(Icons.location_city),
                          borderRadius: BorderRadius.circular(11),
                          contentPadding: const EdgeInsets.only(top: 5, left: 10),
                          validator: NameValidator.validate,
                          textKeyBoard: TextInputType.text,
                          maxLength: 100,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        //==========Contact Number================
                        MyTextFormWidget(
                          textKeyBoard: TextInputType.phone,
                          maxLength: 10,
                          controller: controller.numberController.value,
                          hintText: "Contact Number",
                          labelText: 'Contact Number',
                          icon: const Icon(Icons.phone),
                          borderRadius: BorderRadius.circular(11),
                          contentPadding: const EdgeInsets.only(top: 5, left: 10),
                          validator: ContactNumberValidator.validate,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyTextFormWidget(
                          controller: controller.priceController.value,
                          hintText: "Enter Price ",
                          labelText: 'Price Month',
                          icon: const Icon(Icons.currency_rupee),
                          borderRadius: BorderRadius.circular(11),
                          contentPadding: const EdgeInsets.only(top: 5, left: 10),
                          validator: NameValidator.validate,
                          textKeyBoard: TextInputType.number,
                          maxLength: 5,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                          ],
                        ),
                      ],
                    )),

                //=========save & next button ===============

                const SizedBox(
                  height: 40,
                ),

                Container(
                  height: 300,
                  width: double.infinity,
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                  ),
                  child: Stack(
                    children: [
                      FlutterLocationPicker(
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
                          controller.latitude.value = pickedData.latLong.latitude.toString();
                          controller.longitude.value = pickedData.latLong.longitude.toString();
                          AppHelperFunction.showSnackBar("Location set successfully");
                        },
                        showContributorBadgeForOSM: true,
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Agne',
                          ),
                          child: AnimatedTextKit(
                            totalRepeatCount: 100,
                            animatedTexts: [
                              TypewriterAnimatedText('Please wait a moment while I fetch a marker 📍.',
                                  textStyle: const TextStyle(color: Colors.red)),
                              TypewriterAnimatedText('If I can not fetch it',
                                  textStyle: const TextStyle(color: Colors.red)),
                              TypewriterAnimatedText('It will refresh the page.',
                                  textStyle: const TextStyle(color: Colors.green)),
                            ],
                            onTap: () {
                              if (kDebugMode) {
                                print("Tap Event");
                              }
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: InkWell(
                          onTap: () {
                            setState(() {});
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 70, left: 10),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)),
                            child: const Icon(
                              Icons.refresh_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
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
