import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../data/repository/auth_apis/auth_apis.dart';
import '../../../model/old_goods_model/old_goods_model.dart';
import '../../../model/tiffin_services_model/tiffen_services_model.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../utils/Constants/colors.dart';
import '../../../utils/Constants/image_string.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_function.dart';

class GoodsSearchScreen extends StatefulWidget {
  const GoodsSearchScreen({super.key});

  @override
  State<GoodsSearchScreen> createState() => _GoodsSearchScreenState();
}

class _GoodsSearchScreenState extends State<GoodsSearchScreen> {
  final searchController = TextEditingController();
  List<OldGoodsModel> data = Get.arguments['list'];
  var snapData = Get.arguments['id'];

  List<OldGoodsModel> displayList = [];

  void updateList(String value) {
    setState(() {
      displayList = data
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()) ||
              element.address!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });

    if (value == "") {
      setState(() {
        displayList = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build -SearchTiffineScreen  ");

    return SafeArea(
      top: true,
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
              child: TextField(
                  controller: searchController,
                  maxLines: 1,
                  autofocus: true,
                  minLines: 1,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => updateList(value),
                  onSubmitted: (value) {},
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter Service Name/Landmark/Colony",
                    hintStyle: const TextStyle(color: Colors.black54),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      size: 25,
                    ),
                    suffixIcon: const Icon(
                      Icons.mic,
                      size: 25,
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.only(
                      bottom: 5,
                    ), // Added this
                  )),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: displayList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        final itemId = snapData.data?.docs[index].id;
                        Get.toNamed(RoutesName.oldGoodsDetailsScreen, arguments: {
                          'list': displayList[index],
                          'id': itemId,
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                            height: 360,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(.7), offset: const Offset(2, 4))],
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
                                        imageUrl: displayList[index].image.toString(),
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
                                                "${displayList[index].name}",
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
                                                    "₹${displayList[index].price}/-",
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
                                                          " ${displayList[index].address}",
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
                                                        " ${displayList[index].postDate}",
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
                                                          path: displayList[index].contactNumber,
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
                                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
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
                  }),
            )
          ],
        ),
      ),
    );
  }
}
