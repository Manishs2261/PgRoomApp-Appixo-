import 'package:get/get.dart';

import '../../model/buy_and_sell_model.dart';

class DetailsOfSellAndBuyController extends GetxController {
  final BuyAndSellModel data = Get.arguments;

  RxInt currentPage = 0.obs;
}
