import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pgroom/src/features/room_rent_all_screen/details_rent_screen/widget/ContactAndShareWidgets.dart';
import 'package:pgroom/src/features/room_rent_all_screen/details_rent_screen/widget/RatingAndReviewWidgets.dart';
import 'package:pgroom/src/features/room_rent_all_screen/details_rent_screen/widget/all_details_widgets.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/ad_helper/services/ad_services.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../utils/Constants/colors.dart';
import '../../../utils/Constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../../utils/logger/logger.dart';
import 'controller/details_screen_controller.dart';

class DetailsRentInfoScreen extends StatefulWidget {
  const DetailsRentInfoScreen({super.key});

  @override
  State<DetailsRentInfoScreen> createState() => _DetailsRentInfoScreenState();
}

class _DetailsRentInfoScreenState extends State<DetailsRentInfoScreen> {
  // Get x Controller  for business code
  final controller = Get.put(DetailsScreenController(Get.arguments["id"], Get.arguments['list']));

  final itemId = Get.arguments['id'];

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
    //debug code ========
    AppLoggerHelper.debug("Build - DetailsRentInfoScreen");
    //============

    return Scaffold(
      // change a background brightness Dark nad Light
      backgroundColor: AppHelperFunction.isDarkMode(context) ? AppColors.dark : AppColors.light,
      appBar: AppBar(
        title: Text(
          "${controller.data.houseName}",
        ),
      ),

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
                onTap: () {
                  controller.addToCartRoomData();
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
      body: CustomMaterialIndicator(
        // Refresh indicator
        onRefresh: () async {
          return await Future.delayed(const Duration(seconds: 2));
        },
        indicatorBuilder: (BuildContext context, IndicatorController controller) {
          return const Icon(
            Icons.refresh,
            color: Colors.blue,
            size: 30,
          );
        },

        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: AppSizes.xs, right: AppSizes.xs, top: AppSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //=======Page view======
                  Container(
                    alignment: Alignment.center,
                    height: AppHelperFunction.screenHeight() * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: AppHelperFunction.isDarkMode(context) ? Colors.blueGrey.shade900 : Colors.grey.shade200,
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(.8), offset: const Offset(0, 4))],
                    ),
                    child: PageView(
                      controller: controller.imageIndicatorController.value,
                      children: [
                        //show cover image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: CachedNetworkImage(
                              imageUrl: controller.data.coverImage.toString(),
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Container(
                                    color: Colors.transparent,
                                    height: AppHelperFunction.screenHeight() * 0.3,
                                    width: double.infinity,
                                    child: const SpinKitFadingCircle(
                                      color: AppColors.primary,
                                      size: 35,
                                    ),
                                  ),
                              errorWidget: (context, url, error) => Container(
                                    height: AppHelperFunction.screenHeight() * 0.3,
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.image_outlined,
                                      size: 50,
                                    ),
                                  )),
                        ),

                        //view all image Page

                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                          child: OutlinedButton(
                              onPressed: () {
                                Get.toNamed(RoutesName.viewALlImage, arguments: itemId);
                              },
                              style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                  side: const BorderSide(color: Colors.blue)),
                              child: const Text(
                                "View All Images",
                                style: TextStyle(color: Colors.blue),
                              )),
                        ),
                      ],
                    ),
                  ),
                  //===============
                  const SizedBox(
                    height: AppSizes.sizeBoxSpace * 2,
                  ),

                  // smooth page indicator ============
                  Align(
                    alignment: Alignment.center,
                    child: SmoothPageIndicator(
                        controller: controller.imageIndicatorController.value,
                        count: 2,
                        effect: const ExpandingDotsEffect(dotHeight: 6, activeDotColor: AppColors.primary)),
                  ),
                  //=================

                  const SizedBox(
                    height: AppSizes.sizeBoxSpace * 4,
                  ),

                  AllDetailsWidgets(controller: controller),

                  const SizedBox(
                    height: 30,
                  ),

                  ContactAndShareWidgets(
                    controller: controller,
                  ),

                  //======================================================

                  RatingAndReviewWidgets(controller: controller),

                  const SizedBox(
                    height: 20,
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
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 20.0),
                          height: 70,
                          child: AdWidget(ad: adProvider.nativeAd),
                        ) : const CircularProgressIndicator(),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
