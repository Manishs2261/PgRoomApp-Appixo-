import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

import '../../../data/repository/apis/apis.dart';
import '../../../data/repository/apis/old_goods_api.dart';
import '../../../model/old_goods_model/old_goods_model.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../utils/Constants/colors.dart';
import '../data_save_goods/data_save_goods_screen.dart';

// ignore: must_be_immutable
class AddYourOldGoodsScreen extends StatelessWidget {
  AddYourOldGoodsScreen({super.key});

  List<OldGoodsModel> goodsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            ReuseElevButton(
                onPressed: () {
                  Get.to(() => const DataSaveGoodsScreen());
                },
                title: "Add your Deal"),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: ApisClass.firebaseFirestore
                      .collection('userOldGoodsList')
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

                        goodsList = data?.map((e) => OldGoodsModel.fromJson(e.data())).toList() ?? [];

                        return ListView.builder(
                            itemCount: goodsList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(24),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(.8),
                                            spreadRadius: 0.5,
                                            blurRadius: .1,
                                            offset: const Offset(0, 5))
                                      ]),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: CachedNetworkImage(
                                          imageUrl: goodsList[index].image.toString(),
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
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5, top: 3),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${goodsList[index].name}",
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              maxLines: 1,
                                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    "Address :- ${goodsList[index].address}",
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
                                                    "Contact Number :- ${goodsList[index].contactNumber}",
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
                                              children: [Text("Price :- ₹${goodsList[index].price}")],
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                OutlinedButton(
                                                  onPressed: () {
                                                    Get.toNamed(RoutesName.editOldGoodsScreen, arguments: {
                                                      'list': goodsList[index],
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
                                                          SellAndBuyApis.deleteOldGoodsData(snapshot.data!.docs[index].id,
                                                                  goodsList[index].image, goodsList[index].image)
                                                              .then((value) {
                                                            // ignore: use_build_context_synchronously
                                                            Navigator.pop(context);
                                                            // ignore: use_build_context_synchronously
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
