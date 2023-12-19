import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../model/user_rent_model/user_rent_model.dart';
import '../home/widgets/ItemListView.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  List<UserRentModel> data = Get.arguments['list'];
  var snapData = Get.arguments['id'];

  List<UserRentModel> displayList = [];

  void updateList(String value) {
    setState(() {
      displayList = data
      //search different way
          .where((element) =>
              element.houseName!.toLowerCase().contains(value.toLowerCase()) ||
              element.city!.toLowerCase().contains(value.toLowerCase()) ||
              element.address!.toLowerCase().contains(value.toLowerCase()) ||
              element.landMark!.toLowerCase().contains(value.toLowerCase()) ||
              element.singlePersonPrice!.toLowerCase().contains(value.toLowerCase()) ||
              element.familyPrice!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });

    if (value == "") {
      setState(() {
        displayList = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build -SearchScreen  ");

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: TextField(
                controller: searchController,
                maxLines: 1,
                autofocus: true,
                minLines: 1,
                keyboardType: TextInputType.text,
                onChanged: (value) => updateList(value),
                onSubmitted: (value) {},
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Enter Locality / Landmark / Colony",
                  hintStyle: const TextStyle(color: Colors.black54),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 25,
                  ),
                  suffixIcon: const Icon(
                    Icons.mic,
                    size: 25,
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.only(
                    bottom: 5,
                  ), // Added this
                )),
          ),
          Expanded(
              child: ItemListView(
            rentList: displayList,
            snapshot: snapData,
          ))
        ],
      ),
    );
  }
}
