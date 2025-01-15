import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/Rooms_screen_new/list_of_rooms/controller/controller.dart';
import 'package:pgroom/src/features/Rooms_screen_new/model/room_model.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'package:pgroom/src/utils/widgets/shimmer_effect.dart';

import '../../../res/route_name/routes_name.dart';
import '../../../utils/widgets/com_reuse_elevated_button.dart';
import '../../../utils/widgets/top_search_bar/top_search_bar.dart';
import '../../../utils/widgets/user_contact_list_card_widgets.dart';

class ListOfRooms extends StatelessWidget {
  ListOfRooms({super.key});

  final listOfRoomController = Get.put(ListOfRoomController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug('ListOfRooms........');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SafeArea(child: TopSearchFilter()),
      ),
      floatingActionButton: Obx(
        () => AnimatedOpacity(
          opacity: listOfRoomController.isButtonVisible.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: listOfRoomController.isButtonVisible.value
              ? RoomFilterWidgets(listOfRoomController: listOfRoomController)
              : const SizedBox(),
        ),
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
                        controller: listOfRoomController.scrollController,
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

class RoomFilterWidgets extends StatelessWidget {
  const RoomFilterWidgets({
    super.key,
    required this.listOfRoomController,
  });

  final ListOfRoomController listOfRoomController;

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
                      Container(
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(10.0),
                                  topRight: const Radius.circular(10.0))),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            primary: false,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'I am looking to:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Obx(
                                  () => Wrap(
                                    spacing: 8,
                                    children: listOfRoomController
                                        .accommodationType
                                        .map(
                                          (type) => FilterChip(
                                            label: Text(type),
                                            labelStyle: TextStyle(
                                                color: listOfRoomController
                                                            .selectedAccommodationType ==
                                                        type
                                                    ? Colors.white
                                                    : Colors.black),
                                            selected: listOfRoomController
                                                    .selectedAccommodationType ==
                                                type,
                                            selectedColor: AppColors.primary,
                                            backgroundColor:
                                                Colors.blue.withOpacity(0.08),
                                            // Set color to blue when selected
                                            onSelected: (selected) {
                                              if (selected) {
                                                listOfRoomController
                                                    .selectedAccommodationType
                                                    .value = type;
                                              } else {
                                                listOfRoomController
                                                        .selectedAccommodationType
                                                        .value =
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
                                    visible: (listOfRoomController
                                            .selectedAccommodationType ==
                                        'PG'),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Gender:',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Wrap(
                                          spacing: 8,
                                          children: listOfRoomController.gender
                                              .map(
                                                (type) => FilterChip(
                                                  label: Text(type),
                                                  labelStyle: TextStyle(
                                                      color: listOfRoomController
                                                                  .selectedGender ==
                                                              type
                                                          ? Colors.white
                                                          : Colors.black),
                                                  selected: listOfRoomController
                                                          .selectedGender ==
                                                      type,
                                                  selectedColor:
                                                      AppColors.primary,
                                                  backgroundColor: Colors.blue
                                                      .withOpacity(0.08),
                                                  // Set color to blue when selected
                                                  onSelected: (selected) {
                                                    if (selected) {
                                                      listOfRoomController
                                                          .selectedGender
                                                          .value = type;
                                                    } else {
                                                      listOfRoomController
                                                              .selectedGender
                                                              .value =
                                                          ''; // Deselect when tapped again
                                                    }
                                                  },
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: (listOfRoomController
                                            .selectedAccommodationType ==
                                        'PG'),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Room Type:',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          // Set the scroll direction to horizontal
                                          child: Wrap(
                                            spacing: 8,
                                            // Spacing between chips
                                            children: listOfRoomController
                                                .roomType
                                                .map(
                                                  (type) => FilterChip(
                                                    label: Text(type),
                                                    labelStyle: TextStyle(
                                                      color: listOfRoomController
                                                                  .selectedRoomType ==
                                                              type
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                    selected: listOfRoomController
                                                            .selectedRoomType ==
                                                        type,
                                                    selectedColor:
                                                        AppColors.primary,
                                                    backgroundColor: Colors.blue
                                                        .withOpacity(0.08),
                                                    // Background when not selected
                                                    onSelected: (selected) {
                                                      if (selected) {
                                                        listOfRoomController
                                                            .selectedRoomType
                                                            .value = type;
                                                      } else {
                                                        listOfRoomController
                                                                .selectedRoomType
                                                                .value =
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
                                Obx(
                                  () => Visibility(
                                    visible: (listOfRoomController
                                            .selectedAccommodationType ==
                                        'Flat'),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'BHK Type:',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          // Set the scroll direction to horizontal
                                          child: Wrap(
                                            spacing: 8,
                                            // Spacing between chips
                                            children: listOfRoomController
                                                .flatType
                                                .map(
                                                  (type) => FilterChip(
                                                    label: Text(type),
                                                    labelStyle: TextStyle(
                                                      color: listOfRoomController
                                                                  .selectedFlatType ==
                                                              type
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                    selected: listOfRoomController
                                                            .selectedFlatType ==
                                                        type,
                                                    selectedColor:
                                                        AppColors.primary,
                                                    backgroundColor: Colors.blue
                                                        .withOpacity(0.08),
                                                    // Background when not selected
                                                    onSelected: (selected) {
                                                      if (selected) {
                                                        listOfRoomController
                                                            .selectedFlatType
                                                            .value = type;
                                                      } else {
                                                        listOfRoomController
                                                                .selectedFlatType
                                                                .value =
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
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: (listOfRoomController
                                                .selectedAccommodationType ==
                                            'PG' ||
                                        listOfRoomController
                                                .selectedAccommodationType ==
                                            'Co-living'),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Food:',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Wrap(
                                          spacing: 8,
                                          children: listOfRoomController.food
                                              .map(
                                                (type) => FilterChip(
                                                  label: Text(type),
                                                  labelStyle: TextStyle(
                                                      color: listOfRoomController
                                                                  .selectedFood ==
                                                              type
                                                          ? Colors.white
                                                          : Colors.black),
                                                  selected: listOfRoomController
                                                          .selectedFood ==
                                                      type,
                                                  selectedColor:
                                                      AppColors.primary,
                                                  backgroundColor: Colors.blue
                                                      .withOpacity(0.08),
                                                  // Set color to blue when selected
                                                  onSelected: (selected) {
                                                    if (selected) {
                                                      listOfRoomController
                                                          .selectedFood
                                                          .value = type;
                                                    } else {
                                                      listOfRoomController
                                                              .selectedFood
                                                              .value =
                                                          ''; // Deselect when tapped again
                                                    }
                                                  },
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text(
                                  'Budget:',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Obx(
                                  () => RangeSlider(
                                    activeColor: AppColors.primary,
                                    values:
                                        listOfRoomController.budgetRange.value,
                                    min: 500,
                                    max: 100000,
                                    divisions: 100,
                                    labels: RangeLabels(
                                      listOfRoomController
                                          .budgetRange.value.start
                                          .round()
                                          .toString(),
                                      listOfRoomController.budgetRange.value.end
                                          .round()
                                          .toString(),
                                    ),
                                    onChanged: (RangeValues values) {
                                      listOfRoomController.budgetRange.value =
                                          values;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Obx(
                                  () => Text(
                                    'Selected Budget: ₹${listOfRoomController.budgetRange.value.start.round()} - ₹${listOfRoomController.budgetRange.value.end.round()}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                const SizedBox(height: 24),
                              ],
                            ),
                          )),
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

class RoomListCardWidgets extends StatelessWidget {
  const RoomListCardWidgets({
    super.key,
    required this.roomListData,
  });

  final RoomModel roomListData;

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
            UserContactListCardWidgets(
              name: roomListData.userName.toString(),
              contactNumber: roomListData.mobileNumber.toString(),
              atUpdate: roomListData.atUpdate.toString(),
              image: roomListData.userImage.toString(),
            )
          ],
        ),
      ),
    );
  }
}
