import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/sell_and_buy_screen/model/buy_and_sell_model.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../res/route_name/routes_name.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../../utils/widgets/gradient_button.dart';
import '../../../utils/widgets/shimmer_effect.dart';
import '../../../utils/widgets/top_search_bar/controller/controller.dart';
import '../../../utils/widgets/top_search_bar/top_search_bar.dart';
import 'controller/controller.dart';

class ListOfSellAndBuy extends StatelessWidget {
  ListOfSellAndBuy({super.key});

  final listOfSellAndBuyController = Get.put(SellAndBuyListController());

  final searchController = Get.put(TopSearchBarController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - ListOfSellAndBuy......................................");
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: SafeArea(child: TopSearchFilter())),

      // floatingActionButton: Obx(
      //   () => AnimatedOpacity(
      //     opacity: _isButtonVisible.value ? 1.0 : 0.0,
      //     duration: Duration(milliseconds: 500),
      //     child: _isButtonVisible.value
      //         ? FloatingActionButton(
      //             onPressed: () {},
      //             backgroundColor: AppColors.primary,
      //             child: Icon(
      //               Icons.filter_list,
      //               color: Colors.white,
      //             ),
      //           )
      //         : SizedBox(),
      //   ),
      // ),
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
                        controller: listOfSellAndBuyController.scrollController,
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
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.black, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://plus.unsplash.com/premium_photo-1668127295858-552a0ef56309?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Z2lybCUyMGltYWdlc3xlbnwwfHwwfHx8MA%3D%3D'),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'John Doe',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Update',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              AppHelperFunction.printFormattedDate(
                                  buyAndSellModel.atUpdate!),
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Buttons for "Chat Now" and "Call Now"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //  Chat Now Button with Gradient
                        GradientButton(
                          icon: Icons.chat,
                          label: 'Chat Now',
                          colors: [Colors.orange, Colors.red],
                          onPressed: () {
                            // Handle chat action
                          },
                        ),
                        // Call Now Button with Gradient
                        GradientButton(
                          icon: Icons.phone,
                          label: 'Call Now',
                          colors: [Colors.green, Colors.teal],
                          onPressed: () {
                            // Handle call action
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
