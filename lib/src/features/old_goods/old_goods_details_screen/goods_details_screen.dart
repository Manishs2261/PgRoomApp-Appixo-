import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/model/old_goods_model/old_goods_model.dart';
import '../../../data/repository/auth_apis/auth_apis.dart';
import '../../../utils/Constants/colors.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../../utils/logger/logger.dart';

class GoodsDetailsScreen extends StatefulWidget {
  GoodsDetailsScreen({super.key});

  @override
  State<GoodsDetailsScreen> createState() => _GoodsDetailsScreenState();
}

class _GoodsDetailsScreenState extends State<GoodsDetailsScreen> {
  final OldGoodsModel list = Get.arguments['list'];

  var index = Get.arguments["id"];

  onCallNow() {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        AuthApisClass.checkUserLogin().then((value) {
          if (value) {
            AppDeviceUtils.launchUrl("${Uri(
              scheme: 'tel',
              path: list.contactNumber,
            )}");
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - GoodsDetailsScreen");

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => onCallNow(),
                child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: const BoxDecoration(color: AppColors.primary),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.call_outlined,
                          color: Colors.white,
                        ),
                        Gap(10),
                        Text(
                          "Contact Now",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    )),
              ),
            ),
            Expanded(
              child: InkWell(
                hoverColor: Colors.grey,
                // onTap: (){
                //   ApisClass.updateAddToCart(controller.itemId, true);
                //   AppHelperFunction.showSnackBar("successfully added");
                // },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: const BoxDecoration(color: Colors.orange),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_basket_outlined,
                        color: Colors.white,
                      ),
                      Gap(10),
                      Text(
                        "Add to card",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "${list.name}",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, blurRadius: 1, spreadRadius: 2, offset: const Offset(2, 5)),
                ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: CachedNetworkImage(
                    imageUrl: list.image.toString(),
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      height: 300,
                      child: const SpinKitFadingCircle(
                        color: AppColors.primary,
                        size: 35,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: double.infinity,
                      height: 300,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.food_bank,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${list.name}",
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "Price :-  ₹${list.price}/- ",
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Address :- ",
                          style: TextStyle(fontSize: 16),
                        ),
                        Flexible(
                          child: Text(
                            "${list.address}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            softWrap: false,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Post Date :-",
                          style: TextStyle(fontSize: 16),
                        ),
                        Flexible(
                          child: Text(
                            "${list.postDate}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            softWrap: false,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
