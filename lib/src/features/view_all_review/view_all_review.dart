import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_ratingbar_widgets.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'package:rating_summary/rating_summary.dart';
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
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              //Rating summary
              Container(
                padding: const EdgeInsets.all(15),
                height: 200,
                width: double.infinity,
                child: const RatingSummary(
                  counter: 13,
                  average: 3.846,
                  showAverage: true,
                  counterFiveStars: 5,
                  counterFourStars: 4,
                  counterThreeStars: 2,
                  counterTwoStars: 1,
                  counterOneStars: 1,
                ),
              ),
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
                              Row(
                                children: [
                                  ComRatingBarWidgets(
                                    initialRating: ratingList[index].rating!,
                                    ignoreGestures: true,
                                    itemSize: 17,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${ratingList[index].currentDate}",
                                    style: const TextStyle(fontSize: 13, color: Colors.white70),
                                  )
                                ],
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
