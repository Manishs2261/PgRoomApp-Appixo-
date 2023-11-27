import 'package:get/get.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import '../../../../res/route_name/routes_name.dart';

class ProvideFacilitiesController extends GetxController {
  RxBool wifi = false.obs;
  RxBool bed = false.obs;
  RxBool chair = false.obs;
  RxBool table = false.obs;
  RxBool fan = false.obs;
  RxBool gadda = false.obs;
  RxBool light = false.obs;
  RxBool locker = false.obs;
  RxBool bedSheet = false.obs;
  RxBool washingMachine = false.obs;
  RxBool parking = false.obs;
  RxBool loading = false.obs;

  onSubmitButton() {
    loading.value = true;

    Get.toNamed(RoutesName.chargeAndDoorTimingScreen)?.then((value) {
      loading.value = false;
    }).onError((error, stackTrace) {
      AppLoggerHelper.error("provide facilities Error ", error);
      AppLoggerHelper.error("provide facilities Error ", stackTrace);
      loading.value = false;
    });
  }
}
