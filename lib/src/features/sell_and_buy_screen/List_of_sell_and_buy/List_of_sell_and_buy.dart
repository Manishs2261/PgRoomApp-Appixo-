import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pgroom/src/features/sell_and_buy_screen/model/buy_and_sell_model.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../data/repository/apis/apis.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../utils/Constants/colors.dart';
import '../../../utils/helpers/helper_function.dart';

class ListOfSellAndBuy extends StatelessWidget {
   ListOfSellAndBuy({super.key});

  List<BuyAndSellModel> buyAndSellList = [];

  var snapData;

  int currentPage = 0;



  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - ListOfSellAndBuy......................................");
    return Scaffold(
      //==PreferredSize provide a maximum appbar length
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(155),
          child: SafeArea(child: TopSearchFilter())),

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
                  snapData = snapshot;

                  buyAndSellList = data
                          ?.map((e) => BuyAndSellModel.fromJson(e.data()))
                          .toList() ??
                      [];

                  return ListView.builder(
                    //  controller: _scrollController,
                    itemCount: buyAndSellList.length,
                    itemBuilder: (context, index) {
                      print('${buyAndSellList[index].atUpdate}');
                      return InkWell(
                        onTap: () => Get.toNamed(RoutesName.sellAndBuyDetails, arguments: buyAndSellList[index]),
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
                                                AppHelperFunction.printFormattedDate(buyAndSellList[index].atUpdate!),
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

class GradientButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<Color> colors;
  final VoidCallback onPressed;

  GradientButton({
    required this.icon,
    required this.label,
    required this.colors,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors, // Button gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 16, // White icon
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                  color: Colors.white, // White text
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class TopSearchFilter extends StatelessWidget {
  const TopSearchFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey.shade200, boxShadow: [
        BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 4,
            offset: const Offset(1, 2))
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                ),
              ),
              const Icon(
                Icons.search_rounded,
                color: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text.rich(
            style: TextStyle(fontSize: 12),
            TextSpan(
              text: 'Awesome! ',
              children: <TextSpan>[
                TextSpan(
                  text: '8',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: ' results found.'),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 12),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.07),
                borderRadius: BorderRadius.circular(12)),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
                Text(
                  'Add Location',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              children: [
                const Text(
                  'Bilaspur',
                  style: TextStyle(
                    fontSize: 14,
                    height: 0,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                    backgroundColor: Colors.blueAccent.withOpacity(0.1),
                    radius: 8,
                    child: const Icon(
                      Icons.close,
                      color: AppColors.primary,
                      size: 14,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
