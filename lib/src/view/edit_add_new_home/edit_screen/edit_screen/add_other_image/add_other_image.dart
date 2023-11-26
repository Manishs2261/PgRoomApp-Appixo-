import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import '../../../../../model/other_image_model.dart';
import '../../../../../repositiry/apis/apis.dart';
import '../../../../../utils/Constants/colors.dart';
import 'controller/controller.dart';

class EditOtherImageScreen extends StatelessWidget {
  EditOtherImageScreen({super.key});

  final controller = Get.put(EditOtherImageController(Get.arguments['id']));

  final itemId = Get.arguments['id'];
  List<OtherImageModel> rentList = [];

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - EditOtherImageScreen ");
    final dark = AppHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Other Images"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => controller.isBool.value
                    ? Container(
                        padding: const EdgeInsets.all(2),
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(border: Border.all(color: dark ? Colors.white24 : Colors.black26)),
                        child: ListView.builder(
                            addAutomaticKeepAlives: false,
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.imageFileList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(2),
                                padding: const EdgeInsets.all(1),
                                height: 100,
                                width: 200,
                                decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
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
                                            controller.imageFileList.removeAt(index);
                                            if (controller.imageFileList.isEmpty) {
                                              controller.isBool.value = false;
                                            }
                                          },
                                          child: CircleAvatar(
                                              radius: 17,
                                              backgroundColor: dark ? Colors.white38 : Colors.black26,
                                              child: const Icon(
                                                Icons.close,
                                                size: 22,
                                                color: Colors.white,
                                              )),
                                        ))
                                  ],
                                ),
                              );
                            }),
                      )
                    //if image not choose than default display
                    : Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          color: dark ? Colors.blueGrey.shade900 : Colors.grey.shade200,
                        ),
                        child: const Icon(
                          Icons.image_outlined,
                          size: 70,
                        ),
                      ),
              ),

              const SizedBox(
                height: 50,
              ),

              //=============choose Image  button ===========
              Obx(
                () => Center(
                  child: SizedBox(
                    height: 40,
                    width: AppHelperFunction.screenWidth() * 0.9,
                    child: ElevatedButton(
                        onPressed: () {
                          controller.onChooseUploadOtherImage();
                        },
                        child: (controller.loading.value)
                            ? const CircularProgressIndicator(
                                strokeWidth: 3.0,
                              )
                            : const Text("Choose image")),
                  ),
                ),
              ),

              const SizedBox(
                height: 60,
              ),

              //view all image List

              Obx(
                () => Visibility(
                  visible: controller.containerShow.value,
                  child: SizedBox(
                    height: 200.0 + 200 * controller.containerHeight.value,
                    width: double.infinity,
                    child: StreamBuilder(
                        stream:
                            ApisClass.firestore.collection("OtherImageList").doc(itemId).collection(itemId).snapshots(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.signal_wifi_connected_no_internet_4),
                                    Text("No Internet Connection"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CircularProgressIndicator(
                                      color: Colors.blue,
                                    )
                                  ],
                                ),
                              );

                            case ConnectionState.active:
                            case ConnectionState.done:
                              final data = snapshot.data?.docs;

                              rentList = data?.map((e) => OtherImageModel.fromJson(e.data())).toList() ?? [];
                              if (rentList.isNotEmpty) {
                                Future.delayed(Duration.zero, () {
                                  controller.containerHeight.value = rentList.length;
                                });
                              }

                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const ScrollPhysics(),
                                itemCount: rentList.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: SizedBox(
                                      height: 150,
                                      width: 250,
                                      child: Stack(
                                        fit: StackFit.loose,
                                        children: [
                                          CachedNetworkImage(
                                              width: 250,
                                              height: 200,
                                              imageUrl: rentList[index].OtherImage.toString(),
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
                                                    width: 250,
                                                    height: 200,
                                                    alignment: Alignment.center,
                                                    child: const Icon(
                                                      Icons.image_outlined,
                                                      size: 50,
                                                    ),
                                                  )),
                                          Positioned(
                                              top: 1,
                                              right: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  final imageId = snapshot.data!.docs[index].id;
                                                  final imageUrl = rentList[index].OtherImage;
                                                  controller.onDeleteButton( imageId, itemId, imageUrl!);
                                                },
                                                child: CircleAvatar(
                                                    radius: 18,
                                                    backgroundColor: Colors.red[500],
                                                    child: const Icon(
                                                      Icons.delete,
                                                      size: 22,
                                                      color: Colors.white,
                                                    )),
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                          }
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
