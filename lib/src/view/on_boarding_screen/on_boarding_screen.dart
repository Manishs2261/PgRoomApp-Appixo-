import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/uitels/Constants/image_string.dart';
import 'package:pgroom/src/view/on_boarding_screen/controller/on_boarding_controller.dart';
import 'package:pgroom/src/view/on_boarding_screen/widget/on_boarding_widget.dart';
import 'package:pgroom/src/view/on_boarding_screen/widget/smooth_page_indicator.dart';
import 'package:pgroom/src/view/on_boarding_screen/widget/start_button.dart';

class OnBoardingOneScreen extends StatelessWidget {
  const OnBoardingOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("onBoaurding screen +> build ");
    }

    // on boarding controller ==========
    final onBoaeding = onBoardingConlroller();
    //===============

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            //=======Page view======
            PageView(
              controller: onBoaeding.pageController,
              onPageChanged: (value) => onBoaeding.onChange(value),
              children: [
                //========screen one ===============
                onBoardingWidget(
                  image: AppImage.onBoardingOneImage,
                  title: 'Explore, Discover, and Settle In',
                  subtitle: '"Welcome to PgROOM –\n Simplifying PG Room Hunting for '
                      'You!"',
                ),

                //=============screen two===============
                onBoardingWidget(
                  image: AppImage.onBoardingTwoImage,
                  title: 'Discover Your Ideal PG Room',
                  subtitle: '"Find your perfect PG room with ease on PgROOM. Simplifying your search for comfortable '
                      'living."',
                )
              ],
            ),
            //=============================

            // ========controlller a screen ==========
            Obx(
              () => onBoaeding.onPageChange.value
                  //========start button ========
                  ? const StartButtonWidget()

                  //=========smooth indecater===============
                  : SmootPageIndicatorWidget(onBoaeding: onBoaeding),
            ),
          ],
        ),
      ),
    );
  }
}
