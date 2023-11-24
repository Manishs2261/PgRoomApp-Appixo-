import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../../model/rating_and_review_Model/rating_and_review_Model.dart';
import '../../../repositiry/apis/apis.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../uitels/Constants/sizes.dart';
import '../../../uitels/helpers/heiper_function.dart';
import '../controller/details_screen_controller.dart';

class RatingAndReviewWidgets extends StatelessWidget {
  const RatingAndReviewWidgets({
    super.key,
    required this.controller,
    required this.dark,
  });

  final DetailsScreenController controller;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Rating Now
        const Padding(
          padding: EdgeInsets.only(
              left: AppSizes.sizeBoxSpace * 3, top: AppSizes.sizeBoxSpace * 10, bottom: AppSizes.sizeBoxSpace * 2),
          child: Text(
            "Rating now :-",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),

        //rating stars
        Align(
          alignment: Alignment.center,
          child: RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              controller.raingNow = rating;
              if (kDebugMode) {
                print(rating);
              }
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: TextFormField(
            style: const TextStyle(color: Colors.black),
            controller: controller.reviewController.value,
            maxLines: 3,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.yellow.shade50,
                border: const OutlineInputBorder(),
                hintText: "write your Review..."),
          ),
        ),
        const SizedBox(
          height: AppSizes.defaultSpace,
        ),
        Center(
          child: SizedBox(
            height: 40,
            width: AppHelperFunction.screenWidth() * 0.9,
            child: ElevatedButton(
              onPressed: () {
                // call a controller method
                controller.onSubmitReviewButton();
              },
              child: const Text("Submit"),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 15, top: 50, bottom: 20, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Review :-",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              InkWell(
                  onTap: () {
                    Get.toNamed(RoutesName.viewAllReview, arguments: controller.itemId);
                  },
                  child: const Text(
                    "view all",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ),

        //See all reviews
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StreamBuilder(
                  stream: ApisClass.firestore
                      .collection("userReview")
                      .doc("reviewCollection")
                      .collection("${controller.itemId}")
                      .snapshots(),
                  builder: (context, snapshot) {
                    final snapshotData = snapshot.data?.docs;
                    //convert the map into list
                    controller.ratingList =
                        snapshotData?.map((e) => RatingAndReviewModel.fromJson(e.data())).toList() ?? [];

                    if (controller.ratingList.length == 0) {
                      controller.isView.value = false;
                      return const Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.reviews_outlined),
                          SizedBox(
                            width: 3,
                          ),
                          Text("No Review"),
                        ],
                      ));
                    } else {
                      Future.delayed(Duration.zero, () {
                        //your code goes here
                        controller.isView.value = true;
                      });

                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          addRepaintBoundaries: true,
                          physics: const ScrollPhysics(),
                          itemCount: controller.ratingList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 25,
                                      decoration:
                                          BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.blue),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Manish sahu",
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  itemSize: 17,
                                  initialRating: controller.ratingList[index].rating!,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (double value) {},
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                                  padding: const EdgeInsets.all(10.0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: dark ? Colors.blueGrey.shade900 : Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text("${controller.ratingList[index].title}"),
                                ),
                              ],
                            );
                          });
                    }
                  }),
            ],
          ),
        ),
        Obx(
          () => (controller.isView.value)
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(RoutesName.viewAllReview, arguments: controller.itemId);
                      },
                      child: const Text(
                        "View All",
                        style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              : const Text(""),
        ),
      ],
    );
  }
}
