import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/model/tiffin_services_model/tiffen_services_model.dart';

import '../../../../data/repository/apis/apis.dart';
import '../../../../data/repository/auth_apis/auth_apis.dart';
import '../../../../model/rating_and_review_Model/rating_and_review_Model.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../../../utils/logger/logger.dart';

class DetailsTiffineController extends GetxController{

  var itemId ;
  TiffineServicesModel data = TiffineServicesModel();

  DetailsTiffineController(this.itemId, this.data);


  RxBool isView = false.obs;
  final reviewController = TextEditingController().obs;


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
    await ApisClass.getUserData();
    //get a Rating bar summary data
    await ApisClass.getRatingBarSummaryTiffineData(itemId);

    //check the user Review submit or  not id data
    await ApisClass.getReviewTiffineData(itemId).then((value) {
      reviewSubmissionId.value = value;
    });

    super.onInit();
  }


  //Rating bar summary calculation
  onRatingStar(ratingValue) async {
    switch (ratingValue) {
      case 5.0:
        ApisClass.saveRatingBarSummaryTiffineData(itemId, ApisClass.starOneTiffine, ApisClass.starTwoTiffine, ApisClass
            .starThreeTiffine,
            ApisClass.starFourTiffine, ApisClass.starFiveTiffine + 1, ApisClass.averageRatingTiffine, ApisClass
                .totalNumberOfStarTiffine);

      case 4.0:
        ApisClass.saveRatingBarSummaryTiffineData(itemId, ApisClass.starOneTiffine, ApisClass.starTwoTiffine, ApisClass
            .starThreeTiffine,
            ApisClass.starFourTiffine + 1, ApisClass.starFiveTiffine, ApisClass.averageRatingTiffine, ApisClass
                .totalNumberOfStarTiffine);

      case 3.0:
        ApisClass.saveRatingBarSummaryTiffineData(itemId, ApisClass.starOneTiffine, ApisClass.starTwoTiffine, ApisClass
            .starThreeTiffine
            + 1,
            ApisClass.starFourTiffine, ApisClass.starFiveTiffine, ApisClass.averageRatingTiffine, ApisClass
                .totalNumberOfStarTiffine);

      case 2.0:
        ApisClass.saveRatingBarSummaryTiffineData(itemId, ApisClass.starOneTiffine, ApisClass.starTwoTiffine + 1,
            ApisClass
            .starThreeTiffine,
            ApisClass.starFourTiffine, ApisClass.starFiveTiffine, ApisClass.averageRatingTiffine, ApisClass
                .totalNumberOfStarTiffine);

      case 1.0:
        ApisClass.saveRatingBarSummaryTiffineData(itemId, ApisClass.starOneTiffine + 1, ApisClass.starTwoTiffine,
            ApisClass
            .starThreeTiffine,
            ApisClass.starFourTiffine, ApisClass.starFiveTiffine, ApisClass.averageRatingTiffine, ApisClass
                .totalNumberOfStarTiffine);

      default:
        break;
    }
  }

  onRatingSummaryCalculation(ratingOfNumber) {
    //calculation a total number of star
    var totalNumberOfStar = (((ApisClass.starOneTiffine * 1) +
        (ApisClass.starTwoTiffine * 2) +
        (ApisClass.starThreeTiffine * 3) +
        (ApisClass.starFourTiffine * 4) +
        (ApisClass.starFiveTiffine * 5)));

    //calculation a total number of user rating
    var numberOfRating =
        ApisClass.starOneTiffine + ApisClass.starTwoTiffine + ApisClass.starThreeTiffine + ApisClass.starFourTiffine +
            ApisClass
            .starFiveTiffine;

    // calculation a average
    print(numberOfRating);
    print(totalNumberOfStar);

    if (totalNumberOfStar == 0 && numberOfRating == 0) {
      return null;
    } else if (numberOfRating == 0) {
      return null;
    } else {
      ratingAverage.value = (totalNumberOfStar / ratingOfNumber);
    }

    // update rating summary data base
    ApisClass.updateRatingBarStarSummaryTiffineData(itemId, double.parse(ratingAverage.toStringAsFixed(1)), ratingOfNumber);
    ApisClass.addRatingMainTiffineList(itemId, double.parse(ratingAverage.toStringAsFixed(1)), ratingOfNumber);
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
              ApisClass.ratingAndReviewCreateTiffineData(ratingNow.value, reviewController.value.text, itemId).then(
                      (value) {
                reviewController.value.text = '';
                Get.snackbar("Rating Submit", "Successfully");
                //Rating summary calculation method
               onRatingStar(ratingNow.value);

                Future.delayed(Duration(seconds: 2),(){
                 onRatingSummaryCalculation(ratingList.length);
                });
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

  onCallNow() {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        AuthApisClass.checkUserLogin().then((value) {
          if (value) {
            AppDeviceUtils.launchUrl("${Uri(
              scheme: 'tel',
             // path: data.contactNumber,
            )}");
          }
        });
      }
    });
  }
}



