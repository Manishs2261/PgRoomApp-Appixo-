import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../res/route_name/routes_name.dart';
import '../../../utils/Constants/colors.dart';
import '../../../utils/widgets/custom_Icon_button.dart';
import 'controller/controller.dart';

class LocationSearch extends StatelessWidget {
  LocationSearch({super.key});

  final controller = Get.put(LocationSearchController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - LocationSearch..............");
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF133157),
                        const Color(0xFF1A426D),
                        const Color(0xFF2A5C99),
                        Colors.white.withOpacity(0.9),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 12),
                          child: InkWell(
                            onTap: () => Get.back(),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Text(
                          "You are looking to rent in",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        const Row(
                          children: [
                            Text(
                              "Select Locality or Landmark in ",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            Text(
                              "Bilaspur",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(24, 255, 238, 1.0)),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 18,
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomIconButton(
                                  label: 'Room',
                                  icon: Icons.bedroom_parent_outlined,
                                  gradientColors: [
                                    Colors.blueAccent.withOpacity(0.3),
                                    Colors.blue.withOpacity(0.5)
                                  ],
                                  selectedGradientColors: [
                                    Colors.blue,
                                    Colors.blueAccent
                                  ],
                                  isSelected:
                                      controller.selectedButtonIndex == 0,
                                  onTap: () => controller.onButtonSelected(0),
                                ),
                                CustomIconButton(
                                  label: 'Food',
                                  icon: Icons.fastfood_outlined,
                                  gradientColors: [
                                    Colors.greenAccent.withOpacity(0.2),
                                    Colors.green.withOpacity(0.5)
                                  ],
                                  selectedGradientColors: [
                                    Colors.green,
                                    Colors.greenAccent
                                  ],
                                  isSelected:
                                      controller.selectedButtonIndex == 1,
                                  onTap: () => controller.onButtonSelected(1),
                                ),
                                CustomIconButton(
                                  label: 'Buy/Sell',
                                  icon: Icons.archive_outlined,
                                  gradientColors: [
                                    Colors.orangeAccent.withOpacity(0.3),
                                    Colors.deepOrange.withOpacity(0.3)
                                  ],
                                  selectedGradientColors: [
                                    Colors.deepOrange,
                                    Colors.orange
                                  ],
                                  isSelected:
                                      controller.selectedButtonIndex == 2,
                                  onTap: () => controller.onButtonSelected(2),
                                ),
                                CustomIconButton(
                                  label: 'Service',
                                  icon: Icons.room_service_outlined,
                                  gradientColors: [
                                    Colors.black.withOpacity(0.3),
                                    Colors.purple.withOpacity(0.3)
                                  ],
                                  selectedGradientColors: [
                                    Colors.purple[900]!,
                                    Colors.purpleAccent
                                  ],
                                  isSelected:
                                      controller.selectedButtonIndex == 3,
                                  onTap: () => controller.onButtonSelected(3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: controller.searchController,
                          onFieldSubmitted: (value) {
                            controller.getCitySuggestions(value);
                            controller.onSearchSubmitted(value);
                            Get.toNamed(RoutesName.filter,
                                arguments: controller.selectedButtonIndex);
                          },
                          onChanged: (value) {
                            value.isEmpty
                                ? controller.showSuggestions.value = false
                                : controller.showSuggestions.value = true;
                            controller.getCitySuggestions(value);
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Find what you need—just search here",
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: AppColors.primary,
                              size: 24,
                            ),
                            // suffixIcon: Obx(() => searchText.value.isNotEmpty
                            //     ? IconButton(
                            //   icon: const Icon(
                            //     Icons.clear,
                            //     color: Colors.black,
                            //   ),
                            //   onPressed: () {
                            //     _searchController.clear();
                            //     searchText.value = '';
                            //   },
                            // )
                            //     : null),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => controller.showSuggestions.value
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.suggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            '${controller.suggestions[index]['description']}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          onTap: () {
                            controller.showSuggestions.value = false;
                            String cityName =
                                controller.suggestions[index]['description'];
                            controller.searchController.text = cityName;
                            controller.suggestions.clear();
                          },
                        );
                      },
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 350,
                          // Explicitly constrain the height of this section
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  'Search History :-',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primary),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  padding: EdgeInsets.zero,
                                  itemCount: controller.searchHistory.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // Handle tap on search history item

                                            Get.toNamed(RoutesName.filter,
                                                arguments: controller
                                                    .selectedButtonIndex);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0.0,
                                                horizontal: 16.0),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.history,
                                                    size: 20),
                                                const SizedBox(width: 8),
                                                // Adds spacing between icon and text
                                                Expanded(
                                                  child: Text(
                                                    controller
                                                        .searchHistory[index],
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                    overflow:
                                                        TextOverflow.visible,
                                                    maxLines: null,
                                                    // Handles long text gracefully
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.clear,
                                                      size: 18),
                                                  onPressed: () {
                                                    // Handle delete specific search history item
                                                    // _removeFromSearchHistory(index);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                        // Divider between items
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        // The yellow container at the bottom
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
