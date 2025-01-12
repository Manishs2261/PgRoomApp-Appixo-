import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../utils/widgets/bottom_chat_and_call_widgets.dart';
import '../../../utils/widgets/report_card_widgets.dart';
import '../../../utils/widgets/view_map_card_widgets.dart';
import 'controller/controller.dart';

class DetailsOfSellAndBuy extends StatelessWidget {
  DetailsOfSellAndBuy({super.key});

  final controller = Get.put(DetailsOfSellAndBuyController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.info('Build --- DetailsOfSellAndBuy');
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          '${controller.data.itemName?.capitalizeFirst}',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: Colors.black,
              ))
        ],
      ),
      floatingActionButton: BottomChatAndCallWidgets(
        onTapChat: () {},
        onTapCall: () {},
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 16, top: 16, left: 16, bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                width: 400, // Set a fixed height for the PageView
                child: Stack(
                  children: [
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.data.image?.length ?? 0,
                      onPageChanged: (int page) {
                        controller.currentPage.value = page;
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              imageUrl: controller.data.image![index],
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 16,
                      right: 4,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Obx(
                          () => Text(
                            '${controller.currentPage.value + 1}/ ${controller.data.image?.length}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: false
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.white,
                                  size: 20,
                                )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                "₹200/-",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                " Post Date- ${AppHelperFunction.printFormattedDate(controller.data.atCreate!)}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ViewMapCardWidgets(
                landmark: controller.data.landmark.toString(),
                homeAddress: controller.data.address.toString(),
                city: controller.data.city.toString(),
                state: controller.data.state.toString(),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all()),
                child: Column(
                  children: [
                    Text(
                      '${controller.data.description}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ReportCardWidgets(
                onTap: () => Get.toNamed(RoutesName.reportScreen, arguments: [
                  controller.data.sabId!,
                  'DevBuyAndSellCollection'
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
