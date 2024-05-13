import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/on_boarding_screen/widget/on_boarding_widget.dart';
import 'package:pgroom/src/features/on_boarding_screen/widget/smooth_page_indicator.dart';
import 'package:pgroom/src/features/on_boarding_screen/widget/start_button.dart';
import 'package:pgroom/src/utils/Constants/image_string.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import 'controller/on_boarding_controller.dart';

class OnBoardingOneScreen extends StatelessWidget {
  const OnBoardingOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - OnBoardingOneScreen");

    // on boarding controller ==========
    final controller = OnBoardingController();
    //===============

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            //=======Page view======
            PageView(
              controller: controller.pageController,
              onPageChanged: (value) => controller.onChange(value),
              children: const [
                //========screen one ===============
                OnBoardingWidget(
                  image: AppImage.onBoardingOneImage,
                  title: 'Explore, Discover, and Settle In',
                  subtitle: '"Welcome to Appixo –\n Simplifying PG Room Hunting for '
                      'You!"',
                ),

                //=============screen two===============
                OnBoardingWidget(
                  image: AppImage.onBoardingFoodImage,
                  title: '"Discover Comfort and Flavor: Foods."',
                  subtitle: '"Indulge in culinary excellence with our streamlined food services."',
                ),
                OnBoardingWidget(
                  image: AppImage.onBoardingDealImage,
                  title: '"Discover Treasures: Buy and Sell Pre-Loved Goods Online!"',
                  subtitle: '',
                ),
              ],
            ),
            //=============================

            // ========controller a screen ==========
            Obx(
              () => controller.onPageChange.value
                  //========start button ========
                  ? const StartButtonWidget()

                  //=========smooth indicator===============
                  : SmootPageIndicatorWidget(onBoaeding: controller),
            ),
          ],
        ),
      ),
    );
  }
}
