import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/room_rent_all_screen/details_rent_screen/widget/ContactAndShareWidgets.dart';
import 'package:pgroom/src/features/room_rent_all_screen/details_rent_screen/widget/RatingAndReviewWidgets.dart';
import 'package:pgroom/src/features/room_rent_all_screen/details_rent_screen/widget/all_details_widgets.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../common/widgets/com_reuse_elevated_button.dart';
import '../../../data/repository/apis/apis.dart';
import '../../../utils/Constants/colors.dart';
import '../../../utils/Constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../../utils/logger/logger.dart';
import 'controller/details_screen_controller.dart';

class DetailsRentInfoScreen extends StatelessWidget {
  DetailsRentInfoScreen({super.key});

  // Get x Controller  for business code
  final controller = Get.put(DetailsScreenController(Get.arguments["id"], Get.arguments['list']));
  final itemId = Get.arguments['id'];

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

      bottomNavigationBar: Container(
      height: 50,
        child: Row(
          children: [
            Expanded(
             child: InkWell(
               onTap: ()=> controller.onCallNow(),
               child: Container(
                 alignment: Alignment.center,
                 height: 50,

                 decoration: BoxDecoration(
                   color: AppColors.primary
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                   Icon(Icons.call_outlined,color: Colors.white,),
                   Gap(10),
                   Text("Contact Now",style: TextStyle(color: Colors.white,fontSize: 16),),
                 ],)
               ),
             ),
           ),
            Expanded(
              child: InkWell(
                hoverColor: Colors.grey,
                onTap: (){
                  ApisClass.updateAddToCart(controller.itemId, true);
                  AppHelperFunction.showSnackBar("successfully added");
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(

                      color: Colors.orange
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_basket_outlined,color: Colors.white,),
                      Gap(10),
                      Text("Add to card",style: TextStyle(color: Colors.white,fontSize: 16),),
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
                      boxShadow: const [
                        BoxShadow(color: Colors.black38, spreadRadius: 0.5, blurRadius: .1, offset: Offset(0, 6))
                      ],
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
                    height: 50,
                  ),

                  ContactAndShareWidgets(
                    controller: controller,
                  ),

                  //======================================================

                  RatingAndReviewWidgets(controller: controller),

                  const SizedBox(
                    height: 50,
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
