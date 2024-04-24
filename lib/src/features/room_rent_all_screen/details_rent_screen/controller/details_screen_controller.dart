import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/auth_apis/auth_apis.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/repository/apis/add_to_cart_api.dart';
import '../../../../data/repository/apis/apis.dart';
import '../../../../data/repository/apis/user_apis.dart';
import '../../../../model/rating_and_review_Model/rating_and_review_Model.dart';
import '../../../../model/user_rent_model/user_rent_model.dart';
import '../../../../utils/device/device_utility.dart';

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
    await UserApis.getUserData();
    //get a Rating bar summary data
    await ApisClass.getRatingBarSummaryData(itemId);

    //check the user Review submit or  not id data
    await ApisClass.getReviewData(itemId).then((value) {
      reviewSubmissionId.value = value;
    });

    super.onInit();
  }

  //Rating bar summary calculation
  onRatingStar(ratingValue) async {
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
  }

  onRatingSummaryCalculation(ratingOfNumber) {
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
    ApisClass.updateRatingBarStarSummaryData(itemId, double.parse(ratingAverage.toStringAsFixed(1)), ratingOfNumber);
    ApisClass.addRatingMainList(itemId, double.parse(ratingAverage.toStringAsFixed(1)), ratingOfNumber);
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
                onRatingStar(ratingNow.value);

                Future.delayed(Duration(seconds: 2), () {
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

  addToCartRoomData() {
    AppHelperFunction.checkInternetAvailability().then((value) {
      if (value) {
        AuthApisClass.checkUserLogin().then((value) {
          if (value) {
            AddToCartApis.createAddToCartUserRoom(
                data.coverImage,
                data.houseName,
                data.address,
                data.city,
                data.landMark,
                data.contactNumber,
                data.bhkType,
                data.roomType,
                data.singlePersonPrice,
                data.doublePersonPrice,
                data.triplePersonPrice,
                data.fourPersonPrice,
                data.familyPrice,
                data.restrictedTime,
                data.numberOfRooms,
                data.wifi,
                data.bed,
                data.chair,
                data.table,
                data.fan,
                data.gadda,
                data.light,
                data.locker,
                data.bedSheet,
                data.washingMachine,
                data.parking,
                data.electricityBill,
                data.waterBill,
                data.flexibleTime,
                data.cooking,
                data.cookingType,
                data.boy,
                data.girls,
                data.familyMember,
                data.attachBathRoom,
                data.shareAbleBathRoom,
                data.like,
                data.latitude,
                data.longitude,
                itemId);
          }
        });
      }
    });

  }
}
