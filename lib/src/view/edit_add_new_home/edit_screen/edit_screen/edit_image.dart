import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../model/user_rent_model/user_rent_model.dart';
import '../../../../uitels/image_string/image_string.dart';
import '../controller/controller.dart';

class EditImageScreen extends StatelessWidget {
  EditImageScreen({super.key});

  final itemId = Get.arguments["id"];
  final UserRentModel data = Get.arguments['list'];

  final controller = Get.put(
      EditFormScreenController(Get.arguments['list'], Get.arguments["id"]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Image"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Please complete the following information exactly as it appears in your rental contract",
                style: TextStyle(color: Colors.orange),
              ),
              const SizedBox(
                height: 20,
              ),

              const Text(
                "This Image show in your front page",
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
                      () => controller.selectedImage.value
                          ? Image(
                              image: NetworkImage(
                                  controller.selectedCoverImage.value),
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Obx(
                              () => controller.selectedCoverImage.value != ""
                                  ? Image(
                                      image: FileImage(File(controller
                                          .selectedCoverImage.value
                                          .toString())),
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : const Image(
                                      image: AssetImage(roomImage),
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                    ),

                    // ========for add a image button=========

                    Obx(
                      () => controller.selectedCoverImage.value != ""
                          ? const Text("")
                          : Positioned(
                              top: 60,
                              left: 80,
                              child: InkWell(
                                onTap: () {
                                  controller.addimage.value = true;

                                  controller.pickeCoverImageFromGallery();
                                },
                                child: Container(
                                  height: 60,
                                  width: 200,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white)),
                                  child: const Text(
                                    "Choose cover Image",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                    ),

                    //==========for delete  Cover image a image===========
                    Obx(
                      () => controller.selectedCoverImage.value != ""
                          ? Positioned(
                              right: 1,
                              child: InkWell(
                                onTap: () {
                                  controller.addimage.value = false;
                                  controller.selectedCoverImage.value = "";
                                  controller.selectedImage.value = false;
                                },
                                child: const CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.black26,
                                  child: Text(
                                    "X",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ))
                          : const Text(""),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //when a upload image show successful sign

              Obx(
                () => controller.addimage.value
                    ? const Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 7)),
                          Text(
                            "Add",
                            style: TextStyle(color: Colors.green),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.verified,
                            color: Colors.green,
                            size: 20,
                          )
                        ],
                      )
                    : const Text(""),
              ),

              const SizedBox(
                height: 20,
              ),

              const Text(
                " Add a Othe images ",
                style: TextStyle(color: Colors.green),
              ),
              const SizedBox(
                height: 10,
              ),

              //===========other image container============

              Obx(
                () => controller.isBool.value
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        height: 120,
                        width: double.infinity,
                        decoration: const BoxDecoration(),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.imageFileList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(2),
                                padding: const EdgeInsets.all(1),
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black26)),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.file(
                                      controller.imageFileList[index],
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                        top: 1,
                                        right: 1,
                                        child: InkWell(
                                          onTap: () {
                                            controller.imageFileList
                                                .removeAt(index);

                                            if (controller
                                                .imageFileList.isEmpty) {
                                              controller.isBool.value = false;
                                            }
                                          },
                                          child: const CircleAvatar(
                                              radius: 11,
                                              backgroundColor: Colors.black26,
                                              child: Icon(
                                                Icons.close,
                                                size: 18,
                                                color: Colors.white,
                                              )),
                                        ))
                                  ],
                                ),
                              );
                            }),
                      )
                    : Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                        ),
                        child: const Icon(
                          Icons.image_outlined,
                          size: 50,
                        ),
                      ),
              ),

              const SizedBox(
                height: 10,
              ),

              //=============choose button ===========
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      controller.pickeImageFromGallery();
                      controller.isBool.value = true;
                    },
                    child: const Text("Chosse image")),
              ),

              const SizedBox(
                height: 60,
              ),

              //=========save & next button ===============
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      controller.EditImage().then((value) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }).onError((error, stackTrace) {
                        Get.snackbar("Error", "Image upadte ");
                        print(error);
                        print(stackTrace);
                      });
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
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
