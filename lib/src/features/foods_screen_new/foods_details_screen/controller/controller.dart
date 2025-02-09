import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/room_collection.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../../model/review_model.dart';
import '../../model/food_model.dart';

class DetailsFoodController extends GetxController {
  RxDouble ratingNow = 0.0.obs;

  final reviewController = TextEditingController();

  RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  final FoodModel data = Get.arguments;

  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchReviewData();
    super.onInit();
  }

  Future<void> fetchReviewData() async {
    try {
      DocumentSnapshot snapshot = await ApisClass.firebaseFirestore
          .collection('DevFoodReview')
          .doc(data.fId)
          .get();

      // Check if document exists
      if (snapshot.exists) {
        // Extract the reviews array and limit to 5
        List<dynamic> rawReviews = snapshot['reviews'];
        List<dynamic> limitedReviews =
            rawReviews.take(5).toList(); // Limit to 5 reviews
        reviews.value =
            limitedReviews.map((e) => ReviewModel.fromJson(e)).toList();

        AppLoggerHelper.debug("Limited reviews: ${reviews.length}");
      } else {
        AppLoggerHelper.debug("Document does not exist");
      }
    } catch (e) {
      AppLoggerHelper.error("Error fetching data: $e");
    }
  }
}
