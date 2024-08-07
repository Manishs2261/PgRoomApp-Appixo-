import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import '../../../common/widgets/com_reuse_elevated_button.dart';
import '../../../utils/Constants/colors.dart';
import '../../../utils/Constants/image_string.dart';
import '../../../utils/validator/text_field_validator.dart';
import '../../../utils/widgets/my_text_form_field.dart';
import 'controller/controller.dart';

class EditTiffineScreen extends StatefulWidget {
  const EditTiffineScreen({super.key});

  @override
  State<EditTiffineScreen> createState() => _EditTiffineScreenState();
}

class _EditTiffineScreenState extends State<EditTiffineScreen> {
  final controller = Get.put(EditTiffineScreenController(Get.arguments['id'], Get.arguments['list']));

  final data = Get.arguments['list'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Tiffine Services"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Column(
                  children: [
                    const Text(
                      "This Image show in your Cover page",
                      style: TextStyle(color: Colors.green, fontSize: 18),
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

                      //======== cover image=================
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // =====for initial image when your don't choose image============
                          Obx(
                            () => (controller.isSelectedCoverImage.value)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                        height: double.infinity,
                                        width: double.infinity,
                                        imageUrl: controller.selectedCoverImage.toString(),
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) => Container(
                                              color: Colors.transparent,
                                              height: 100,
                                              width: 100,
                                              child: const SpinKitFadingCircle(
                                                color: AppColors.primary,
                                                size: 35,
                                              ),
                                            ),
                                        errorWidget: (context, url, error) => Container(
                                              width: 150,
                                              height: 280,
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.image_outlined,
                                                size: 50,
                                              ),
                                            )),
                                  )
                                : Obx(
                                    () => controller.selectedCoverImage.value != ""
                                        ? Image(
                                            image: FileImage(File(controller.selectedCoverImage.value.toString())),
                                            height: double.infinity,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          )
                                        : const Image(
                                            image: AssetImage(AppImage.roomImage),
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
                                  AppHelperFunction.checkInternetAvailability().then((value) {
                                    if (value) {
                                      controller.pickCoverImageFromGallery();
                                    }
                                  });
                                },
                                child: Container(
                                  height: 60,
                                  width: 200,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: Colors.black.withOpacity(.7),
                                      border: Border.all(color: Colors.white)),
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
                                        controller.isSelectedCoverImage.value = false;
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
                      "Choose the Menu Image",
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    //========stack container ============
                    Container(
                      alignment: Alignment.center,
                      height: 180,
                      width: 300,

                      //======== cover image=================
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // =====for initial image when your don't choose image============

                          Obx(
                            () => (controller.isSelectedMenuImage.value)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                        height: double.infinity,
                                        width: double.infinity,
                                        imageUrl: controller.selectedMenuImage.value,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) => Container(
                                              color: Colors.transparent,
                                              height: 100,
                                              width: 100,
                                              child: const SpinKitFadingCircle(
                                                color: AppColors.primary,
                                                size: 35,
                                              ),
                                            ),
                                        errorWidget: (context, url, error) => Container(
                                              width: 150,
                                              height: 280,
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.image_outlined,
                                                size: 50,
                                              ),
                                            )),
                                  )
                                : Obx(
                                    () => controller.selectedMenuImage.value != ""
                                        ? Image(
                                            image: FileImage(File(controller.selectedMenuImage.value.toString())),
                                            height: double.infinity,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          )
                                        : const Image(
                                            image: AssetImage(AppImage.roomImage),
                                            height: double.infinity,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                          ),

                          // ========for add a image button=========

                          Obx(
                            () => Visibility(
                              visible: (controller.selectedMenuImage.value == ""),
                              child: InkWell(
                                onTap: () {
                                  AppHelperFunction.checkInternetAvailability().then((value) {
                                    if (value) {
                                      controller.pickMenuImageFromGallery();
                                    }
                                  });
                                },
                                child: Container(
                                  height: 60,
                                  width: 220,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: Colors.black.withOpacity(.7),
                                      border: Border.all(color: Colors.white)),
                                  child: const Text(
                                    "Choose Menu Image",
                                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
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
                                        controller.isSelectedMenuImage.value = false;
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
                            ]),
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
                          textKeyBoard: TextInputType.number,
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
                          hintText: "Enter Price according day  ",
                          labelText: 'Price day',
                          icon: const Icon(Icons.currency_rupee),
                          borderRadius: BorderRadius.circular(11),
                          contentPadding: const EdgeInsets.only(top: 5, left: 10),
                          validator: NameValidator.validate,
                          textKeyBoard: TextInputType.number,
                          maxLength: 6,
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
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
                  title: "Update",
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
