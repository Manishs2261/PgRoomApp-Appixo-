import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class onBoardingConlroller extends GetxController{


  final pageController = PageController();
  RxBool onPageChange = false.obs;

  Next() =>pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  onChange(value){
    onPageChange.value = (value == 1);
  //  print(onPageChange.value);

  }


}