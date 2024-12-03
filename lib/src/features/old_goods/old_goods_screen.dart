import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/apis.dart';
import 'package:pgroom/src/features/old_goods/widgets/app_bar.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';

import '../../data/repository/auth_apis/auth_apis.dart';
import '../../model/old_goods_model/old_goods_model.dart';
import '../../utils/Constants/colors.dart';
import '../../utils/Constants/image_string.dart';
import '../../utils/device/device_utility.dart';
import '../../utils/helpers/helper_function.dart';

// ignore: must_be_immutable
class OldGoodsScreen extends StatelessWidget {
  OldGoodsScreen({super.key});

  List<OldGoodsModel> oldGoodsList = [];
  // ignore: prefer_typing_uninitialized_variables
  var snapData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(108),
          child: Column(
            children: [
              const AppBarOldGoodsWidgets(),
              Container(
                color: AppColors.primary,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 5,
                  ),
                  child: TextFormField(
                    onTap: () {
                      Get.toNamed(RoutesName.goodsSearchScreen, arguments: {
                        'list': oldGoodsList,
                        'id': snapData,
                      });
                    },
                    autofocus: false,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      fillColor: Colors.yellow[50],
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter Service / Landmark / Colony",
                      hintStyle: const TextStyle(color: Colors.black54),
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: const Icon(Icons.mic),
                      isDense: true,
                      contentPadding: const EdgeInsets.only(bottom: 5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: StreamBuilder(
            stream: ApisClass.firebaseFirestore.collection('oldGoods').snapshots(),
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

                  snapData = snapshot;
                  oldGoodsList = data?.map((e) => OldGoodsModel.fromJson(e.data())).toList() ?? [];

                  return ListView.builder(
                      itemCount: oldGoodsList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(RoutesName.oldGoodsDetailsScreen, arguments: {
                              'list': oldGoodsList[index],
                              'id': snapshot.data?.docs[index].id,
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                                height: 360,
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(color: Colors.black.withOpacity(.7), offset: const Offset(2, 4))
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
                                            imageUrl: oldGoodsList[index].image.toString(),
                                            width: double.infinity,
                                            height: 250,
                                            fit: BoxFit.fill,
                                            placeholder: (context, url) => Container(
                                              color: Colors.transparent,
                                              width: double.infinity,
                                              height: 200,
                                              child: const SpinKitFadingCircle(
                                                color: Colors.white,
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
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5, top: 3),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    "${oldGoodsList[index].name}",
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
                                                      image: AssetImage(AppImage.goodsIcon),
                                                      width: 17,
                                                      height: 17,
                                                      color: Colors.white,
                                                    ),
                                                    const Gap(8),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 5, right: 30),
                                                      child: Text(
                                                        "₹${oldGoodsList[index].price}/-",
                                                        overflow: TextOverflow.ellipsis,
                                                        softWrap: false,
                                                        maxLines: 1,
                                                        style: const TextStyle(color: Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5, left: 5),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.location_on,
                                                            color: Colors.white,
                                                            size: 18,
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              " ${oldGoodsList[index].address}",
                                                              softWrap: false,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: const TextStyle(color: Colors.white),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Gap(5),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.date_range_outlined,
                                                            color: Colors.white,
                                                            size: 18,
                                                          ),
                                                          Text(
                                                            " ${oldGoodsList[index].postDate}",
                                                            softWrap: false,
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(color: Colors.white),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    AppHelperFunction.checkInternetAvailability().then((value) {
                                                      if (value) {
                                                        AuthApisClass.checkUserLogin().then((value) {
                                                          if (value) {
                                                            AppDeviceUtils.launchUrl("${Uri(
                                                              scheme: 'tel',
                                                              path: oldGoodsList[index].contactNumber,
                                                            )}");
                                                          }
                                                        });
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(10),
                                                          border: Border.all(color: Colors.blue, width: 2)),
                                                      child: const Text(
                                                        "Call Now",
                                                        style:
                                                            TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
                                                      )),
                                                ),
                                                const Gap(25)
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
            }));
  }
}
