import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pgroom/src/features/services_screen/services_form_screen/first_services_form/controller.dart';
import 'package:pgroom/src/features/services_screen/services_form_screen/first_services_form/first_services_form.dart';
import 'package:pgroom/src/features/services_screen/services_form_screen/seconds_service_screen/controller.dart';
import 'package:pgroom/src/features/services_screen/services_form_screen/third_service_form/controller.dart';

import '../../../data/repository/apis/services_api.dart';
import '../../../utils/helpers/helper_function.dart';

class SaveDataServiceController extends GetxController {



  final firstServiceFormController = Get.put(FirstServicesFormController());
  final secondServiceFormController = Get.put(SecondServicesFormController());
  final thirdServiceFormController = Get.put(ThirdServicesFormController());




  onSaveData() async{
  bool value = await  ServicesApis.addServicesData(
        servicesName: firstServiceFormController.nameController.text ,
        latitude: secondServiceFormController.lastTappedPosition!.latitude.toString(),
        longitude: secondServiceFormController.lastTappedPosition!.longitude.toString(),
        description: firstServiceFormController.descriptionController.text,
        address: firstServiceFormController.addressController.text,
        landmark: firstServiceFormController.landmarkController.text,
        city: firstServiceFormController.cityController.text,
        state: firstServiceFormController.stateController.text,
        imageFiles: firstServiceFormController.imageFiles,
        serviceFAQ: thirdServiceFormController.servicesFAQ
    );


  if (value) {
    Navigator.pop(Get.context!);
    AppHelperFunction.showFlashbar('Saved successfully.');
  } else {
    AppHelperFunction.showFlashbar('Something went wrong.');
  }




  }

}