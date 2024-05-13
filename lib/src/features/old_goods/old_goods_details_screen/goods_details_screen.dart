import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pgroom/src/features/old_goods/old_goods_details_screen/controller.dart';
import 'package:pgroom/src/model/old_goods_model/old_goods_model.dart';
import 'package:provider/provider.dart';
 import '../../../utils/Constants/colors.dart';
 import '../../../utils/ad_helper/services/ad_services.dart';
import '../../../utils/logger/logger.dart';

class GoodsDetailsScreen extends StatefulWidget {
  GoodsDetailsScreen({super.key});

  @override
  State<GoodsDetailsScreen> createState() => _GoodsDetailsScreenState();
}

class _GoodsDetailsScreenState extends State<GoodsDetailsScreen> {
  final OldGoodsModel list = Get.arguments['list'];

  var itemId = Get.arguments["id"];

  final controller = Get.put(OldGoodsScreenController(Get.arguments["id"],Get.arguments['list']));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {

      AdProvider adProvider = Provider.of<AdProvider>(context, listen: false);

      adProvider.initializeNativeAd();

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
                onTap: () => controller.onCallNow(),
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
                onTap: (){
                  controller.addToCartGoodsData();

                },
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
                        "Add to cart",
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
               Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),


                  Consumer<AdProvider>(builder: (context, adProvider, child) {
                    if (adProvider.isNativeAdLoaded) {
                      return ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 320, // minimum recommended width
                          minHeight: 320, // minimum recommended height
                          maxWidth: 400,
                          maxHeight: 400,
                        ),
                        child:   adProvider.isNativeAdLoaded ? Container(
                          alignment: Alignment.center,
                          child: AdWidget(ad: adProvider.nativeAd),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 20.0),
                          height: 70,
                        ) : CircularProgressIndicator(),
                      );
                    } else {
                      return Container(
                        height: 0,
                      );
                    }
                  }),


                  const SizedBox(
                    height: 100,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
