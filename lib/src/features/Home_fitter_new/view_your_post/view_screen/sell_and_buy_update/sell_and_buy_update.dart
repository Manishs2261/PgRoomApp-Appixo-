import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/sell_and_buy_screen/model/buy_and_sell_model.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../../../res/route_name/routes_name.dart';
import '../../../../../utils/widgets/gradient_button.dart';
import '../../../../../utils/widgets/shimmer_effect.dart';
import 'controller/controller.dart';

class SellAndBuyUpdateList extends StatelessWidget {
  SellAndBuyUpdateList({super.key});

  final listOfSellAndBuyController = Get.put(SellAndBuyUpdateListController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - ListOfSellAndBuy......................................");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sell and Buy from',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      body: Obx(
        () => listOfSellAndBuyController.isLoadingInitial.value
            ? ListView.builder(
                // Shimmer effect during the initial load
                itemCount: 3, // Number of shimmer placeholders
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
                  listOfSellAndBuyController.sellAndBuyModel.clear();
                  listOfSellAndBuyController.lastDocument = null;
                  listOfSellAndBuyController.hasMoreData.value = true;
                  await listOfSellAndBuyController.fetchData();
                },
                indicatorBuilder:
                    (BuildContext context, IndicatorController controller) {
                  return const CircularProgressIndicator(
                    color: Colors.blue,
                  );
                },
                child: listOfSellAndBuyController.sellAndBuyModel.isEmpty &&
                        !listOfSellAndBuyController.isLoadingInitial.value
                    ? Center(
                        child: Text(
                          'No rooms available. Pull to refresh.',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: listOfSellAndBuyController
                                .isLoadingMore.value
                            ? listOfSellAndBuyController
                                    .sellAndBuyModel.length +
                                1
                            : listOfSellAndBuyController.sellAndBuyModel.length,
                        itemBuilder: (context, index) {
                          if (index ==
                                  listOfSellAndBuyController
                                      .sellAndBuyModel.length &&
                              listOfSellAndBuyController.isLoadingMore.value) {
                            return SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
                                ));
                          }
                          return SellAndBuyListCardWidgets(
                              buyAndSellModel: listOfSellAndBuyController
                                  .sellAndBuyModel[index]);
                        },
                      ),
              ),
      ),
    );
  }
}

class SellAndBuyListCardWidgets extends StatelessWidget {
  const SellAndBuyListCardWidgets({
    super.key,
    required this.buyAndSellModel,
  });

  final BuyAndSellModel buyAndSellModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Get.toNamed(RoutesName.sellAndBuyDetails, arguments: buyAndSellModel),
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
                      itemCount: buyAndSellModel.image?.length ?? 0,
                      itemBuilder: (context, imageIndex) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              width: Get.width * 0.8,
                              imageUrl:
                                  buyAndSellModel.image?[imageIndex] ?? '',
                              placeholder: (context, url) => ShimmerEffect(
                                  width: Get.width * 0.8, height: 140),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.image_outlined),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),

            const SizedBox(height: 12),
            // Room details
            Text(
              '${buyAndSellModel.itemName}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),
            // Room details
            Text(
              '₹ ${buyAndSellModel.price}/-',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 4),
            Text(
              '${buyAndSellModel.landmark},${buyAndSellModel.address},${buyAndSellModel.city},${buyAndSellModel.state}',
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
                  onPressed: () => Get.toNamed( RoutesName.sellAndBuyUpdateForm, arguments: buyAndSellModel),
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
            )
          ],
        ),
      ),
    );
  }
}
