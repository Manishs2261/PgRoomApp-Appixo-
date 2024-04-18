import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../common/widgets/com_ratingbar_widgets.dart';
import '../../../data/repository/apis/apis.dart';
import '../../../model/rating_and_review_Model/rating_and_review_Model.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../utils/Constants/colors.dart';
import '../../../utils/Constants/sizes.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../room_rent_all_screen/details_rent_screen/widget/circle_Container_widgets.dart';
import 'controller/controller.dart';

class DetailsTiffineServicesScreen extends StatelessWidget {
  DetailsTiffineServicesScreen({super.key});

  final controller = Get.put(DetailsTiffineController(Get.arguments["id"], Get.arguments['list']));

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - DetailsTiffineServicesScreen ");

    final Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=" +
        controller.data.latitude.toString() +
        "," +
        controller.data.longitude.toString());

    Future<void> _launchUrl() async {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => controller.onCallNow(),
                child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(color: AppColors.primary),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.call_outlined,
                          color: Colors.white,
                        ),
                        Gap(10),
                        Text(
                          "Contact Now",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    )),
              ),
            ),
            Expanded(
              child: InkWell(
                hoverColor: Colors.grey,
                // onTap: (){
                //   ApisClass.updateAddToCart(controller.itemId, true);
                //   AppHelperFunction.showSnackBar("successfully added");
                // },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.orange),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_basket_outlined,
                        color: Colors.white,
                      ),
                      Gap(10),
                      Text(
                        "Add to card",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("${controller.data.servicesName}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Card(
                  margin: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: CachedNetworkImage(
                      imageUrl: controller.data.foodImage.toString(),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Container(
                        color: Colors.transparent,
                        width: double.infinity,
                        height: 200,
                        child: const SpinKitFadingCircle(
                          color: AppColors.primary,
                          size: 35,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: double.infinity,
                        height: 200,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.food_bank,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${controller.data.servicesName}",
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "${controller.data.averageRating}",
                        style: const TextStyle(fontSize: 17),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("(${controller.data.numberOfRating} Ratings)"),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Price :- ₹${controller.data.foodPrice}/-Month  ",
                        style: const TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Address :- ",
                        style: TextStyle(fontSize: 18),
                      ),
                      Flexible(
                        child: Text(
                          "${controller.data.address}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: false,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                      imageUrl: controller.data.menuImage.toString(),
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) => Container(
                                        color: Colors.transparent,
                                        width: double.infinity,
                                        height: 200,
                                        child: const SpinKitFadingCircle(
                                          color: AppColors.primary,
                                          size: 35,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => Container(
                                        width: double.infinity,
                                        height: 200,
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.food_bank,
                                          size: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: const Row(
                      children: [
                        Text(
                          "View Menu",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      //===========================================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //=========share =========
                          CircleContainerWidgets(
                            title: 'Share',
                            iconData: Icons.share_outlined,
                            ontap: () {},
                          ),

                          // ==========map view ===========
                          CircleContainerWidgets(
                              title: "Map view", iconData: Icons.location_on_outlined, ontap: () => _launchUrl())
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
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
                            Get.toNamed(RoutesName.viewAllReviewTiffineScreen, arguments: controller.itemId);
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
                          stream: ApisClass.firebaseFirestore
                              .collection("TiffineReview")
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
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50), color: Colors.blue),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(50),
                                                child: CachedNetworkImage(
                                                  height: 25,
                                                  width: 25,
                                                  fit: BoxFit.cover,
                                                  imageUrl: controller.ratingList[index].userImage.toString(),
                                                  placeholder: (context, _) => const Center(
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
                                              "${controller.ratingList[index].userName}",
                                              style: const TextStyle(fontWeight: FontWeight.w600),
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
                  () => Visibility(
                    visible: controller.isView.value,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(RoutesName.viewAllReviewTiffineScreen, arguments: controller.itemId);
                          },
                          child: const Text(
                            "View All",
                            style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 50,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
