import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/food_collection.dart';
import 'package:pgroom/src/features/foods_screen_new/foods_details_screen/controller/controller.dart';
import 'package:pgroom/src/features/foods_screen_new/model/food_model.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/widgets/faq_widgets.dart';

import '../../../data/repository/apis/room_collection.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../utils/Constants/colors.dart';
import '../../../utils/widgets/bottom_chat_and_call_widgets.dart';
import '../../../utils/widgets/com_ratingbar_widgets.dart';
import '../../../utils/widgets/report_card_widgets.dart';
import '../../../utils/widgets/review_view_card.dart';
import '../../../utils/widgets/space_between_text.dart';
import '../../../utils/widgets/submit_review_widgets.dart';
import '../../../utils/widgets/view_map_card_widgets.dart';

class DetailsFood extends StatefulWidget {
  const DetailsFood({super.key});

  @override
  State<DetailsFood> createState() => _DetailsFoodState();
}

class _DetailsFoodState extends State<DetailsFood> {

  final controller = Get.put(DetailsFoodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          controller.data.shopName.toString(),
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
                      itemCount: controller.data.imageList?.length,
                      onPageChanged: (int page) {
                        setState(() {
                          controller.currentPage.value = page;
                        });
                      },
                      itemBuilder: (context, imageIndex) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              imageUrl: controller.data.imageList?[imageIndex] ?? '',
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
                          '${controller.currentPage.value + 1}/ ${controller.data.imageList?.length}',
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
                  Expanded(
                    child: Text(
                      '${controller.data.shopName}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500, height: 0),
                    ),
                  ),
                  ReUseTextContainer(
                    title: controller.data.foodCategory.toString(),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '${controller.data.description}',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 16,
              ),
              ReUseTextContainer(
                title: '${controller.data.typeOfShop}',
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                color: Colors.blue,
              ),
              const SizedBox(
                height: 16,
              ),
              ViewMapCardWidgets(
                landmark: controller.data.landmark.toString(),
                homeAddress: controller.data.address.toString(),
                city: controller.data.city.toString(),
                state: controller.data.state.toString(),
                latitude: controller.data.state.toString(),
                longitude: controller.data.longitude.toString(),
              ),
              const SizedBox(
                height: 16,
              ),
              Visibility(
                visible: controller.data.typeOfShop.toString() == 'Mess' ||
                    controller.data.typeOfShop.toString() == 'Home Mess',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Subscription',
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
                          if (controller.data.breakfastCost!.isNotEmpty)
                            SpaceBetweenText(
                              title: 'Breakfast',
                              cost: controller.data.breakfastCost.toString(),
                            ),
                          if (controller.data.lunchOrDinnerCost!.isNotEmpty)
                            SpaceBetweenText(
                              title: 'Lunch OR Dinner',
                              cost: controller.data.lunchOrDinnerCost.toString(),
                            ),
                          if (controller.data.lunchAndDinnerCost!.isNotEmpty)
                            SpaceBetweenText(
                              title: 'Lunch & Dinner',
                              cost: controller.data.lunchAndDinnerCost.toString(),
                            ),
                          if (controller.data.breakfastAndLunchOrDinnerCost!.isNotEmpty)
                            SpaceBetweenText(
                              title: 'Breakfast, Lunch & Dinner',
                              cost:
                              controller.data.breakfastAndLunchOrDinnerCost.toString(),
                            ),
                          if (controller.data.subscriptionList!.isNotEmpty)
                            Column(
                              children: controller.data.subscriptionList!.map((room) {
                                return SpaceBetweenText(
                                  title: room.name.toString().capitalizeFirst!,
                                  cost: room.price.toString(),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Visibility(
                visible: controller.data.dailyItemList!.isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Daily meals',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 1.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(),
                        child: Column(
                          children: controller.data.dailyItemList!.map((room) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        room.name.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '₹${room.price}/-',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400, fontSize: 14),
                                    ),
                                  ],
                                ),
                                const Divider(),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: controller.data.restructureMenuList!.isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Food Menu',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 1.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(),
                        child: Column(
                          children: controller.data.restructureMenuList!.map((room) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        room.name.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '₹${room.price}/-',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400, fontSize: 14),
                                    ),
                                  ],
                                ),
                                const Divider(),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: controller.data.messRules!.isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mess Rules',
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
                        children: controller.data.messRules!.map((rule) {
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
                                Expanded(child: Text(rule))
                              ],
                            ),
                          );
                        }).toList()),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SubmitReviewWidgets(
                onTap: () {
                  String review = '';
                  reviewShowDialog(review);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              const Row(
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
                  Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
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
                    arguments: [controller.data.fId,'DevFoodCollection']),
              ),
              const SizedBox(
                height: 16,
              ),
             Visibility(
               visible: controller.data.fAQ!.isNotEmpty,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const Text(
                     'FAQ',
                     style: TextStyle(
                       fontSize: 16,
                       fontWeight: FontWeight.w500,
                       color: Colors.black,
                     ),
                   ),
                   Column(
                     children: controller.data.fAQ!.map((faq) {
                       // Mapping each FAQ item to a FAQTile widget
                       return FAQWidgets(
                         question: faq.question!,
                         answer: faq.answer!,
                       );
                     }).toList(),
                   ),
                 ],
               ),
             )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> reviewShowDialog(String review) {
    return showDialog(
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
                                TiffineServicesApis.submitFoodReviewData(
                                    rating:
                                    controller.ratingNow.value.toString(),
                                    userReview:
                                    controller.reviewController.text,
                                    fId: controller.data.fId!);
                              }

                              Navigator.of(context).pop();
                            }),
                      ],
                    );
                  },
                );
  }
}

class ReUseTextContainer extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color color;
  final Color textColor;
  final double fontSize;
  final String title;

  const ReUseTextContainer({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    this.radius = 4.0,
    this.color = Colors.green,
    this.textColor = Colors.white,
    this.fontSize = 12.0,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: Text(
        title,
        style: TextStyle(color: textColor, fontSize: fontSize),
      ),
    );
  }
}
