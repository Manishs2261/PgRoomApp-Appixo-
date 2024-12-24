import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopSearchBarController extends GetxController with GetSingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> animation;

  RxBool isExpanded = false.obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween<double>(begin: 50, end: Get.width * 0.75).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
  }

  void toggleSearch() {
    if (isExpanded.value) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    isExpanded.value = !isExpanded.value;
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
