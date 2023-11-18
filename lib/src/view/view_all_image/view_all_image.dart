import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';

import '../../model/other_image_model.dart';

class ViewAllImage extends StatelessWidget {
  ViewAllImage({super.key});

  List<OtherImageModel> rentList = [];
  final itemId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print("Build View all image screen🚙");

    return Scaffold(
      appBar: AppBar(
        title: Text("image"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: StreamBuilder(
            stream: ApisClass.firestore.collection("OtherImageList")
                .doc(itemId).collection(itemId).snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
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
                case ConnectionState.none:
                  return Center(
                    child: Row(
                      children: [
                        Icon(Icons.signal_wifi_connected_no_internet_4),
                        Text("No Internet Connection"),
                        CircularProgressIndicator(
                          color: Colors.blue,
                        )
                      ],
                    ),
                  );

                case ConnectionState.active:
                case ConnectionState.done:
                  final data = snapshot.data?.docs;

                  rentList = data
                          ?.map((e) => OtherImageModel.fromJson(e.data()))
                          .toList() ??
                      [];

                  return ListView.builder(
                    itemCount: rentList.length,

                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CachedNetworkImage(
                          width: 150,
                          height: 200,
                          imageUrl: '${rentList[index].OtherImage}',
                          fit: BoxFit.fill,
                          // placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => CircleAvatar(
                            child: Icon(Icons.image_outlined),
                          ),
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
