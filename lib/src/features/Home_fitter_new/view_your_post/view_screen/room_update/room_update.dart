import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/room_collection.dart';
import 'package:pgroom/src/features/Rooms_screen_new/model/room_model.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'package:pgroom/src/utils/widgets/shimmer_effect.dart';

import '../../../../../res/route_name/routes_name.dart';
import '../../../../../utils/widgets/gradient_button.dart';
import 'controller/controller.dart';

class RoomUpdateList extends StatelessWidget {
  RoomUpdateList({super.key});

  final listOfRoomController = Get.put(RoomUpdateListController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug('ListOfRooms........');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooms'),
      ),
      body: Obx(
        () => listOfRoomController.isLoadingInitial.value
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
                        itemCount: listOfRoomController.isLoadingMore.value
                            ? listOfRoomController.roomListData.length + 1
                            : listOfRoomController.roomListData.length,
                        itemBuilder: (context, index) {
                          if (index ==
                                  listOfRoomController.roomListData.length &&
                              listOfRoomController.isLoadingMore.value) {
                            return SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
                                ));
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
   RoomListCardWidgets({
    super.key,
    required this.roomListData,
  });

  final RoomModel roomListData;
  final listOfRoomController = Get.put(RoomUpdateListController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(RoutesName.roomDetails, arguments: roomListData),
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
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: roomListData.imageList?.length ?? 0,
                  itemBuilder: (context, imageIndex) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          width: Get.width * 0.8,
                          imageUrl: roomListData.imageList?[imageIndex] ?? '',
                          placeholder: (context, url) => ShimmerEffect(
                              width: Get.width * 0.8, height: 140),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.image_outlined),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
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
            SizedBox(height: 16),
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
                  onPressed: ()=>Get.toNamed(RoutesName.editRoomPostList, arguments: roomListData),
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirm Delete'),
                          content: Text('Are you sure you want to delete this item?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                ApisClass.deleteRoomData(documentId: roomListData.rId!, imageUrls: roomListData.imageList!).whenComplete(() async {
                                listOfRoomController.roomListData.clear();
                                    listOfRoomController.lastDocument = null;
                                    listOfRoomController.hasMoreData.value = true;
                                    await listOfRoomController.fetchData();
                                });
                                // Perform the delete action here
                              },
                              child: Text('Delete', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        );
                      },
                    );
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
