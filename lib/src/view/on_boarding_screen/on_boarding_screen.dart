

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/uitels/Constants/colors.dart';
import 'package:pgroom/src/uitels/Constants/image_string.dart';
import 'package:pgroom/src/uitels/helpers/heiper_function.dart';
import 'package:pgroom/src/view/auth_screen/login_screen/login_screen.dart';
import 'package:pgroom/src/view/home/home_screen.dart';
import 'package:pgroom/src/view/on_boarding_screen/controller/on_boarding_controller.dart';
import 'package:pgroom/src/view/on_boarding_screen/widget/on_boarding_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingOneScreen extends StatelessWidget {
  const OnBoardingOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("onBoaurding screen +> build =====================");

    // on boarding controller ==========
    final _onBoaeding = onBoardingConlroller();
    //===============

    return Scaffold(
      body: Stack(
        children: [
          //=======Page view======
          PageView(
            controller: _onBoaeding.pageController,
            onPageChanged: (value) => _onBoaeding.onChange(value),
            children: [
              //========screen one ===============
              onBoardingWidget(
                image: AppImage.onBoardingOneImage,
                title: 'Welcome',
                color: AppColors.white,
              ),

              //=============screen two===============
              onBoardingWidget(
                image: AppImage.onBoardingTwoImage,
                title: 'Hello',
                color: AppColors.white,
              )
            ],
          ),
          //=============================

          // ========controlller a screen ==========
          Obx(
            () => _onBoaeding.onPageChange.value
            //========start button ========
                ? StartButton()

            //=========smooth indecater===============
                : Container(
                    padding: EdgeInsets.only(bottom: 15),
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ======for skip the page========
                        //== Empety for maintain center ========
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "",
                          ),
                        ),

                        // =======for smooth indicater use=====

                        SmoothPageIndicator(
                            controller: _onBoaeding.pageController,
                            count: 2,
                          effect: WormEffect(
                            dotHeight: 6,
                            dotWidth: 30
                          ),
                        ),

                        //========== for Next page===========
                        TextButton(
                            onPressed: () => _onBoaeding.Next(),
                            child: Icon(Iconsax.arrow_right_3,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return Container(
        padding: EdgeInsets.only(bottom: 15),
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 300,
          child: ElevatedButton(
              onPressed: () {
                 Get.offNamed(RoutesName.loginScreen);
              },
              child: Text(
                "Start",
                style: TextStyle(fontSize: 20),
              )),
        ),
      );
  }
}


