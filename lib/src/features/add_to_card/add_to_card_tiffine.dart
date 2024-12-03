// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/apis.dart';
import '../../data/repository/apis/add_to_cart_api.dart';
import '../../model/tiffin_services_model/tiffen_services_model.dart';
import '../../res/route_name/routes_name.dart';
import '../../utils/Constants/colors.dart';
import '../../utils/Constants/image_string.dart';
import '../../utils/helpers/helper_function.dart';

// ignore: must_be_immutable
class AddToCartTiffineScreen extends StatelessWidget {
  AddToCartTiffineScreen({super.key});

  List<TiffineServicesModel> tiffineList = [];
  var snapData;

  @override
  Widget build(BuildContext context) {
    AppHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add to card"),
      ),
      body: StreamBuilder(
          stream: ApisClass.firebaseFirestore
              .collection("loginUser")
              .doc(ApisClass.user.uid)
              .collection(ApisClass.auth.currentUser!.uid)
              .doc(ApisClass.user.uid)
              .collection('addToCartFoods')
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

                snapData = snapshot;
                tiffineList = data?.map((e) => TiffineServicesModel.fromJson(e.data())).toList() ?? [];

                return ListView.builder(
                    itemCount: tiffineList.length,
                    itemBuilder: (context, index) {
                      final itemId = snapshot.data?.docs[index].id;
                      return InkWell(
                        onTap: () {
                          Get.toNamed(RoutesName.tiffinDetailsScreen, arguments: {
                            'list': tiffineList[index],
                            'id': snapshot.data?.docs[index].id,
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                              height: 335,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(.8),
                                      spreadRadius: 0.5,
                                      blurRadius: .1,
                                      offset: const Offset(0, 5))
                                ],
                                color: Colors.black.withOpacity(.9),
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: CachedNetworkImage(
                                          imageUrl: tiffineList[index].foodImage.toString(),
                                          width: double.infinity,
                                          height: 250,
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
                                      ),
                                      Positioned(
                                          right: 10,
                                          top: 10,
                                          child: InkWell(
                                            onTap: () {
                                              AddToCartApis.deleteAddToCarTiffineData(itemId);
                                            },
                                            child: const CircleAvatar(
                                              radius: 17,
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              ),
                                            ),
                                          )),
                                      Container(
                                        margin: const EdgeInsets.only(top: 8, left: 8),
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              size: 18,
                                              color: Colors.orange,
                                            ),
                                            const Gap(8),
                                            Flexible(
                                              child: Text(
                                                "${tiffineList[index].averageRating}  ",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5, top: 3),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  "${tiffineList[index].servicesName}",
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                                                ),
                                              ),
                                              const Gap(10),
                                              Row(
                                                children: [
                                                  const Image(
                                                    image: AssetImage(AppImage.foodIcon),
                                                    width: 20,
                                                    height: 20,
                                                    color: Colors.white,
                                                  ),
                                                  const Gap(8),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      "₹${tiffineList[index].foodPrice}/Month",
                                                      overflow: TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      maxLines: 1,
                                                      style: const TextStyle(color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.location_on,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        " ${tiffineList[index].address}",
                                                        softWrap: false,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(color: Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Gap(20),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(color: Colors.blue, width: 2)),
                                                    child: const Text(
                                                      "Call Now",
                                                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
                                                    )),
                                              ),
                                              const Gap(20),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      );
                    });
            }
          }),
    );
  }
}
