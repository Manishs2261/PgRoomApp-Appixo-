import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/services_screen/model/services_model.dart';

import '../../../../data/repository/apis/apis.dart';
import '../../../../model/review_model.dart';
import '../../../../utils/logger/logger.dart';

class DetailsServiceController extends GetxController {

  RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  final  ServicesModel data = Get.arguments;
  RxDouble ratingNow = 0.0.obs;
  RxInt currentPage = 0.obs;
  final reviewController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    fetchReviewData();
    super.onInit();
  }

  Future<void> fetchReviewData() async {
    try {
      DocumentSnapshot snapshot = await ApisClass.firebaseFirestore
          .collection('DevServicesReview')
          .doc(data.sId)
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