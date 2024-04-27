import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  final pageController = PageController();
  RxBool onPageChange = false.obs;

  nextPage() => pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);

  onChange(value) {
    onPageChange.value = (value == 2);
    //  print(onPageChange.value);
  }
}
