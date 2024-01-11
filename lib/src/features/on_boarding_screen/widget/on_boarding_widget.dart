import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pgroom/src/utils/Constants/sizes.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

class onBoardingWidget extends StatelessWidget {
  onBoardingWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image(
          //   image: AssetImage(image),
          //   height: AppHelperFunction.screenHeight() * 0.3,
          //   width: AppHelperFunction.screenWidth() * 0.7,
          // ),
          Lottie.asset(image),
          SizedBox(height: 10,),
          Text(
            title,
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSizes.spaceBtwItems,),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
