import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/model/other_image_model.dart';
import 'package:pgroom/src/utils/Constants/image_string.dart';
import 'package:pgroom/src/utils/Constants/sizes.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'controller/controller.dart';

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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),

                  //======== cover image=================
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // =====for initial image when your don't choose image============
                      Obx(
                        () => imageController.selectedCoverImage.value != ""
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Image(
                                  image: FileImage(File(imageController.selectedCoverImage.value.toString())),
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: const Image(
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
                          visible: (imageController.selectedCoverImage.value == ""),
                          child: InkWell(
                            onTap: () {
                              imageController.pickCoverImageFromGallery();
                            },
                            child: Container(
                              height: 60,
                              width: 250,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.8),
                                  borderRadius: BorderRadius.circular(20),
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

                ReuseElevButton(
                  onPressed: () => imageController.onSubmitButton(),
                  title: "Next",
                  loading: imageController.loading.value,
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
