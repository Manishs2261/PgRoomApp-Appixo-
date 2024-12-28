import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/foods_screen_new/model/food_model.dart';
import 'package:pgroom/src/features/room_rent_all_screen/home/Controller/home_page_controller.dart';
import 'package:pgroom/src/features/room_rent_all_screen/home/widgets/ItemListView.dart';
import 'package:pgroom/src/features/room_rent_all_screen/home/widgets/appbar_widgets.dart';
import 'package:pgroom/src/features/sell_and_buy_screen/model/buy_and_sell_model.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/Constants/image_string.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../data/repository/apis/apis.dart';
import '../../../model/user_rent_model/user_rent_model.dart';
import '../../../utils/widgets/gradient_button.dart';
import '../../../utils/widgets/top_search_bar/top_search_bar.dart';
import '../../Home_fitter_new/new_search_home/new_home_screen.dart';
import '../../Rooms_screen_new/list_of_rooms/list_of_rooms.dart';
import '../foods_details_screen/food_details_screen.dart';

class ListOfFoods extends StatefulWidget {
  const ListOfFoods({super.key});

  @override
  State<ListOfFoods> createState() => _ListOfFoodsState();
}

class _ListOfFoodsState extends State<ListOfFoods> {
  List<FoodModel> foodList  = [];

  int currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - ListOfSellAndBuy......................................");
    return Scaffold(
      //==PreferredSize provide a maximum appbar length
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: SafeArea(child: TopSearchFilter())),

      //======drawer code ===============
      // drawer:  DrawerScreen(),
      //=======list view builder code==============
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
                .collection('DevFoodCollection')
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

                  foodList = data
                      ?.map((e) => FoodModel .fromJson(e.data()))
                      .toList() ??
                      [];

                  return
     ListView.builder(
    //controller: _scrollController,
    itemCount: foodList.length,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () => Get.toNamed(RoutesName.foodDetails,
            arguments:   foodList[index]),
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
              Container(
                height: 200, // Set a fixed height for the PageView
                child: Stack(
                  children: [
                    ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:  foodList[index]
                            .image
                            ?.length ??
                            0,
                        itemBuilder: (context, imageIndex) {

                          print(foodList[index]
                              .image![imageIndex]);
                          return Padding(
                            padding:
                            const EdgeInsets.only(right: 8),
                            child: ClipRRect(
                              borderRadius:
                              BorderRadius.circular(10.0),
                              child: CachedNetworkImage(
                                width: Get.width * 0.8,
                                imageUrl:  foodList[index]
                                    .image![imageIndex],
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
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: false ? const Icon(
                            Icons.favorite, color: Colors.red,) : const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,)
                      ),
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
                      '${foodList[index].shopName}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.green,
                    ),
                    child:  Text(
                      '${foodList[index].foodCategory}',
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
                  '${foodList[index].typeOfShop}',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              const SizedBox(height: 4),
               Text(
                 '${foodList[index].landmark} ${foodList[index].address}, ${foodList[index].city}, ${foodList[index].state}',
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
    );


              }
            }),
      ),
    );
  }
}
