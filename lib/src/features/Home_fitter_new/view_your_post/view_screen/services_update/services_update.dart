import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/services_collection.dart';
import 'package:pgroom/src/features/services_screen/model/services_model.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../../../res/route_name/routes_name.dart';
import '../../../../../utils/widgets/gradient_button.dart';
import '../../../../../utils/widgets/shimmer_effect.dart';
import 'controller/controller.dart';

class ServicesUpdateList extends StatefulWidget {
  const ServicesUpdateList({super.key});

  @override
  State<ServicesUpdateList> createState() => _ServicesUpdateListState();
}

class _ServicesUpdateListState extends State<ServicesUpdateList> {
  final listOfServicesController = Get.put(ListOfServicesUpdateController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - ListOfSellAndBuy......................................");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Services',
          style: TextStyle(fontWeight: FontWeight.w400),
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
                          'No Post available.',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
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
   ListOfServicesCardWidgets({
    super.key,
    required this.servicesModel,
  });

  final ServicesModel servicesModel;
  final listOfServicesController = Get.put(ListOfServicesUpdateController());

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
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: servicesModel.image?.length ?? 0,
                    itemBuilder: (context, imageIndex) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            width: Get.width * 0.8,
                            imageUrl: servicesModel.image?[imageIndex] ?? '',
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
                      onPressed: () => Get.toNamed(
                            RoutesName.editServicesPostList,
                            arguments: servicesModel,
                          )),
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
                            content: Text(
                                'Are you sure you want to delete this item?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  ServicesApis.deleteServiceData(
                                      documentId: servicesModel.sId!,
                                      imageUrls: servicesModel.image!).whenComplete( () async {
                                    listOfServicesController.servicesListData.clear();
                                    listOfServicesController.lastDocument = null;
                                    listOfServicesController.hasMoreData.value = true;
                                    await listOfServicesController.fetchData();
                                      });
                                  // Close the dialog
                                  // Perform the delete action here
                                },
                                child: Text('Delete',
                                    style: TextStyle(color: Colors.red)),
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
          )),
    );
  }
}
