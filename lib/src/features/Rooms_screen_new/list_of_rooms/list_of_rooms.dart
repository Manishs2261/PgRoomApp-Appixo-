import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/Rooms_screen_new/list_of_rooms/controller/controller.dart';
import 'package:pgroom/src/features/Rooms_screen_new/model/room_model.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'package:pgroom/src/utils/widgets/shimmer_effect.dart';

import '../../../res/route_name/routes_name.dart';
import '../../../utils/widgets/gradient_button.dart';
import '../../../utils/widgets/top_search_bar/top_search_bar.dart';
import '../../Home_fitter_new/new_search_home/controller.dart';

class ListOfRooms extends StatelessWidget {
  ListOfRooms({super.key});

  final listOfRoomController = Get.put( ListOfRoomController());

  @override
  Widget build(BuildContext context) {

    AppLoggerHelper.debug('ListOfRooms........');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: SafeArea(child: TopSearchFilter()),
      ),
      floatingActionButton: Obx(
            () => AnimatedOpacity(
          opacity: listOfRoomController.isButtonVisible.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: listOfRoomController.isButtonVisible.value
              ? FloatingActionButton(
            onPressed: (){
                showModalBottomSheet(
                    context: context,
                    builder: (builder){
                      return Container(
                        height: 350.0,
                        color: Colors.transparent, //could change this to Color(0xFF737373),
                        //so you don't have to change MaterialApp canvasColor
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(10.0),
                                    topRight: const Radius.circular(10.0))),
                            child:  ListView(
                              children: [

                              ],
                            )

                        ),
                      );
                    }
                );

            },
            backgroundColor: AppColors.primary,
            child: const Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
          )
              : const SizedBox(),
        ),
      ),
      body: Obx(
            () => listOfRoomController.isLoadingInitial.value
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

              durations:RefreshIndicatorDurations(settleDuration: Duration(milliseconds: 1000)),
          onRefresh: () async {
            listOfRoomController.roomListData.clear();
            listOfRoomController.lastDocument = null;
            listOfRoomController.hasMoreData.value = true;

            await listOfRoomController.fetchData();
          },
          indicatorBuilder:
              (BuildContext context, IndicatorController controller) {
            return const CircularProgressIndicator(
              color: Colors.blue,
            );
          },
          child: listOfRoomController.roomListData.isEmpty &&
              !listOfRoomController.isLoadingMore.value
              ? Center(
            child: Text(
              'No rooms available. Pull to refresh.',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          )
              : ListView.builder(
            controller: listOfRoomController.scrollController,
            itemCount: listOfRoomController.isLoadingMore.value
                ? listOfRoomController.roomListData.length + 1
                : listOfRoomController.roomListData.length,
            itemBuilder: (context, index) {
              if (index == listOfRoomController.roomListData.length &&
                  listOfRoomController.isLoadingMore.value) {
                return  SizedBox(
                  height: 40,
                    width: 40,
                    child: CircularProgressIndicator(color: Colors.amber, ));
              }
              return RoomListCardWidgets(
                  roomListData:
                  listOfRoomController.roomListData[index]);
            },
          ),
        ),
      ),
    );
  }
}



class RoomListCardWidgets extends StatelessWidget {
  const RoomListCardWidgets({
    super.key,
    required this.roomListData,
  });

  final RoomModel roomListData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(RoutesName.roomDetails,
          arguments: roomListData),
      child: Container(
        margin: EdgeInsets.only(top: 12, left: 12, right: 12),
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
            SizedBox(
              height: 140,
              // Set a fixed height for the PageView
              child: Stack(
                children: [
                  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: roomListData.imageList?.length ?? 0,
                      itemBuilder: (context, imageIndex) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              width: Get.width * 0.8,
                              imageUrl:
                                  roomListData.imageList?[imageIndex] ?? '',
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
            SizedBox(height: 12),
            // Room details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${roomListData.singlePersonCost.toString()}/-',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.blueAccent,
                  ),
                  child: Text(
                    '${roomListData.genderType}',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${roomListData.houseName?.capitalizeFirst}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.amber,
                  ),
                  child: Text(
                    '${roomListData.roomCategory}',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${roomListData.roomType?.capitalizeFirst}',
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
              '${roomListData.landmark}, ${roomListData.homeAddress}, ${roomListData.city}, ${roomListData.state}',
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: CachedNetworkImage(
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                                imageUrl: roomListData.userImage.toString(),
                                progressIndicatorBuilder:
                                    (context, url, progress) =>
                                        const ShimmerEffect(
                                            height: 40,
                                            width: 40,
                                            borderRadius: 24),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${roomListData.userName?.capitalizeFirst}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
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
                              'Updated',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              AppHelperFunction.printFormattedDate(
                                  roomListData.atUpdate.toString()),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Chat Now Button with Gradient
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
