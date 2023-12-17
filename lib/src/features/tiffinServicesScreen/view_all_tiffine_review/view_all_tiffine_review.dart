import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pgroom/src/common/widgets/com_ratingbar_widgets.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'package:rating_summary/rating_summary.dart';
import '../../../data/repository/apis/apis.dart';
import '../../../model/rating_and_review_Model/rating_and_review_Model.dart';
import '../../../utils/Constants/colors.dart';

class ViewAllReviewTiffineScreen extends StatelessWidget {
  ViewAllReviewTiffineScreen({super.key});

  var itemId = Get.arguments;

  List<RatingAndReviewModel> ratingList = [];

  @override
  Widget build(BuildContext context) {
    ApisClass.getRatingBarSummaryData(itemId);
    AppLoggerHelper.debug("Build - ViewAllReviewScreen  ");
    final dark = AppHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Review"),
      ),
      body: LiquidPullToRefresh(
        color: Colors.white,
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2));
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Rating summary
                  Container(
                    padding: const EdgeInsets.all(15),
                    height: 200,
                    width: double.infinity,
                    child: RatingSummary(
                      counter: (ApisClass.totalNumberOfStarTiffine == 0) ? 1 : ApisClass.totalNumberOfStarTiffine,
                      average:  ApisClass.averageRatingTiffine,
                      showAverage: true,
                      counterFiveStars: ApisClass.starFiveTiffine,
                      counterFourStars: ApisClass.starFourTiffine,
                      counterThreeStars: ApisClass.starThreeTiffine,
                      counterTwoStars: ApisClass.starTwoTiffine,
                      counterOneStars: ApisClass.starOneTiffine,
                    ),
                  ),

                  StreamBuilder(
                      stream: ApisClass.firebaseFirestore
                          .collection("TiffineReview")
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

                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            height: 25,
                                            width: 25,
                                            fit: BoxFit.cover,
                                            imageUrl: ratingList[index].userImage.toString(),
                                            placeholder: (context,_)=>Center(
                                              child: SpinKitFadingCircle(
                                                color: AppColors.primary,
                                                size: 30,
                                              ),
                                            ),
                                            errorWidget: (context, url, error) =>
                                            const CircleAvatar(child: Icon(CupertinoIcons.person)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${ratingList[index].userName}",
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
          ],
        ),
      ),
    );
  }
}
