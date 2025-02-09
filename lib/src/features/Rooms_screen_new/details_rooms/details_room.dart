import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';

import '../../../data/repository/apis/room_collection.dart';
import '../../../utils/widgets/bottom_chat_and_call_widgets.dart';
import '../../../utils/widgets/com_ratingbar_widgets.dart';
import '../../../utils/widgets/faq_widgets.dart';
import '../../../utils/widgets/report_card_widgets.dart';
import '../../../utils/widgets/review_view_card.dart';
import '../../../utils/widgets/space_between_text.dart';
import '../../../utils/widgets/submit_review_widgets.dart';
import '../../../utils/widgets/view_map_card_widgets.dart';
import 'controller/details_room_controller.dart';

class DetailsRoom extends StatefulWidget {
  const DetailsRoom({super.key});

  @override
  State<DetailsRoom> createState() => _DetailsRoomState();
}

class _DetailsRoomState extends State<DetailsRoom> {
  final controller = Get.put(DetailsRoomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          '${controller.data.houseName?.capitalizeFirst}',
          style: const TextStyle(color: Colors.black),
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
                      itemCount: controller.data.imageList!.length,
                      onPageChanged: (int page) {
                        controller.currentPage.value = page;
                      },
                      itemBuilder: (context, imageIndex) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              imageUrl: controller.data.imageList![imageIndex],
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
                          '${controller.currentPage + 1}/ ${controller.data.imageList!.length}',
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
                          padding: const EdgeInsets.all(6),
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
                                )),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.blueAccent,
                    ),
                    child: const Text(
                      'BOYS',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.amber,
                    ),
                    child: Text(
                      '${controller.data.roomCategory}',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "${controller.data.roomType}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 16,
              ),
              ViewMapCardWidgets(
                landmark: controller.data.landmark.toString(),
                homeAddress:controller.data.homeAddress.toString(),
                city: controller.data.city.toString(),
                state: controller.data.state.toString(),
                latitude:  controller.data.latitude.toString(),
                longitude: controller.data.longitude.toString(),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Overview',
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
                    if (controller.data.familyCost!.isNotEmpty)
                      SpaceBetweenText(
                        title: 'BHK Cost',
                        cost: controller.data.familyCost.toString(),
                      ),
                    if (controller.data.singlePersonCost!.isNotEmpty)
                      SpaceBetweenText(
                        title: 'Single Person Price',
                        cost: controller.data.singlePersonCost.toString(),
                      ),
                    if (controller.data.doublePersonCost!.isNotEmpty)
                      SpaceBetweenText(
                        title: 'Double Person Price',
                        cost: controller.data.doublePersonCost.toString(),
                      ),
                    if (controller.data.triplePersonCost!.isNotEmpty)
                      SpaceBetweenText(
                        title: 'Triple Person Price',
                        cost: controller.data.triplePersonCost.toString(),
                      ),
                    if (controller.data.triplePlusCost!.isNotEmpty)
                      SpaceBetweenText(
                        title: 'Triple Plus Person Price',
                        cost: controller.data.triplePlusCost.toString(),
                      ),
                    if (controller.data.depositAmount!.isNotEmpty)
                      SpaceBetweenText(
                        title: 'One Time Security Deposit Amount',
                        cost: controller.data.depositAmount.toString(),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              if (controller.data.roomFacilityList!.isNotEmpty)
                const Text(
                  'Room Offering',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              if (controller.data.roomFacilityList!.isNotEmpty)
                Card(
                  color: Colors.white,
                  elevation: 1.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Wrap(
                        spacing: 10, // space between containers
                        runSpacing: 10, // space between lines
                        children: controller.data.roomFacilityList!
                            .map((item) => Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.2)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    item,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ))
                            .toList(),
                      )),
                ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Other Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Room is provided by the ${controller.data.roomOwnershipType}.',
                      ),
                      const SizedBox(height: 8), // Space between each text
                      Text(
                        'Total number of room - ${controller.data.totalRoom}',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Room is available - ${controller.data.isRoomAvailableDate}',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Notice period - ${controller.data.noticePride}',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Meals is available - ${controller.data.mealsAvailable}',
                      ),
                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              if (controller.data.commonAreasList!.isNotEmpty)
                const Text(
                  'Common area',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                spacing: 10, // space between containers
                runSpacing: 10, // space between lines
                children: controller.data.commonAreasList!.map((bill) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      bill,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 16,
              ),
              if (controller.data.billsList!.isNotEmpty)
                const Text(
                  'Bills',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                spacing: 10, // space between containers
                runSpacing: 10, // space between lines
                children: controller.data.billsList!.map((bill) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      bill,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 16,
              ),
              if (controller.data.houseRules!.isNotEmpty)
              Column(
                children: [
                  const Text(
                    'House Rules',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                      children: controller.data.houseRules!.map((rule) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.greenAccent,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(rule)
                            ],
                          ),
                        );
                      }).toList()),
                ],
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
                                  ApisClass.submitRoomReviewData(
                                      rating:
                                          controller.ratingNow.value.toString(),
                                      userReview:
                                          controller.reviewController.text,
                                      rId: controller.data.rId!);
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
              ReportCardWidgets(
                onTap: () => Get.toNamed(RoutesName.reportScreen,
                    arguments: [controller.data.rId!,'DevRoomCollection']),
              ),
              const SizedBox(
                height: 16,
              ),
              if (controller.data.houseFAQ!.isNotEmpty)
                const Text(
                  'FAQ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              Column(
                children: controller.data.houseFAQ!.map((faq) {
                  // Mapping each FAQ item to a FAQTile widget
                  return FAQWidgets(
                    question: faq.question!,
                    answer: faq.answer!,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
