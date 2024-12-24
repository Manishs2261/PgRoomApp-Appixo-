import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/sell_and_buy_screen/model/buy_and_sell_model.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../data/repository/apis/apis.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../../utils/widgets/gradient_button.dart';
import '../../../utils/widgets/top_search_bar/controller/controller.dart';
import '../../../utils/widgets/top_search_bar/top_search_bar.dart';

class ListOfSellAndBuy extends StatefulWidget {
  ListOfSellAndBuy({super.key});

  @override
  State<ListOfSellAndBuy> createState() => _ListOfSellAndBuyState();
}

class _ListOfSellAndBuyState extends State<ListOfSellAndBuy>
    with SingleTickerProviderStateMixin {
  List<BuyAndSellModel> buyAndSellList = [];
  final searchController = Get.put(TopSearchBarController());
  late ScrollController _scrollController;
  final RxBool _isButtonVisible = true.obs;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        // Scrolling down
        if (_isButtonVisible.value) {
          _isButtonVisible.value = false;
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        // Scrolling up
        if (!_isButtonVisible.value) {
          _isButtonVisible.value = true;
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - ListOfSellAndBuy......................................");
    return Scaffold(
      //==PreferredSize provide a maximum appbar length

      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: SafeArea(child: TopSearchFilter())),

      floatingActionButton: Obx(
        () => AnimatedOpacity(
          opacity: _isButtonVisible.value ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: _isButtonVisible.value
              ? FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  ),
                )
              : SizedBox(),
        ),
      ),
      body: CustomMaterialIndicator(
        onRefresh: () async {
          return await Future.delayed(const Duration(seconds: 2));
        },
        indicatorBuilder:
            (BuildContext context, IndicatorController controller) {
          return const Icon(
            Icons.refresh,
            color: Colors.blue,
            size: 30,
          );
        },
        child: StreamBuilder(
            stream: ApisClass.firebaseFirestore
                .collection('DevBuyAndSellCollection')
                .snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.signal_wifi_connected_no_internet_4),
                        Text("No Internet Connection"),
                        SizedBox(
                          height: 10,
                        ),
                        CircularProgressIndicator(
                          color: Colors.blue,
                        )
                      ],
                    ),
                  );
                case ConnectionState.none:
                  return const Center(
                    child: Row(
                      children: [
                        Icon(Icons.signal_wifi_connected_no_internet_4),
                        Text("No Internet Connection"),
                        CircularProgressIndicator(
                          color: Colors.blue,
                        )
                      ],
                    ),
                  );

                case ConnectionState.active:
                case ConnectionState.done:
                  final data = snapshot.data?.docs;

                  buyAndSellList = data
                          ?.map((e) => BuyAndSellModel.fromJson(e.data()))
                          .toList() ??
                      [];

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: buyAndSellList.length,
                    itemBuilder: (context, index) {
                      print('${buyAndSellList[index].atUpdate}');
                      return InkWell(
                        onTap: () => Get.toNamed(RoutesName.sellAndBuyDetails,
                            arguments: buyAndSellList[index]),
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 12, left: 12, right: 12),
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
                              Container(
                                height: 200,
                                // Set a fixed height for the PageView
                                child: Stack(
                                  children: [
                                    ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: buyAndSellList[index]
                                                .image
                                                ?.length ??
                                            0,
                                        itemBuilder: (context, imageIndex) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: CachedNetworkImage(
                                                width: Get.width * 0.8,
                                                imageUrl: buyAndSellList[index]
                                                        .image?[imageIndex] ??
                                                    '',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        }),
                                    Positioned(
                                      top: 1,
                                      left: 1,
                                      child: Container(
                                          margin: const EdgeInsets.all(8),
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: false
                                              ? const Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                )
                                              : const Icon(
                                                  Icons
                                                      .favorite_border_outlined,
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
                                '${buyAndSellList[index].itemName}',
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
                                '₹ ${buyAndSellList[index].price}/-',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              const SizedBox(height: 4),
                              Text(
                                '${buyAndSellList[index].landmark},${buyAndSellList[index].address},${buyAndSellList[index].city},${buyAndSellList[index].state}',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Update',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white70,
                                                ),
                                              ),
                                              Text(
                                                AppHelperFunction
                                                    .printFormattedDate(
                                                        buyAndSellList[index]
                                                            .atUpdate!),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
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
                    },
                  );
              }
            }),
      ),
    );
  }
}
