import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/apis.dart';
import '../../data/repository/apis/add_to_cart_api.dart';
import '../../model/old_goods_model/old_goods_model.dart';
import '../../res/route_name/routes_name.dart';
import '../../utils/Constants/colors.dart';
import '../../utils/Constants/image_string.dart';
import '../../utils/helpers/helper_function.dart';

// ignore: must_be_immutable
class AddToCartGoodsScreen extends StatelessWidget {
  AddToCartGoodsScreen({super.key});

  List<OldGoodsModel> oldGoodsList = [];
  // ignore: prefer_typing_uninitialized_variables
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
              .collection('addToCartGoods')
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
                oldGoodsList = data?.map((e) => OldGoodsModel.fromJson(e.data())).toList() ?? [];
                return ListView.builder(
                    itemCount: oldGoodsList.length,
                    itemBuilder: (context, index) {
                      final itemId = snapshot.data?.docs[index].id;

                      return InkWell(
                        onTap: () {
                          Get.toNamed(RoutesName.oldGoodsDetailsScreen, arguments: {
                            'list': oldGoodsList[index],
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
                                          imageUrl: oldGoodsList[index].image.toString(),
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
                                              AddToCartApis.deleteAddToCarGoodsData(itemId);
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
                                                onTap: () {},
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
                    });
            }
          }),
    );
  }
}
