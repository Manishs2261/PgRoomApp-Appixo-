import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/foods_screen_new/model/food_model.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../utils/widgets/com_reuse_elevated_button.dart';
import '../../../utils/widgets/gradient_button.dart';
import '../../../utils/widgets/shimmer_effect.dart';
import '../../../utils/widgets/top_search_bar/top_search_bar.dart';
import 'controller/controller.dart';

class ListOfFoods extends StatelessWidget {
  ListOfFoods({super.key});

  final listOfFoodController = Get.put(ListOfFoodController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - ListOfFoodsScreen..........................");
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: SafeArea(child: TopSearchFilter())),
      floatingActionButton: Obx(
        () => AnimatedOpacity(
          opacity: listOfFoodController.isButtonVisible.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: listOfFoodController.isButtonVisible.value
              ? FoodFilterWidgets(listOfFoodController: listOfFoodController)
              : const SizedBox(),
        ),
      ),
      body: Obx(
        () => listOfFoodController.isLoadingInitial.value
            ? ListView.builder(
                // Shimmer effect during the initial load
                itemCount: 2, // Number of shimmer placeholders
                itemBuilder: (context, index) {
                  return ShimmerEffect(
                    width: double.infinity,
                    height: 200,
                    bottomShimmer: true,
                    bottomWidth: double.infinity,
                    bottomHeight: 20,
                  );
                },
              )
            : CustomMaterialIndicator(
                durations: RefreshIndicatorDurations(
                    settleDuration: Duration(milliseconds: 1000)),
                onRefresh: () async {
                  listOfFoodController.foodListData.clear();
                  listOfFoodController.lastDocument = null;
                  listOfFoodController.hasMoreData.value = true;
                  await listOfFoodController.fetchData();
                },
                indicatorBuilder:
                    (BuildContext context, IndicatorController controller) {
                  return const CircularProgressIndicator(
                    color: Colors.blue,
                  );
                },
                child: listOfFoodController.foodListData.isEmpty &&
                        !listOfFoodController.isLoadingMore.value
                    ? Center(
                        child: Text(
                          'No rooms available. Pull to refresh.',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        controller: listOfFoodController.scrollController,
                        itemCount: listOfFoodController.isLoadingMore.value
                            ? listOfFoodController.foodListData.length + 1
                            : listOfFoodController.foodListData.length,
                        itemBuilder: (context, index) {
                          if (index ==
                                  listOfFoodController.foodListData.length &&
                              listOfFoodController.isLoadingMore.value) {
                            return SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
                                ));
                          }
                          return FoodListCardWidgets(
                            foodModel: listOfFoodController.foodListData[index],
                          );
                        },
                      ),
              ),
      ),
    );
  }
}

class FoodListCardWidgets extends StatelessWidget {
  const FoodListCardWidgets({
    super.key,
    required this.foodModel,
  });

  final FoodModel foodModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(RoutesName.foodDetails, arguments: foodModel),
      child: Container(
        margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Slider
            SizedBox(
              height: 140,
              // Set a fixed height for the PageView
              child: Stack(
                children: [
                  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: foodModel.imageList?.length ?? 0,
                      itemBuilder: (context, imageIndex) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              width: Get.width * 0.8,
                              imageUrl: foodModel.imageList?[imageIndex] ?? '',
                              placeholder: (context, url) => ShimmerEffect(
                                  width: Get.width * 0.8, height: 140),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.image_outlined),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                  Positioned(
                    top: 1,
                    left: 1,
                    child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: false
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.white,
                                size: 20,
                              )),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Room details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${foodModel.shopName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.green,
                  ),
                  child: Text(
                    '${foodModel.foodCategory}',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),
            const Row(
              children: [
                Icon(
                  Icons.star,
                  size: 18,
                  color: Colors.orange,
                ),
                Gap(4),
                Text(
                  "2.5",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),

            const SizedBox(height: 4),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.green,
              ),
              child: Text(
                '${foodModel.typeOfShop}',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${foodModel.landmark} ${foodModel.address}, ${foodModel.city}, ${foodModel.state}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 16),
            // Buttons for "Chat Now" and "Call Now"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Chat Now Button with Gradient
                GradientButton(
                  icon: Icons.chat,
                  label: 'Chat Now',
                  colors: const [Colors.orange, Colors.red],
                  onPressed: () {
                    // Handle chat action
                  },
                ),
                // Call Now Button with Gradient
                GradientButton(
                  icon: Icons.phone,
                  label: 'Call Now',
                  colors: const [Colors.green, Colors.teal],
                  onPressed: () {
                    // Handle call action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FoodFilterWidgets extends StatelessWidget {
  const FoodFilterWidgets({
    super.key,
    required this.listOfFoodController,
  });

  final ListOfFoodController listOfFoodController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: AppColors.white,
          context: context,
          builder: (context) {
            return DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.3,
                maxChildSize: 0.9,
                expand: false,
                builder: (builder, scrollController) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'I am looking to:',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Obx(
                              () => Wrap(
                                spacing: 8,
                                children: listOfFoodController.foodType
                                    .map(
                                      (type) => FilterChip(
                                        label: Text(type),
                                        labelStyle: TextStyle(
                                            color: listOfFoodController
                                                        .selectedFood ==
                                                    type
                                                ? Colors.white
                                                : Colors.black),
                                        selected:
                                            listOfFoodController.selectedFood ==
                                                type,
                                        selectedColor: AppColors.primary,
                                        backgroundColor:
                                            Colors.blue.withOpacity(0.08),
                                        // Set color to blue when selected
                                        onSelected: (selected) {
                                          if (selected) {
                                            listOfFoodController
                                                .selectedFood?.value = type;
                                          } else {
                                            listOfFoodController
                                                    .selectedFood?.value =
                                                ''; // Deselect when tapped again
                                          }
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Obx(
                              () => Visibility(
                                visible: (listOfFoodController.selectedFood ==
                                    'Mess'),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Mess Type',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Obx(
                                      () => Wrap(
                                        spacing: 8,
                                        children: listOfFoodController.messType
                                            .map(
                                              (type) => FilterChip(
                                                label: Text(type),
                                                labelStyle: TextStyle(
                                                    color: listOfFoodController
                                                                .selectedMessType ==
                                                            type
                                                        ? Colors.white
                                                        : Colors.black),
                                                selected: listOfFoodController
                                                        .selectedMessType ==
                                                    type,
                                                selectedColor:
                                                    AppColors.primary,
                                                backgroundColor: Colors.blue
                                                    .withOpacity(0.08),
                                                // Set color to blue when selected
                                                onSelected: (selected) {
                                                  if (selected) {
                                                    listOfFoodController
                                                        .selectedMessType
                                                        ?.value = type;
                                                  } else {
                                                    listOfFoodController
                                                            .selectedMessType
                                                            ?.value =
                                                        ''; // Deselect when tapped again
                                                  }
                                                },
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        child: ReuseElevButton(
                            onPressed: () {
                              Get.toNamed(RoutesName.listOfRooms);
                            },
                            title: 'Apply Filter'),
                      ),
                    ],
                  );
                });
          },
        );

        //===
      },
      backgroundColor: AppColors.primary,
      child: const Icon(
        Icons.filter_list,
        color: Colors.white,
      ),
    );
  }
}
