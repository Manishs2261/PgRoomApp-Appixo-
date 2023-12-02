import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/data/repository/apis/apis.dart';

class ProfileController extends GetxController{


  XFile? image;


  @override
  void onInit() {

    ApisClass.getUserData();
    super.onInit();


  }

  Future pickCoverImageFromGallery() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image == null) return;

    ApisClass.uploadUserImage(File(image!.path));
  }


  Future pickCoverImageFromCamera() async {
    image = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 70);
    if (image == null) return;

    ApisClass.uploadUserImage(File(image!.path));
  }

}