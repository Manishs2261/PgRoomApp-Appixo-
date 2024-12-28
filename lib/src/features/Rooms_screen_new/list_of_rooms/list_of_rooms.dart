import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/Rooms_screen_new/model/room_model.dart';
import 'package:pgroom/src/features/room_rent_all_screen/home/Controller/home_page_controller.dart';
import 'package:pgroom/src/features/room_rent_all_screen/home/widgets/ItemListView.dart';
import 'package:pgroom/src/features/room_rent_all_screen/home/widgets/appbar_widgets.dart';
import 'package:pgroom/src/features/sell_and_buy_screen/model/buy_and_sell_model.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/Constants/image_string.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../data/repository/apis/apis.dart';
import '../../../model/user_rent_model/user_rent_model.dart';
import '../../../utils/widgets/gradient_button.dart';
import '../../../utils/widgets/top_search_bar/controller/controller.dart';
import '../../../utils/widgets/top_search_bar/top_search_bar.dart';
import '../../Home_fitter_new/new_search_home/new_home_screen.dart';
import '../../Rooms_screen_new/list_of_rooms/list_of_rooms.dart';
import '../details_rooms/details_room.dart';

class ListOfRooms extends StatefulWidget {
  const ListOfRooms({super.key});

  @override
  State<ListOfRooms> createState() => _ListOfRoomsState();
}

class _ListOfRoomsState extends State<ListOfRooms> {
  List<RoomModel> roomListData = [];

  int currentPage = 0;

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
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: ApisClass.firebaseFirestore
                .collection('DevRoomCollection')
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



               ///   for creating json model

                  // for (var i in data!) {
                  //   try {
                  //     // Extracting the data and ensuring it's JSON serializable
                  //     var jsonData = i.data();
                  //     if (jsonData is Map<String, dynamic>) {
                  //       log("Data: ${jsonEncode(jsonData)}");
                  //     } else {
                  //       log("Data: Unable to serialize as JSON: $jsonData");
                  //     }
                  //   } catch (e) {
                  //     log("Error serializing data: $e");
                  //   }
                  // }


                  roomListData = data
                          ?.map((e) => RoomModel.fromJson(e.data()))
                          .toList() ??
                      [];

                  return ListView.builder(
                      controller: _scrollController,
                      itemCount: roomListData.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Get.toNamed(RoutesName.roomDetails,
                              arguments:  roomListData[index]),
                          child: Container(
                            margin:
                                EdgeInsets.only(top: 12, left: 12, right: 12),
                            // You can adjust this height to fit the content
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image Slider
                                Container(
                                  height: 140,
                                  // Set a fixed height for the PageView
                                  child: Stack(
                                    children: [
                                      ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:  roomListData[index]
                                              .imageList
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
                                                  imageUrl:  roomListData[index]
                                                      .imageList?[imageIndex] ??
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
                                            margin: EdgeInsets.all(8),
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: false
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  )
                                                : Icon(
                                                    Icons
                                                        .favorite_border_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12),
                                // Room details
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '₹${roomListData[index].singlePersonCost.toString()}/-',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.blueAccent,
                                      ),
                                      child: Text(
                                        '${roomListData[index].genderType}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${roomListData[index].houseName?.capitalizeFirst}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.amber,
                                      ),
                                      child: Text(
                                        '${roomListData[index].roomCategory}',
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${roomListData[index].roomType?.capitalizeFirst}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.green,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 18,
                                          color: Colors.orange,
                                        ),
                                        const Gap(4),
                                        Text(
                                          "2.5",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: 4),
                                Text(
                                  '${roomListData[index].landmark}, ${roomListData[index].homeAddress}, ${roomListData[index].city}, ${roomListData[index].state}',
                                   maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(height: 4),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black,
                                          Colors.blueAccent
                                        ],
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
                                                  radius: 16,
                                                  backgroundImage: NetworkImage(
                                                      'https://plus.unsplash.com/premium_photo-1668127295858-552a0ef56309?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Z2lybCUyMGltYWdlc3xlbnwwfHwwfHx8MA%3D%3D'),
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  'John Doe',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12,
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
                                                  'Updated',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                                Text(
                                                  '${AppHelperFunction.printFormattedDate(roomListData[index].atUpdate.toString())}',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white70,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        // Buttons for "Chat Now" and "Call Now"
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // Chat Now Button with Gradient
                                            GradientButton(
                                              icon: Icons.chat,
                                              label: 'Chat Now',
                                              colors: [
                                                Colors.orange,
                                                Colors.red
                                              ],
                                              onPressed: () {
                                                // Handle chat action
                                              },
                                            ),
                                            // Call Now Button with Gradient
                                            GradientButton(
                                              icon: Icons.phone,
                                              label: 'Call Now',
                                              colors: [
                                                Colors.green,
                                                Colors.teal
                                              ],
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
                      });
              }
            }),
      ),
    );
  }
}
