import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../model/rating_and_review_Model/rating_and_review_Model.dart';
import '../../../model/user_rent_model/user_rent_model.dart';
import '../../../repositiry/apis/apis.dart';

class DetailsScreenController extends GetxController {
  var itemId;
  UserRentModel data = UserRentModel();

//constouctor
  DetailsScreenController(this.itemId, this.data);

  RxBool isView = false.obs;
  final reviewController = TextEditingController().obs;

  //page view controller
  final imageIndecterController = PageController().obs;

  List<RatingAndReviewModel> ratingList = [];
  var raingNow;

  onSubmitReviewButton() {
    ApisClass.ratingAndReviewCreateData(
            raingNow, reviewController.value.text, itemId)
        .then((value) {
      reviewController.value.text = '';
      Get.snackbar("raing", "submit");
    }).onError((error, stackTrace) {
      Get.snackbar("error", "error");
      print(error);
    });
  }

  onbutton() {
    print(data.houseName);
  }
}
