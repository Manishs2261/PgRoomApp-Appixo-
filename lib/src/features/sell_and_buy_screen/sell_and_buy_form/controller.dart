import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

class SellAndBuyController extends GetxController {
  final formKey = GlobalKey<FormState>();

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


  onSaveAndNext() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (images.isEmpty) {
      AppHelperFunction.showSnackBar('Please select images');
      return;
    }

   }
}
