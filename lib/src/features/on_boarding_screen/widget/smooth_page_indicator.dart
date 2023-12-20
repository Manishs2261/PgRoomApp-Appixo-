import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/Constants/colors.dart';
import '../controller/on_boarding_controller.dart';

class SmootPageIndicatorWidget extends StatelessWidget {
  const SmootPageIndicatorWidget({
    super.key,
    required OnBoardingController onBoaeding,
  }) : _onBoaeding = onBoaeding;

  final OnBoardingController _onBoaeding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // ======for skip the page========
          //== Empety for maintain center ========
          TextButton(
            onPressed: () {},
            child: const Text(
              "",
            ),
          ),

          // =======for smooth indicater use=====

          SmoothPageIndicator(
            controller: _onBoaeding.pageController,
            count: 2,
            effect: const WormEffect(dotHeight: 6, dotWidth: 30, activeDotColor: AppColors.primary),
          ),

          //========== for Next page===========
          TextButton(
              onPressed: () => _onBoaeding.nextPage(),
              child: const Icon(
                Iconsax.arrow_right_3,
                size: 30,
              )),
        ],
      ),
    );
  }
}
