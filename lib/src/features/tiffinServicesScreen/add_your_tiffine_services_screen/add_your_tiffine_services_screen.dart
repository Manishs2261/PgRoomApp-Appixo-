import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/data/repository/apis/tiffine_services_api.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

import '../../../data/repository/apis/apis.dart';
import '../../../model/tiffin_services_model/tiffen_services_model.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../utils/Constants/colors.dart';
import '../data_save_tiffin_screen/data_save_tiffin_screen.dart';

class AddYourTiffineServicesScreen extends StatelessWidget {
  AddYourTiffineServicesScreen({super.key});

  List<TiffineServicesModel> tiffineList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            ComReuseElevButton(
                onPressed: () {
                  Get.to(() => const DataSaveTiffineScreen());
                },
                title: "Add your Tiffine Services"),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: ApisClass.firebaseFirestore
                      .collection('userTiffineCollection')
                      .doc(ApisClass.user.uid)
                      .collection(ApisClass.user.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
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
                      case ConnectionState.none:
                        return const Center(
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

                        // for(var i in data!)
                        //   {
                        //     log("Data : ${jsonEncode(i.data())}");
                        //   }

                        tiffineList = data?.map((e) => TiffineServicesModel.fromJson(e.data())).toList() ?? [];

                        return ListView.builder(
                            itemCount: tiffineList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: tiffineList[index].foodImage.toString(),
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) => Container(
                                      color: Colors.transparent,
                                      width: double.infinity,
                                      height: 200,
                                      child: const SpinKitFadingCircle(
                                        color: AppColors.primary,
                                        size: 35,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                      width: double.infinity,
                                      height: 200,
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.food_bank,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5, top: 3),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${tiffineList[index].servicesName}",
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 1,
                                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "${tiffineList[index].averageRating}",
                                              style: const TextStyle(fontSize: 17),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text("(${tiffineList[index].numberOfRating} Ratings)"),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "Address :- ${tiffineList[index].address}",
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "Contact Number :- ${tiffineList[index].contactNumber}",
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [Text("Stating Price :- ${tiffineList[index].foodPrice} ₹ day/- ")],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                Get.toNamed(RoutesName.etidTiffineScreen, arguments: {
                                                  'list': tiffineList[index],
                                                  'id': snapshot.data?.docs[index].id,
                                                });
                                              },
                                              child: const Text(
                                                "Edit",
                                                style: TextStyle(color: Colors.blueAccent),
                                              ),
                                            ),
                                            OutlinedButton(
                                              onPressed: () {
                                                AppHelperFunction.showAlert(
                                                    "Delete",
                                                    "Are you sure delete this item?"
                                                        ".", () {
                                                  AppHelperFunction.checkInternetAvailability().then((value) {
                                                    if (value) {
                                                      AppHelperFunction.showDialogCenter(false);
                                                      TiffineServicesApis.deleteTiffineServicesData(
                                                              snapshot.data!.docs[index].id,
                                                              tiffineList[index].foodImage,
                                                              tiffineList[index].menuImage)
                                                          .then((value) {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      });
                                                    }
                                                  });
                                                });
                                              },
                                              child: const Text(
                                                "Delete",
                                                style: TextStyle(color: Colors.blueAccent),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ));
                            });
                    }
                  }),
            ),
          ],
        ));
  }
}
