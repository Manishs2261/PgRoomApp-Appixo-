import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/tiffine_services_api.dart';
import 'package:pgroom/src/model/tiffin_services_model/tiffen_services_model.dart';

import '../../../../data/repository/apis/add_to_cart_api.dart';
import '../../../../data/repository/apis/user_apis.dart';
import '../../../../data/repository/auth_apis/auth_apis.dart';
import '../../../../model/rating_and_review_Model/rating_and_review_Model.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../../../utils/logger/logger.dart';

class DetailsTiffineController extends GetxController {
  var itemId;

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

  RxString  latitude = ''.obs;
  RxString  longitude = ''.obs;

  @override
  Future<void> onInit() async {
    await UserApis.getUserData();
    //get a Rating bar summary data
    await TiffineServicesApis.getRatingBarSummaryTiffineData(itemId);

    //check the user Review submit or  not id data
    await TiffineServicesApis.getTiffineRatingSubmitIdData(itemId).then((value) {
      reviewSubmissionId.value = value;
    });

    super.onInit();
  }

  //Rating bar summary calculation
  onRatingStar(ratingValue) async {
    switch (ratingValue) {
      case 5.0:
        TiffineServicesApis.saveRatingBarSummaryTiffineData(
            itemId,
            TiffineServicesApis.starOneTiffine,
            TiffineServicesApis.starTwoTiffine,
            TiffineServicesApis.starThreeTiffine,
            TiffineServicesApis.starFourTiffine,
            TiffineServicesApis.starFiveTiffine + 1,
            TiffineServicesApis.averageRatingTiffine,
            TiffineServicesApis.totalNumberOfStarTiffine);

      case 4.0:
        TiffineServicesApis.saveRatingBarSummaryTiffineData(
            itemId,
            TiffineServicesApis.starOneTiffine,
            TiffineServicesApis.starTwoTiffine,
            TiffineServicesApis.starThreeTiffine,
            TiffineServicesApis.starFourTiffine + 1,
            TiffineServicesApis.starFiveTiffine,
            TiffineServicesApis.averageRatingTiffine,
            TiffineServicesApis.totalNumberOfStarTiffine);

      case 3.0:
        TiffineServicesApis.saveRatingBarSummaryTiffineData(
            itemId,
            TiffineServicesApis.starOneTiffine,
            TiffineServicesApis.starTwoTiffine,
            TiffineServicesApis.starThreeTiffine + 1,
            TiffineServicesApis.starFourTiffine,
            TiffineServicesApis.starFiveTiffine,
            TiffineServicesApis.averageRatingTiffine,
            TiffineServicesApis.totalNumberOfStarTiffine);

      case 2.0:
        TiffineServicesApis.saveRatingBarSummaryTiffineData(
            itemId,
            TiffineServicesApis.starOneTiffine,
            TiffineServicesApis.starTwoTiffine + 1,
            TiffineServicesApis.starThreeTiffine,
            TiffineServicesApis.starFourTiffine,
            TiffineServicesApis.starFiveTiffine,
            TiffineServicesApis.averageRatingTiffine,
            TiffineServicesApis.totalNumberOfStarTiffine);

      case 1.0:
        TiffineServicesApis.saveRatingBarSummaryTiffineData(
            itemId,
            TiffineServicesApis.starOneTiffine + 1,
            TiffineServicesApis.starTwoTiffine,
            TiffineServicesApis.starThreeTiffine,
            TiffineServicesApis.starFourTiffine,
            TiffineServicesApis.starFiveTiffine,
            TiffineServicesApis.averageRatingTiffine,
            TiffineServicesApis.totalNumberOfStarTiffine);

      default:
        break;
    }
  }

  onRatingSummaryCalculation(ratingOfNumber) {
    //calculation a total number of star
    var totalNumberOfStar = (((TiffineServicesApis.starOneTiffine * 1) +
        (TiffineServicesApis.starTwoTiffine * 2) +
        (TiffineServicesApis.starThreeTiffine * 3) +
        (TiffineServicesApis.starFourTiffine * 4) +
        (TiffineServicesApis.starFiveTiffine * 5)));

    //calculation a total number of user rating
    var numberOfRating = TiffineServicesApis.starOneTiffine +
        TiffineServicesApis.starTwoTiffine +
        TiffineServicesApis.starThreeTiffine +
        TiffineServicesApis.starFourTiffine +
        TiffineServicesApis.starFiveTiffine;



    if (totalNumberOfStar == 0 && numberOfRating == 0) {
      return null;
    } else if (numberOfRating == 0) {
      return null;
    } else {
      ratingAverage.value = (totalNumberOfStar / ratingOfNumber);
    }

    // update rating summary data base
    TiffineServicesApis.updateRatingBarStarSummaryTiffineData(
        itemId, double.parse(ratingAverage.toStringAsFixed(1)), ratingOfNumber);
    TiffineServicesApis.addRatingMainTiffineList(
        itemId, double.parse(ratingAverage.toStringAsFixed(1)), ratingOfNumber);
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
              TiffineServicesApis.createTiffineRatingAndReviewData(ratingNow.value, reviewController.value.text, itemId)
                  .then((value) {
                reviewController.value.text = '';
                Get.snackbar("Rating Submit", "Successfully");
                //Rating summary calculation method
                onRatingStar(ratingNow.value);

                Future.delayed(const Duration(seconds: 2), () {
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
               path: data.contactNumber,
            )}");
          }
        });
      }
    });
  }


  addToCartTiffineData() {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        AuthApisClass.checkUserLogin().then((value) {
          if (value) {
            AddToCartApis.createAddToCartUserTiffine(data.foodImage, data.servicesName, data.address, data.foodPrice,
                data.menuImage,
                data.contactNumber, data.latitude, data.latitude, itemId);
            AppHelperFunction.showSnackBar("successfully added");
          }
        });
      }
    });

  }
}
