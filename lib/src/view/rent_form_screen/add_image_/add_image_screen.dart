import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/model/other_image_model.dart';
import 'package:pgroom/src/uitels/Constants/image_string.dart';
import 'package:pgroom/src/uitels/Constants/sizes.dart';
import 'package:pgroom/src/uitels/helpers/heiper_function.dart';
import 'package:pgroom/src/uitels/logger/logger.dart';
import 'package:pgroom/src/view/rent_form_screen/add_image_/controller/controller.dart';

class AddImageScreen extends StatelessWidget {
  AddImageScreen({super.key});

  final imageController = Get.put(AddImageController());
  List<OtherImageModel> listModel = [];

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - AddImageScreen ");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Room Cover Image"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: AppSizes.spaceBtwSSections,
                ),

                const Text(
                  "This Image show in your Cover page",
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

                  //======== cover image=================
                  child: Stack(
                    children: [
                      // =====for initial image when your don't choose image============
                      Obx(
                        () => imageController.selectedCoverImage.value != ""
                            ? Image(
                                image: FileImage(File(imageController.selectedCoverImage.value.toString())),
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

                      // ========for add a image button=========

                      Obx(
                        () => Visibility(
                          visible: (imageController.selectedCoverImage.value == ""),
                          child: Positioned(
                            top: 60,
                            left: 80,
                            child: InkWell(
                              onTap: () {
                                imageController.pickCoverImageFromGallery();
                              },
                              child: Container(
                                height: 60,
                                width: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(border: Border.all(color: Colors.white)),
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
                            visible: (imageController.selectedCoverImage.value != ""),
                            child: Positioned(
                                right: 7,
                                top: 7,
                                child: InkWell(
                                  onTap: () {
                                    imageController.selectedCoverImage.value = "";
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
                  height: 80,
                ),

                //=========save & next button ===============
                Obx(
                  () => SizedBox(
                      width: AppHelperFunction.screenWidth() * 0.9,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          imageController.onSubmitButton();
                        },
                        child: (imageController.loading.value)
                            ? const CircularProgressIndicator(
                                strokeWidth: 3.0,
                              )
                            : const Text("Next"),
                      )),
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
