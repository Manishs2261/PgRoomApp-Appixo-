import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/apis/services_collection.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../utils/widgets/bottom_chat_and_call_widgets.dart';
import '../../../utils/widgets/com_ratingbar_widgets.dart';
import '../../../utils/widgets/report_card_widgets.dart';
import '../../../utils/widgets/review_view_card.dart';
import '../../../utils/widgets/submit_review_widgets.dart';
import '../../../utils/widgets/view_map_card_widgets.dart';
import 'controller/controller.dart';

class DetailsServices extends StatefulWidget {
  DetailsServices({super.key});

  @override
  State<DetailsServices> createState() => _DetailsServicesState();
}

class _DetailsServicesState extends State<DetailsServices> {
  final controller = Get.put(DetailsServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          controller.data.servicesName.toString(),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: Colors.black,
              ))
        ],
      ),
      floatingActionButton: BottomChatAndCallWidgets(
        onTapChat: () {},
        onTapCall: () {},
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 16, top: 16, left: 16, bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                width: 400, // Set a fixed height for the PageView
                child: Stack(
                  children: [
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.data.image?.length,
                      onPageChanged: (int page) {
                        setState(() {
                          controller.currentPage.value = page;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              imageUrl: controller.data.image![index],
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 16,
                      right: 4,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          '${controller.currentPage + 1}/ ${controller.data.image?.length}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: false
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.white,
                                  size: 20,
                                )),
                    ),
                  ],
                ),
              ),
              const Text(
                "Bank",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, height: 0),
              ),
              const SizedBox(
                height: 16,
              ),
              ViewMapCardWidgets(
                landmark: controller.data.landmark.toString(),
                homeAddress: controller.data.address.toString(),
                city: controller.data.city.toString(),
                state: controller.data.state.toString(),
                latitude: controller.data.latitude.toString(),
                longitude: controller.data.longitude.toString(),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all()),
                child: Column(
                  children: [
                    Text(
                      controller.data.description.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SubmitReviewWidgets(
                onTap: () {
                  String review = '';
                  showDialog(
                    context: Get.context!,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text("Your Review"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ComRatingBarWidgets(
                              controller: controller,
                              initialRating: controller.ratingNow.value,
                              horizontal: 3.0,
                            ),
                            const SizedBox(height: 32),
                            TextField(
                              controller: controller.reviewController,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w400),
                              decoration: const InputDecoration(
                                  labelText: 'Write Your Review',
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                              keyboardType: TextInputType.text,
                              maxLines: 5,
                              minLines: 1,
                              maxLength: 500,
                              onChanged: (value) {
                                review = value;
                              },
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: const Text(
                              "Cancel",
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                              child: const Text(
                                "Submit",
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () {
                                if (controller
                                    .reviewController.text.isNotEmpty) {
                                  ServicesApis.submitServicesReviewData(
                                      rating:
                                          controller.ratingNow.value.toString(),
                                      userReview:
                                          controller.reviewController.text,
                                      rId: controller.data.sId!);
                                }
                                Navigator.of(context).pop();
                              }),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Review',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(RoutesName.viewAllReview),
                    child: Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(() {
                return Column(
                  children: controller.reviews.map((review) {
                    return ReviewViewCardWidgets(
                      imageUrl: '',
                      userName: 'Reetu',
                      date: review.date!,
                      rating: review.rating!,
                      review: review.review!,
                    );
                  }).toList(),
                );
              }),
              const SizedBox(
                height: 16,
              ),
              ReportCardWidgets(
                onTap: () => Get.toNamed(RoutesName.reportScreen,
                    arguments: [controller.data.sId!, 'DevServicesCollection']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
