import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/auth_apis/auth_apis.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../data/repository/apis/apis.dart';
import '../../../model/rating_and_review_Model/rating_and_review_Model.dart';
import '../../../model/user_rent_model/user_rent_model.dart';

class DetailsScreenController extends GetxController {
  var itemId;
  UserRentModel data = UserRentModel();

//constructor
  DetailsScreenController(this.itemId, this.data);

  RxBool isView = false.obs;
  final reviewController = TextEditingController().obs;

  //page view controller
  final imageIndicatorController = PageController().obs;

  List<RatingAndReviewModel> ratingList = [];

  //Rating update value, like 3 - star
  RxDouble ratingNow = 0.0.obs;

  //circular Indicator progress bar
  RxBool loading = false.obs;

  //calculate a total number of user give review
  RxInt totalReview = 0.obs;

  RxString reviewSubmissionId = "".obs;

  //for use current time update a screen
  RxBool checkReviewSubmission = true.obs;

  @override
  Future<void> onInit() async {
    await ApisClass.getRatingBarData(itemId);
    await ApisClass.getReviewData(itemId).then((value) {
      reviewSubmissionId.value = value;
    });


    print(ApisClass.starOne);
    print(ApisClass.starTwo);
    print(ApisClass.starThree);
    print(ApisClass.starFour);
    print(ApisClass.starFive);


    super.onInit();
  }


  onRatingSummaryCalculation(ratvalue){

    print("manish  ${ratvalue}");

    switch(ratvalue){
      case 5.0:
        ApisClass.saveRatingBarStarData(itemId, ApisClass.starOne, ApisClass.starTwo, ApisClass.starThree,ApisClass.starFour,
            ApisClass.starFive + 1);
        print(ratvalue);
        break;
      case 4.0:
        ApisClass.saveRatingBarStarData(itemId, ApisClass.starOne, ApisClass.starTwo, ApisClass.starThree,ApisClass
            .starFour + 1 ,
            ApisClass.starFive);
        print(ratvalue);
        break;
      case 3.0:
        ApisClass.saveRatingBarStarData(itemId, ApisClass.starOne, ApisClass.starTwo, ApisClass.starThree+1,ApisClass
            .starFour,
            ApisClass.starFive);
        print(ratvalue);
        break;
      case 2.0:
        print(ApisClass.starTwo);
        ApisClass.saveRatingBarStarData(itemId, ApisClass.starOne, ApisClass.starTwo+1, ApisClass.starThree,ApisClass
            .starFour,
            ApisClass.starFive);
        print(ratvalue);
        break;
      case 1.0:
        ApisClass.saveRatingBarStarData(itemId, ApisClass.starOne+1, ApisClass.starTwo, ApisClass.starThree,ApisClass
            .starFour,
            ApisClass.starFive);
        print(ratvalue);
        break;
      default :
        print("default");
        break;
    }
  }





  onSubmitReviewButton() {
    //check internet connection
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        //check user are login or not
        AuthApisClass.checkUserLogin().then((loginValue) {
          if (loginValue) {
            //rating is empty, not click a button
            if (ratingNow.value != 0.0) {
              loading.value = true;
              ApisClass.ratingAndReviewCreateData(ratingNow.value, reviewController.value.text, itemId).then((value) {
                reviewController.value.text = '';
                Get.snackbar("Rating Submit", "Successfully");
                onRatingSummaryCalculation(ratingNow.value);
                ratingNow.value = 0.0;
                checkReviewSubmission.value = false;

                FocusScope.of(Get.context!).unfocus();
                loading.value = false;



              }).onError((error, stackTrace) {
                loading.value = false;
                Get.snackbar("Rating Submit", "Failed");
                FocusScope.of(Get.context!).unfocus();
                AppLoggerHelper.error("Rating submit error", error);
                AppLoggerHelper.error("Rating submit error", stackTrace);
              });
            } else {
              loading.value = false;
              AppHelperFunction.showSnackBar("Rating can't be empty.");
            }
          }
        });
      }
    });
  }
}
