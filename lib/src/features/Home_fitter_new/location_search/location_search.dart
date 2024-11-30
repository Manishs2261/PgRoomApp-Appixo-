import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:pgroom/src/utils/logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../res/route_name/routes_name.dart';
import '../../../utils/Constants/colors.dart';
import '../../../utils/ad_helper/services/ad_services.dart';
import '../../../utils/widgets/custom_Icon_button.dart';

class LocationSearch extends StatefulWidget {
  const LocationSearch({super.key});

  @override
  _LocationSearchState createState() => _LocationSearchState();
}

class _LocationSearchState extends State<LocationSearch> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  final RxString searchText = "".obs;
  final RxList<String> _searchHistory = <String>[].obs;
  final RxBool showSuggestions = false.obs;

  int selectedButtonIndex = 0;

  void _onButtonSelected(int index) {
    setState(() {
      selectedButtonIndex = index;
    });
  }

  void _onSearchSubmitted(String searchText) {
    if (searchText.isNotEmpty) {
      setState(() {
        _searchHistory.add(searchText); // Add search text to the search history
        _searchController.clear(); // Clear the search field
      });
    }
  }

  @override
  void initState() {
    super.initState();


    Future.delayed(const Duration(milliseconds: 500), () {

      AdProvider adProvider = Provider.of<AdProvider>(context, listen: false);

      adProvider.initializeNativeAd();

    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      _focusNode.addListener(() {
        showSuggestions.value = _focusNode.hasFocus;
      });
    });

    _searchController.addListener(() {
      searchText.value = _searchController.value.text;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  final String apiKey = "AIzaSyAwsLCabPSfnXi7Mq2JV3vzl4Xjl1nMB1Y";
  RxList<dynamic> suggestions = RxList<dynamic>([]);

  Future<void> _getCitySuggestions(String query) async {
    if (query.isEmpty) return;

    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&types=(cities)&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        suggestions.value = data['predictions'];
      } else {
        suggestions.value = [];
      }
    } else {
      throw Exception('Failed to fetch suggestions');
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - LocationSearch");
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
                        Color(0xFF133157),
                        Color(0xFF1A426D),
                        Color(0xFF2A5C99),
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
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
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
                        SizedBox(height: 10),
                        SingleChildScrollView(
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
                                isSelected: selectedButtonIndex == 0,
                                onTap: () => _onButtonSelected(0),
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
                                isSelected: selectedButtonIndex == 1,
                                onTap: () => _onButtonSelected(1),
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
                                isSelected: selectedButtonIndex == 2,
                                onTap: () => _onButtonSelected(2),
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
                                isSelected: selectedButtonIndex == 3,
                                onTap: () => _onButtonSelected(3),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _searchController,
                          onFieldSubmitted: (value) {
                            _getCitySuggestions(value);
                            _onSearchSubmitted(value);
                            Get.toNamed(RoutesName.filter,
                                arguments: selectedButtonIndex);
                          },
                          onChanged: (value) {
                            value.isEmpty
                                ? showSuggestions.value = false
                                : showSuggestions.value = true;
                            _getCitySuggestions(value);
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
                  () => showSuggestions.value
                  ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(suggestions[index]['description']),
                    onTap: () {
                      showSuggestions.value = false;
                      String cityName = suggestions[index]['description'];
                      _searchController.text = cityName;
                      suggestions.clear();
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                            itemCount: _searchHistory.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Handle tap on search history item

                                      Get.toNamed(RoutesName.filter,
                                          arguments: selectedButtonIndex);

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0.0,
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.history, size: 20),
                                          SizedBox(width: 8),
                                          // Adds spacing between icon and text
                                          Expanded(
                                            child: Text(
                                              _searchHistory[index],
                                              style:
                                              TextStyle(fontSize: 14),
                                              overflow:
                                              TextOverflow.visible,
                                              maxLines: null,
                                              // Handles long text gracefully
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.clear,
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
                  Consumer<AdProvider>(builder: (context, adProvider, child) {
                    if (adProvider.isNativeAdLoaded) {
                      return ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 320, // minimum recommended width
                          minHeight: 320, // minimum recommended height
                          maxWidth: 400,
                          maxHeight: 400,
                        ),
                        child:   adProvider.isNativeAdLoaded ? Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 20.0),
                          height: 70,
                          child: AdWidget(ad: adProvider.nativeAd),
                        ) : const CircularProgressIndicator(),
                      );
                    } else {
                      return Container(
                        height: 0,
                      );
                    }
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
