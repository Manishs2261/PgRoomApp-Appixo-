import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class LocationSearchController extends GetxController {
  final FocusNode focusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();
  final RxString searchText = "".obs;
  final RxList<String> searchHistory = <String>[].obs;
  final RxBool showSuggestions = false.obs;

  RxInt selectedButtonIndex = 0.obs;

  final String apiKey = "AIzaSyAwsLCabPSfnXi7Mq2JV3vzl4Xjl1nMB1Y";
  RxList<dynamic> suggestions = RxList<dynamic>([]);

  Future<void> getCitySuggestions(String query) async {
    if (query.isEmpty) return;
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&types=(cities)&components=country:IN&key=$apiKey';

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
  void onInit() {
    // TODO: implement onInit

    // Future.delayed(const Duration(milliseconds: 500), () {
    //
    //   AdProvider adProvider = Provider.of<AdProvider>(context, listen: false);
    //
    //   adProvider.initializeNativeAd();
    //
    // });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
      focusNode.addListener(() {
        showSuggestions.value = focusNode.hasFocus;
      });
    });

    searchController.addListener(() {
      searchText.value = searchController.value.text;
    });
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusNode.dispose();
    searchController.dispose();

    super.dispose();
  }

  void onButtonSelected(int index) {
    selectedButtonIndex.value = index;
  }

  void onSearchSubmitted(String searchText) {
    if (searchText.isNotEmpty) {
      searchHistory.add(searchText); // Add search text to the search history
      searchController.clear(); // Clear the search field
    }
  }
}
