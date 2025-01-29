import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/foods_screen_new/model/food_model.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import '../../../../../utils/widgets/gradient_button.dart';
import '../../../../../utils/widgets/shimmer_effect.dart';
import 'controller/controller.dart';

class FoodUpdateList extends StatelessWidget {
  FoodUpdateList({super.key});

  final listOfFoodController = Get.put(FoodUpdateListController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - ListOfFoodsScreen..........................");
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Food',style: TextStyle(fontWeight: FontWeight.w400),),
      ) ,

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
                  icon: Icons.edit,
                  iconColor: Colors.blue,
                  label: 'Edit',
                  colors: const [Colors.transparent, Colors.transparent],
                  borderColor: Colors.blue,
                  textColor: Colors.blue,
                  onPressed: () => Get.toNamed(RoutesName.firstFoodUpdateForm, arguments: foodModel),
                ),
                // Call Now Button with Gradient
                GradientButton(
                  icon: Icons.delete,
                  iconColor: Colors.red,
                  label: 'Delete',
                  textColor: Colors.red,
                  borderColor: Colors.red,
                  colors: const [Colors.transparent, Colors.transparent],
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


