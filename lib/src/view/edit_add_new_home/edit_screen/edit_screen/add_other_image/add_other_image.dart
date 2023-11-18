import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../model/other_image_model.dart';
import '../../../../../repositiry/apis/apis.dart';
import 'controller/controller.dart';

class EditOtherImageScreen extends StatelessWidget {
  EditOtherImageScreen({super.key});

  final controller = Get.put(EditOtherImageController(Get.arguments['id']));

  final itemId = Get.arguments['id'];
  List<OtherImageModel> rentList = [];

  @override
  Widget build(BuildContext context) {
    print(itemId);
    print("Build +> Edit Other screen 🍒");
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Other Image jfg "),
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
                        decoration: const BoxDecoration(),
                        child: ListView.builder(
                            addAutomaticKeepAlives: false,
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.imageFileList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(2),
                                padding: const EdgeInsets.all(1),
                                height: 100,
                                width: 200,
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
                        height: 200,
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
                height: 50,
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

              Obx(
                () => (controller.contianShow.value)
                    ? Container(
                        height: 200.0 + 200 * controller.containerHeight.value,
                        width: double.infinity,
                        child: StreamBuilder(
                            stream: ApisClass.firestore
                                .collection("OtherImageList")
                                .doc(itemId)
                                .collection(itemId)
                                .snapshots(),
                            builder: (context, snapshot) {
                              print("connection");
                              print(snapshot.connectionState);
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                case ConnectionState.none:
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons
                                            .signal_wifi_connected_no_internet_4),
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

                                  print(data);
                                  rentList = data
                                          ?.map((e) => OtherImageModel.fromJson(
                                              e.data()))
                                          .toList() ??
                                      [];
                                  if (rentList.length > 0) {
                                    Future.delayed(Duration.zero, () {
                                      controller.containerHeight.value =
                                          rentList.length;
                                    });
                                  }

                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    physics: const ScrollPhysics(),
                                    itemCount: rentList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          height: 150,
                                          width: 250,
                                          child: Stack(
                                            fit: StackFit.loose,
                                            children: [
                                              CachedNetworkImage(
                                                width: 250,
                                                height: 200,
                                                imageUrl:
                                                    '${rentList[index].OtherImage}',
                                                fit: BoxFit.fill,
                                                // placeholder: (context, url) => CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        CircleAvatar(
                                                  child: Icon(
                                                      Icons.image_outlined),
                                                ),
                                              ),
                                              Positioned(
                                                  top: 1,
                                                  right: 1,
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: CircleAvatar(
                                                        radius: 18,
                                                        backgroundColor:
                                                            Colors.red[500],
                                                        child: Icon(
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
                      )
                    : Text(""),
              )
            ],
          ),
        ),
      ),
    );
  }
}
