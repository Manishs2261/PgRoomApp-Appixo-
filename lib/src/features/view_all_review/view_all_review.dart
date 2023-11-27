import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import '../../data/repository/apis/apis.dart';
import '../../model/rating_and_review_Model/rating_and_review_Model.dart';


class ViewAllReviewScreen extends StatelessWidget {
  ViewAllReviewScreen({super.key});

  var itemId = Get.arguments;

  List<RatingAndReviewModel> ratingList = [];

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - ViewAllReviewScreen  ");
    final dark = AppHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Review"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15,top: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StreamBuilder(
                  stream: ApisClass.firestore
                      .collection("userReview")
                      .doc("reviewCollection")
                      .collection("$itemId")
                      .snapshots(),
                  builder: (context, snapshot) {
                    final data = snapshot.data?.docs;

                    ratingList = data?.map((e) => RatingAndReviewModel.fromJson(e.data())).toList() ?? [];

                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: ratingList.length,
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
                                initialRating: ratingList[index].rating!,
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
                                decoration: BoxDecoration(color: dark ? Colors.blueGrey.shade900 : Colors.grey.shade50),
                                child: Text("${ratingList[index].title}"),
                              )
                            ],
                          );
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
