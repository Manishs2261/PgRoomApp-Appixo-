import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/add_to_cart_api.dart';

import '../../../data/repository/apis/user_apis.dart';
import '../../../data/repository/auth_apis/auth_apis.dart';
import '../../../model/old_goods_model/old_goods_model.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_function.dart';

class OldGoodsScreenController extends GetxController {
  var itemId;

  OldGoodsModel data = OldGoodsModel();

  OldGoodsScreenController(this.itemId, this.data);

  @override
  Future<void> onInit() async {
    await UserApis.getUserData();
    super.onInit();
  }

  //Rating bar summary calculation

  onCallNow() {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        AuthApisClass.checkUserLogin().then((value) {
          if (value) {
            AppDeviceUtils.launchUrl("${Uri(
              scheme: 'tel',
              path: data.contactNumber,
            )}");
          }
        });
      }
    });
  }

  addToCartGoodsData() {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        AuthApisClass.checkUserLogin().then((value) {
          if (value) {
            AddToCartApis.createAddToCartOldGoods(
                data.image, data.name, data.address, data.price, data.postDate, data.contactNumber, itemId);
          }
        });
      }
    });
  }
}
