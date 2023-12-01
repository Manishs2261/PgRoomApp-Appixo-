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

  //check the user Review submit or  not
  RxString reviewSubmissionId = "".obs;

  //for use current time update a screen
  RxBool checkReviewSubmission = true.obs;

  // calculate average rating summary
  RxDouble ratingAverage = 0.0.obs;

  @override
  Future<void> onInit() async {
    //get a Rating bar summary data
    await ApisClass.getRatingBarSummaryData(itemId);

    //check the user Review submit or  not id data
    await ApisClass.getReviewData(itemId).then((value) {
      reviewSubmissionId.value = value;
    });

    super.onInit();
  }

  //Rating bar summary calculation
  onRatingSummaryCalculation(ratingValue) async {
    switch (ratingValue) {
      case 5.0:
        ApisClass.saveRatingBarSummaryData(itemId, ApisClass.starOne, ApisClass.starTwo, ApisClass.starThree,
            ApisClass.starFour, ApisClass.starFive + 1, ApisClass.averageRating, ApisClass.totalNumberOfStar);

      case 4.0:
        ApisClass.saveRatingBarSummaryData(itemId, ApisClass.starOne, ApisClass.starTwo, ApisClass.starThree,
            ApisClass.starFour + 1, ApisClass.starFive, ApisClass.averageRating, ApisClass.totalNumberOfStar);

      case 3.0:
        ApisClass.saveRatingBarSummaryData(itemId, ApisClass.starOne, ApisClass.starTwo, ApisClass.starThree + 1,
            ApisClass.starFour, ApisClass.starFive, ApisClass.averageRating, ApisClass.totalNumberOfStar);

      case 2.0:
        ApisClass.saveRatingBarSummaryData(itemId, ApisClass.starOne, ApisClass.starTwo + 1, ApisClass.starThree,
            ApisClass.starFour, ApisClass.starFive, ApisClass.averageRating, ApisClass.totalNumberOfStar);

      case 1.0:
        ApisClass.saveRatingBarSummaryData(itemId, ApisClass.starOne + 1, ApisClass.starTwo, ApisClass.starThree,
            ApisClass.starFour, ApisClass.starFive, ApisClass.averageRating, ApisClass.totalNumberOfStar);

      default:
        break;
    }

    //calculation a total number of star
    var totalNumberOfStar = (((ApisClass.starOne * 1) +
        (ApisClass.starTwo * 2) +
        (ApisClass.starThree * 3) +
        (ApisClass.starFour * 4) +
        (ApisClass.starFive * 5)));

    //calculation a total number of user rating
    var numberOfRating =
        ApisClass.starOne + ApisClass.starTwo + ApisClass.starThree + ApisClass.starFour + ApisClass.starFive;

    // calculation a average
    ratingAverage.value = (totalNumberOfStar / numberOfRating);

    // update rating summary data base
    ApisClass.updateRatingBarStarSummaryData(itemId, ratingAverage.value.toDouble(), numberOfRating + 1);
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
                //Rating summary calculation method
                onRatingSummaryCalculation(ratingNow.value);
                //after submit rating than reset value
                ratingNow.value = 0.0;
                //check user review submit or not
                checkReviewSubmission.value = false;

                FocusScope.of(Get.context!).unfocus();
                loading.value = false;
              }).onError((error, stackTrace) {
                loading.value = false;
                Get.snackbar("Rating Submit", "Failed");
                FocusScope.of(Get.context!).unfocus();
                AppLoggerHelper.error("Rating submit error", error);
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
