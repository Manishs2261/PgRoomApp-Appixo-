import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/utils/Constants/sizes.dart';
 import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../../../model/user_rent_model/user_rent_model.dart';
import '../../../../../utils/Constants/colors.dart';
import '../../../../../utils/Constants/image_string.dart';
import '../controller/controller.dart';

class EditCoverImageScreen extends StatelessWidget {
  EditCoverImageScreen({super.key});

  final itemId = Get.arguments["id"];
  final UserRentModel data = Get.arguments['list'];
  final controller = Get.put(EditFormScreenController(Get.arguments['list'], Get.arguments["id"]));

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build -EditCoverImageScreen ");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Cover Image"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "This Image show in your Cover page",
                style: TextStyle(color: Colors.green),
              ),
              const SizedBox(
                height: AppSizes.defaultSpace,
              ),

              //========stack container ============
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
                      () => controller.selectedImage.value
                          //Display in your data base fetch image
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                  height: double.infinity,
                                  width: double.infinity,
                                  imageUrl: controller.data.coverImage.toString(),
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
                                  //Display file choose image
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image(
                                        image: FileImage(File(controller.selectedCoverImage.value.toString())),
                                        height: double.infinity,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  //Display default image
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: const Image(
                                        image: AssetImage(AppImage.roomImage),
                                        height: double.infinity,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                    ),

                    // ========for Choose a image button=========

                    Obx(
                      () => Visibility(
                        visible: controller.selectedCoverImage.value == "",
                        child: InkWell(
                          onTap: () {
                            controller.pickCoverImageFromGallery();
                          },
                          child: Container(
                            height: 60,
                            width: 200,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.black.withOpacity(.6),
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
                    Obx(
                      () => Visibility(
                        visible: controller.selectedCoverImage.value != "",
                        child: Positioned(
                            top: 7,
                            right: 7,
                            child: InkWell(
                              onTap: () {
                                controller.addImage.value = true;
                                controller.selectedCoverImage.value = "";
                                controller.selectedImage.value = false;
                              },
                              child: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  )),
                            )),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 80,
              ),

              //=========save & next button ===============
              Obx(
                () => Visibility(
                  visible: controller.addImage.value,
                  child: Opacity(
                    opacity: (controller.selectedCoverImage.value != "") ? 1 : 0.5,
                    child: IgnorePointer(
                      ignoring: (controller.selectedCoverImage.value == ""),
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ReuseElevButton(
                            onPressed: () => controller.onEditCoverImageSaveButton(), title: "Update"),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
