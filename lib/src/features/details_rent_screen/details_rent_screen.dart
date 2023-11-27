import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/details_rent_screen/widget/ContactAndShareWidgets.dart';
import 'package:pgroom/src/features/details_rent_screen/widget/RatingAndReviewWidgets.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';


import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/Constants/colors.dart';
import '../../utils/Constants/sizes.dart';
import '../../utils/helpers/helper_function.dart';
import '../../utils/icon_and_name_widgets/Icon_Write_And_Wrong_Widgets.dart';
import '../../utils/logger/logger.dart';
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

    //its return  Boolean value
    final dark = AppHelperFunction.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.light,
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 2, right: 2, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  // house name
                  child: Text(
                    "${controller.data.houseName}",
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: AppSizes.sizeBoxSpace),
                // Image(image: AssetImage(roomImage)),

                //=======Page view======
                Container(
                  height: 250,
                  width: double.infinity,
                  color: dark ? Colors.blueGrey.shade900 : Colors.grey.shade200,
                  child: PageView(
                    controller: controller.imageIndecterController.value,
                    children: [
                      //show cover image
                      CachedNetworkImage(
                          imageUrl: controller.data.coverImage.toString(),
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Container(
                                color: Colors.transparent,
                                height: 100,
                                width: 100,
                                child: const SpinKitFadingCircle(
                                  color: AppColors.primary,
                                  size: 35,
                                ),
                              ),
                          errorWidget: (context, url, error) => Container(
                                width: 150,
                                height: 280,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.image_outlined,
                                  size: 50,
                                ),
                              )),

                      //view all image Page
                      Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(RoutesName.viewALlImage, arguments: itemId);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 130,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50), border: Border.all(color: Colors.blue)),
                            child: const Text(
                              "View All Photo",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
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
                      controller: controller.imageIndecterController.value,
                      count: 2,
                      effect: const ExpandingDotsEffect(dotHeight: 6,activeDotColor: AppColors.primary)),
                ),
                //=================

                const SizedBox(
                  height: AppSizes.sizeBoxSpace * 4,
                ),

                // House Address
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 15)),
                    // house Address=====
                    const Text(
                      "Address :- ",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Text(
                        "${controller.data.addres}",
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                //Rental Room Type
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 15)),
                    const Text(
                      "Rental Room Type :-",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Text("  ${controller.data.roomType}")
                  ],
                ),

                //Price
                const Padding(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    "Price :-",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Column(
                    children: [
                      if (controller.data.singlePersonPrice != "")
                        IconWriteAndWrongWidgets(
                          title: "Single Person :-  ",
                          price: '${controller.data.singlePersonPrice}/- '
                              'month',
                          isIcon: true,
                        ),
                      if (controller.data.doublePersionPrice != "")
                        IconWriteAndWrongWidgets(
                          title: "double Person :-  ",
                          price: '${controller.data.doublePersionPrice}/- '
                              'month',
                          isIcon: true,
                        ),
                      if (controller.data.triplePersionPrice != "")
                        IconWriteAndWrongWidgets(
                          title: "triple Person :-  ",
                          price: '${controller.data.triplePersionPrice}/- '
                              'month',
                          isIcon: true,
                        ),
                      if (controller.data.fourPersionPrice != "")
                        IconWriteAndWrongWidgets(
                          title: "four Plus Person :-  ",
                          price: '${controller.data.fourPersionPrice}/- '
                              'month',
                          isIcon: true,
                        ),
                      if (controller.data.faimlyPrice != "")
                        IconWriteAndWrongWidgets(
                          title: "Family  :-  ",
                          price: '${controller.data.faimlyPrice}/- '
                              'month',
                          isIcon: true,
                        ),
                    ],
                  ),
                ),

                // Room services
                const Padding(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    "Services :-",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconWriteAndWrongWidgets(
                      title: "Wi-Fi",
                      isIcon: controller.data.wifi!,
                    ),
                    IconWriteAndWrongWidgets(
                      title: "Fan",
                      isIcon: controller.data.fan!,
                    ),
                    IconWriteAndWrongWidgets(
                      title: "Light",
                      isIcon: controller.data.light!,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconWriteAndWrongWidgets(
                      title: "table",
                      isIcon: controller.data.table!,
                    ),
                    IconWriteAndWrongWidgets(
                      title: "chair",
                      isIcon: controller.data.chair!,
                    ),
                    IconWriteAndWrongWidgets(
                      title: "locker",
                      isIcon: controller.data.locker!,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconWriteAndWrongWidgets(
                      title: "Bed",
                      isIcon: controller.data.bed!,
                    ),
                    IconWriteAndWrongWidgets(
                      title: "gadda",
                      isIcon: controller.data.gadda!,
                    ),
                    IconWriteAndWrongWidgets(
                      title: "bed sheet",
                      isIcon: controller.data.bedSheet!,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconWriteAndWrongWidgets(
                      title: "parking",
                      isIcon: controller.data.parking!,
                    ),
                    IconWriteAndWrongWidgets(
                      title: "bathroom \n attach",
                      isIcon: false,
                    ),
                    IconWriteAndWrongWidgets(
                      title: "bathroom \n shareable",
                      isIcon: false,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    "Bills & charges:-",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconWriteAndWrongWidgets(
                      title: "Electricity bill",
                      isIcon: controller.data.electricityBill!,
                    ),
                    IconWriteAndWrongWidgets(
                      title: "water bill",
                      isIcon: controller.data.waterBill!,
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Row(
                    children: [
                      const Text(
                        "Time :-  ",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      (controller.data.restrictedTime != '')
                          ? Text(" Restricted - ${controller.data.restrictedTime}")
                          : const Text("Flexible"),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    "Permission:-",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60, top: 15),
                  child: Column(
                    children: [
                      if (controller.data.girls!)
                        IconWriteAndWrongWidgets(
                          title: "Girl Allow",
                          isIcon: controller.data.girls!,
                        ),
                      if (controller.data.boy!)
                        IconWriteAndWrongWidgets(
                          title: "Boy Allow",
                          isIcon: controller.data.boy!,
                        ),
                      if (controller.data.faimlyMember!)
                        IconWriteAndWrongWidgets(
                          title: "family member Allow",
                          isIcon: controller.data.faimlyMember!,
                        ),
                      if (controller.data.cooking!)
                        IconWriteAndWrongWidgets(
                          title: "cooking Allow :-  ${controller.data.cookingType}",
                          isIcon: controller.data.cooking!,
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),

                const ContactAndShareWidgets(),

                //======================================================

                RatingAndReviewWidgets(controller: controller, dark: dark),

                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
