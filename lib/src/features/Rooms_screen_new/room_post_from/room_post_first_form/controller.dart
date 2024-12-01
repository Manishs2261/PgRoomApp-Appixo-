import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

import '../../../../res/route_name/routes_name.dart';

class FirstRoomFormController extends GetxController {


  final formKey = GlobalKey<FormState>();

  // Room ownership type
  RxString roomOwnerType = 'Owner'.obs;

  // Room type
  RxString roomType = 'Private'.obs;

  // Room category
  RxString roomCategory = 'PG'.obs;

  // Gender type
  RxString genderType = 'Boys'.obs;

  // Meal availability
  RxString mealsAvailable = 'Yes'.obs;

  // Multiple image picker
  RxList<XFile> images = <XFile>[].obs;

  final ImagePicker _picker = ImagePicker();

  // Conditional fields
  TextEditingController singleRoomPriceController = TextEditingController();

  TextEditingController tripleRoomPriceController = TextEditingController();

  TextEditingController doubleRoomPriceController = TextEditingController();
  TextEditingController threePlusRoomPriceController = TextEditingController();

  // Common facilities & house rules
  RxList selectedFacilities = [].obs;


  RxList selectedCommonAreas = [].obs;

  RxList selectedBills = [].obs;



  // Form fields
  TextEditingController roomNameController = TextEditingController();

  Future<void> pickImages() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage();

    if (selectedImages.length > 10) {
      // Show a message or alert if more than 10 images are selected
      Get.snackbar('Error', 'You can only select up to 10 images!');
      // Limit the list to 10 images
      images.value = selectedImages.sublist(0, 10);
    } else {
      images.value = selectedImages;
    }
    }



  onSaveAndNext() {
    if (!formKey.currentState!.validate()) {
      // Form validation failed
      return;
    }

    if (images.isEmpty) {
      AppHelperFunction.showSnackBar('Please select images');
      return;
    }

    Get.toNamed(RoutesName.secondRoomFormScreen);

  }


}
