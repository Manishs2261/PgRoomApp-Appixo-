import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/services_screen/model/services_model.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../res/route_name/routes_name.dart';
import '../../../utils/Constants/colors.dart';
import '../../../utils/widgets/com_reuse_elevated_button.dart';
import '../../../utils/widgets/shimmer_effect.dart';
import '../../../utils/widgets/top_search_bar/top_search_bar.dart';
import '../../../utils/widgets/user_contact_list_card_widgets.dart';
import 'controller/controller.dart';

class ListOfServices extends StatefulWidget {
  const ListOfServices({super.key});

  @override
  State<ListOfServices> createState() => _ListOfServicesState();
}

class _ListOfServicesState extends State<ListOfServices> {
  final listOfServicesController = Get.put(ListOfServicesController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - ListOfSellAndBuy......................................");
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SafeArea(child: TopSearchFilter()),
      ),
      floatingActionButton: Obx(
        () => AnimatedOpacity(
          opacity: listOfServicesController.isButtonVisible.value ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: listOfServicesController.isButtonVisible.value
              ? ServicesFilterWidgets(
                  listOfServicesController: listOfServicesController,
                )
              : const SizedBox(),
        ),
      ),
      body: Obx(
        () => listOfServicesController.isLoadingInitial.value
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
                  listOfServicesController.servicesListData.clear();
                  listOfServicesController.lastDocument = null;
                  listOfServicesController.hasMoreData.value = true;
                  await listOfServicesController.fetchData();
                },
                indicatorBuilder:
                    (BuildContext context, IndicatorController controller) {
                  return const CircularProgressIndicator(
                    color: Colors.blue,
                  );
                },
                child: listOfServicesController.servicesListData.isEmpty &&
                        !listOfServicesController.isLoadingMore.value
                    ? Center(
                        child: Text(
                          'No rooms available. Pull to refresh.',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        controller: listOfServicesController.scrollController,
                        itemCount: listOfServicesController.isLoadingMore.value
                            ? listOfServicesController.servicesListData.length +
                                1
                            : listOfServicesController.servicesListData.length,
                        itemBuilder: (context, index) {
                          if (index ==
                                  listOfServicesController
                                      .servicesListData.length &&
                              listOfServicesController.isLoadingMore.value) {
                            return SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
                                ));
                          }
                          return ListOfServicesCardWidgets(
                            servicesModel: listOfServicesController
                                .servicesListData[index],
                          );
                        },
                      ),
              ),
      ),
    );
  }
}

class ListOfServicesCardWidgets extends StatelessWidget {
  const ListOfServicesCardWidgets({
    super.key,
    required this.servicesModel,
  });

  final ServicesModel servicesModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Get.toNamed(RoutesName.servicesDetails, arguments: servicesModel),
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
                        itemCount: servicesModel.image?.length ?? 0,
                        itemBuilder: (context, imageIndex) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: CachedNetworkImage(
                                width: Get.width * 0.8,
                                imageUrl:
                                    servicesModel.image?[imageIndex] ?? '',
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
                '${servicesModel.servicesName}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),
              Text(
                '${servicesModel.landmark},${servicesModel.address},${servicesModel.city},${servicesModel.state}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 16),
              // Buttons for "Chat Now" and "Call Now"
              UserContactListCardWidgets(
                name: '${servicesModel.userName}',
                contactNumber: '${servicesModel.mobileNumber}',
                atUpdate: '${servicesModel.atUpdate}',
                image: '${servicesModel.userImage}',
              )
            ],
          )),
    );
  }
}

class ServicesFilterWidgets extends StatelessWidget {
  const ServicesFilterWidgets({
    super.key,
    required this.listOfServicesController,
  });

  final ListOfServicesController listOfServicesController;

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
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Obx(
                              () => Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: listOfServicesController
                                      .nameOfServices
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    int index = entry.key;
                                    String name = entry.value;

                                    return GestureDetector(
                                      onTap: () {
                                        // Toggle selection state
                                        if (listOfServicesController
                                            .selectedIndices
                                            .contains(index)) {
                                          listOfServicesController
                                              .selectedIndices
                                              .remove(
                                                  index); // Deselect if already selected
                                        } else {
                                          listOfServicesController
                                              .selectedIndices
                                              .add(
                                                  index); // Select if not selected
                                        }
                                      },
                                      child: Container(
                                          height: 80,
                                          width: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: listOfServicesController
                                                    .selectedIndices
                                                    .contains(index)
                                                ? AppColors.primary
                                                : Colors.white,
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    listOfServicesController
                                                            .imageOfServices[
                                                        index]),
                                                backgroundColor: Colors.white,
                                              ),

                                              // Spacing between image and text
                                              // Name text
                                              Text(
                                                name,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      listOfServicesController
                                                              .selectedIndices
                                                              .contains(index)
                                                          ? Colors.white
                                                          : Colors.black,
                                                ),
                                              ),
                                            ],
                                          )),
                                    );
                                  }).toList()),
                            ),
                          ],
                        ),
                      ),
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
