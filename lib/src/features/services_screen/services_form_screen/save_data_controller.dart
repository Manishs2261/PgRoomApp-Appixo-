import 'package:get/get.dart';
import 'package:pgroom/src/features/services_screen/services_form_screen/first_services_form/controller/controller.dart';
import 'package:pgroom/src/features/services_screen/services_form_screen/seconds_service_screen/controller/controller.dart';
import 'package:pgroom/src/features/services_screen/services_form_screen/third_service_form/controller/controller.dart';

import '../../../data/repository/apis/services_collection.dart';
import '../../../utils/helpers/helper_function.dart';

class SaveDataServiceController extends GetxController {
  final firstServiceFormController = Get.put(FirstServicesFormController());
  final secondServiceFormController = Get.put(SecondServicesFormController());
  final thirdServiceFormController = Get.put(ThirdServicesFormController());

  onSaveData() async {
    bool value = await ServicesApis.addServicesData(
        servicesName: firstServiceFormController.nameController.text,
        latitude:
            secondServiceFormController.lastTappedPosition!.latitude.toString(),
        longitude: secondServiceFormController.lastTappedPosition!.longitude
            .toString(),
        description: firstServiceFormController.descriptionController.text,
        address: firstServiceFormController.addressController.text,
        landmark: firstServiceFormController.landmarkController.text,
        city: firstServiceFormController.cityController.text,
        state: firstServiceFormController.stateController.text,
        imageFiles: firstServiceFormController.imageFiles,
        serviceFAQ: thirdServiceFormController.servicesFAQ);

    if (value) {
      Get.close(3);
      AppHelperFunction.showFlashbar('Saved successfully.');
    } else {
      AppHelperFunction.showFlashbar('Something went wrong.');
    }
  }
}
