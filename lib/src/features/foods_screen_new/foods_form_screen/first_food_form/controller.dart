import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

class FirstFoodFormController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // food type
  RxString roomOwnerType = 'Mess'.obs;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();
  final landmarkController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();


  // Multiple image picker
  final RxList<XFile> images = <XFile>[].obs;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImages() async {
    final List<XFile> selectedImages = await picker.pickMultiImage();

    if (selectedImages.length > 10) {
      // Show a message or alert if more than 10 images are selected
      AppHelperFunction.showSnackBar('You can only select up to 10 images!');
      // Limit the list to 10 images
      images.value = selectedImages.sublist(0, 10);
    } else {
      images.value = selectedImages;
    }
    }
}
