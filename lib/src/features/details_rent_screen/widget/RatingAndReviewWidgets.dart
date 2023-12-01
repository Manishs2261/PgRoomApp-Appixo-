
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

import '../../../common/widgets/com_ratingbar_widgets.dart';
import '../../../common/widgets/com_reuse_elevated_button.dart';
import '../../../data/repository/apis/apis.dart';
import '../../../model/rating_and_review_Model/rating_and_review_Model.dart';

import '../../../res/route_name/routes_name.dart';
import '../../../utils/Constants/sizes.dart';
import '../controller/details_screen_controller.dart';

class RatingAndReviewWidgets extends StatelessWidget {
  const RatingAndReviewWidgets({
    super.key,
    required this.controller,
  });

  final DetailsScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Visibility(
              // checkReviewSubmission  for use current time update a screen
              //Because reviewSubmissionId  not initialize after Rating submit

              visible: (controller.reviewSubmissionId.isEmpty && controller.checkReviewSubmission.value),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Rating Now
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppSizes.sizeBoxSpace * 3,
                        top: AppSizes.sizeBoxSpace * 10,
                        bottom: AppSizes.sizeBoxSpace * 2),
                    child: Text(
                      "Rating now :-",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),

                  //rating Now
                  Obx(
                    () => Align(
                      alignment: Alignment.center,
                      child: ComRatingBarWidgets(
                        controller: controller,
                        initialRating: controller.ratingNow.value,
                        horizontal: 3.0,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 14.0),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: controller.reviewController.value,
                      maxLines: 3,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: false,
                        fillColor: Colors.yellow.shade50,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintText: "Write Your Review...",
                        hintStyle: const TextStyle(color: Colors.black38),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSizes.defaultSpace,
                  ),

                  //Rating submit button
                  Obx(
                    () => ComReuseElevButton(
                      onPressed: () => controller.onSubmitReviewButton(),
                      title: 'Submit',
                      loading: controller.loading.value,
                    ),
                  ),
                ],
              )),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 15, top: 50, bottom: 20, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  "Review (${controller.totalReview.value}) :-",
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
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

                    //if review list empty than show
                    if (controller.ratingList.isEmpty) {
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
                      //for some time delay a code
                      Future.delayed(const Duration(seconds: 2), () async {
                        //your code goes here
                        controller.isView.value = true;
                        controller.totalReview.value = controller.ratingList.length;
                      });

                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          addRepaintBoundaries: true,
                          physics: const ScrollPhysics(),
                          //i want to show 5 item only
                          itemCount: (controller.ratingList.length < 5) ? controller.ratingList.length : 5,
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
                                Row(
                                  children: [
                                    ComRatingBarWidgets(
                                      initialRating: controller.ratingList[index].rating!,
                                      itemSize: 17.0,
                                      ignoreGestures: true,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "${controller.ratingList[index].currentDate}",
                                      style: const TextStyle(fontSize: 13, color: Colors.white70),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                                  padding: const EdgeInsets.all(10.0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppHelperFunction.isDarkMode(context)
                                          ? Colors.blueGrey.shade900
                                          : Colors.grey.shade50,
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
