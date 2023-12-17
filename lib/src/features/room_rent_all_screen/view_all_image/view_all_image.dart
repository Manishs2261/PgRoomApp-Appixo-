import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
 import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../data/repository/apis/apis.dart';
import '../../../model/other_image_model.dart';
import '../../../utils/Constants/colors.dart';


class ViewAllImage extends StatelessWidget {
  ViewAllImage({super.key});

  List<OtherImageModel> rentList = [];
  final itemId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build -  ViewAllImage ");
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Image"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: StreamBuilder(
            stream: ApisClass.firebaseFirestore.collection("OtherImageList").doc(itemId).collection(itemId).snapshots(),
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

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: rentList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          //On Tap full screen Image viewer
                          showImageViewer(
                            context,
                            Image.network(rentList[index].OtherImage.toString()).image,
                            swipeDismissible: true,
                            doubleTapZoomable: true,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CachedNetworkImage(
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
                                    width: 150,
                                    height: 280,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.image_outlined,
                                      size: 50,
                                    ),
                                  )),
                        ),
                      );
                    },
                  );
              }
            }),
      ),
    );
  }
}
