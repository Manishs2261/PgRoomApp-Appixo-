import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CitySearchController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  RxList<String> accommodationType = [
    'Patna',
    'Raipur',
    'Bengaluru',
    'Thiruvananthapuram',
    'Bhopal',
    'Mumbai',
    'Bhubaneswar',
    'Jaipur',
    'Chennai',
    'Hyderabad',
    'Lucknow',
    'Kolkata',
    'New Delhi',
  ].obs;

  RxString selectedAccommodationType = ''.obs;
  final String apiKey =
      "AIzaSyAwsLCabPSfnXi7Mq2JV3vzl4Xjl1nMB1Y"; // Replace with your Google API key
  RxList<dynamic> suggestions = [].obs;
  final RxBool showSuggestions = false.obs;
  final RxString selectedCity = ''.obs;

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

  final FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    // TODO: implement onInit

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
      focusNode.addListener(() {
        showSuggestions.value = focusNode.hasFocus;
      });
    });

    searchController.addListener(() {
      selectedCity.value = searchController.value.text;
    });
    super.onInit();
  }
}
