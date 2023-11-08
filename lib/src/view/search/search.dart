import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/view/home/home_screen.dart';

import '../../model/user_rent_model/user_rent_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  List<UserRentModel> data = Get.arguments;

  List<UserRentModel> displayList = [];

  void updateList(String value) {
    setState(() {
      displayList = data
          .where((element) =>
      element.houseName!.toLowerCase().contains(value.toLowerCase()) ||
          element.city!.toLowerCase().contains(value.toLowerCase()))
          .toList();

    });

    if(value == "")
      setState(() {
         displayList = [];
      });


  }

  @override
  Widget build(BuildContext context) {
    print("Build Screen => Search Screen 🔴");

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
                controller: searchController,
                maxLines: 1,
                autofocus: true,
                minLines: 1,
                keyboardType: TextInputType.text,
                onChanged: (value) => updateList(value),
                onSubmitted: (value) {

                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Enter Locality / Landmark / Colony",
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 25,
                  ),
                  suffixIcon: Icon(
                    Icons.mic,
                    size: 25,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.only(
                    bottom: 5,
                  ), // Added this
                )),
          ),
          Expanded(child: ItemListView(rentList: displayList))
        ],
      ),
    );
  }
}
