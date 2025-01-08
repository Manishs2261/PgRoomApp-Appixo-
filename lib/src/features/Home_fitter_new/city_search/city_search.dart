import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/user_apis.dart';
import 'package:pgroom/src/features/Home_fitter_new/city_search/controller/controller.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../utils/Constants/colors.dart';

class CitySearch extends StatelessWidget {
  CitySearch({super.key});

  final controller = Get.put(CitySearchController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug('Build City search screen .................');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "City Search",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
                onPressed: () {
                  if (controller.searchController.text.isNotEmpty) {
                    UserApis.updateCityName(controller.selectedCity.value);
                    Get.back(result: true);
                  } else {
                    AppHelperFunction.showFlashbar('City can\'t be empty');
                  }
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.searchController,
              onTapOutside: (e) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              decoration: InputDecoration(
                  labelText: "Search by city name...",
                  labelStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  isDense: true),
              onChanged: (value) {
                value.isEmpty
                    ? controller.showSuggestions.value = false
                    : controller.showSuggestions.value = true;

                controller.getCitySuggestions(value);
              },
              onSubmitted: (value) {
                Get.toNamed(RoutesName.homeNew, arguments: value);
              },
            ),
            SizedBox(height: 16),
            Obx(
              () => !controller.showSuggestions.value
                  ? Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: controller.accommodationType
                          .map(
                            (type) => FilterChip(
                              showCheckmark: false,
                              label: Text(type),
                              labelStyle: TextStyle(
                                  color: controller.selectedAccommodationType
                                              .value ==
                                          type
                                      ? Colors.white
                                      : Colors.black),
                              selected:
                                  controller.selectedAccommodationType.value ==
                                      type,
                              selectedColor: AppColors.primary,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                      color: controller
                                                  .selectedAccommodationType
                                                  .value ==
                                              type
                                          ? Colors.white
                                          : Colors.grey)),
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity(vertical: -4),
                              onSelected: (selected) {
                                if (selected) {
                                  controller.selectedAccommodationType.value =
                                      type;
                                  controller.searchController.text = type;
                                } else {
                                  controller.selectedAccommodationType.value =
                                      '';
                                }
                              },
                            ),
                          )
                          .toList(),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: controller.suggestions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              controller.suggestions[index]['description'],
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            onTap: () {
                              // Get the city name from the suggestion
                              controller.showSuggestions.value = false;
                              String cityName =
                                  controller.suggestions[index]['description'];

                              controller.searchController.text =
                                  cityName.split(",")[0];
                              controller.suggestions.value = [];
                            },
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
