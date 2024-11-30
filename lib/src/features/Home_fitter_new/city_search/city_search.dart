import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:pgroom/src/res/route_name/routes_name.dart';

class CitySearch extends StatefulWidget {
  @override
  _CitySearchState createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> {
  final TextEditingController _searchController = TextEditingController();
  final String apiKey = "AIzaSyAwsLCabPSfnXi7Mq2JV3vzl4Xjl1nMB1Y"; // Replace with your Google API key
  List<dynamic> suggestions = [];

  Future<void> _getCitySuggestions(String query) async {
    if (query.isEmpty) return;

    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&types=(cities)&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        setState(() {
          suggestions = data['predictions'];
        });
      } else {
        setState(() {
          suggestions = [];
        });
      }
    } else {
      throw Exception('Failed to fetch suggestions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("City Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Search for a city",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                isDense: true

              ),
              onChanged: (value) {
                _getCitySuggestions(value);
              },
              onSubmitted: (value){
                Get.toNamed(RoutesName.homeNew,arguments: value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(suggestions[index]['description']),
                  onTap: () {
                    // Get the city name from the suggestion
                    String cityName = suggestions[index]['description'];
                    setState(() {
                      _searchController.text = cityName;
                      suggestions = [];
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
