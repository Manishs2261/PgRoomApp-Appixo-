import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/model/other_image_model.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';
import 'package:pgroom/src/view/rent_form_screen/add_image_/controller/controller.dart';

class AddImageScreen extends StatelessWidget {
  AddImageScreen({super.key});

  final imageController = Get.put(AddImageController());
List<OtherImageModel> imageListmodel = [];

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("rebuild => add new image sccreen 🍎");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Room Information"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                        () => imageController.selectedCoverImage.value != ""
                            ? Image(
                                image: FileImage(File(imageController
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

                      // ========for add a image button=========

                      Obx(
                        () => imageController.selectedCoverImage.value != ""
                            ? const Text("")
                            : Positioned(
                                top: 60,
                                left: 80,
                                child: InkWell(
                                  onTap: () {
                                    imageController.addimage.value = true;

                                    imageController
                                        .pickeCoverImageFromGallery();
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 200,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.white)),
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
                        () => imageController.selectedCoverImage.value != ""
                            ? Positioned(
                                right: 1,
                                child: InkWell(
                                  onTap: () {
                                    imageController.addimage.value = false;
                                    imageController.selectedCoverImage.value =
                                        "";
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
                  () => imageController.addimage.value
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
                  " Add a Other images ",
                  style: TextStyle(color: Colors.green),
                ),
                const SizedBox(
                  height: 10,
                ),

                //===========other image container============

                Obx(
                  () => imageController.isBool.value
                      ? Container(
                          padding: const EdgeInsets.all(10),
                          height: 120,
                          width: double.infinity,
                          decoration: const BoxDecoration(),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: imageController.imageFileList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.all(2),
                                  padding: const EdgeInsets.all(1),
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.black26)),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.file(
                                        imageController.imageFileList[index],
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                          top: 1,
                                          right: 1,
                                          child: InkWell(
                                            onTap: () {
                                              imageController.imageFileList
                                                  .removeAt(index);

                                              if (imageController
                                                  .imageFileList.isEmpty) {
                                                imageController.isBool.value =
                                                    false;
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
                        imageController.pickeImageFromGallery();
                        imageController.isBool.value = true;
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
                      onPressed: () {
                        imageController.onSubmitButton();
                      },
                      child:Obx(
                            () => (imageController.loading.value)
                            ? const CircularProgressIndicator(
                          color: Colors.blue,
                        )
                            : const Text("Save & Next"),
                      )
                  ),
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
