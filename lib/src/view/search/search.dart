import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';

import '../../model/user_rent_model/user_rent_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {



  @override
  Widget build(BuildContext context) {
    print("Build Screen => Search Screen 🔴");
    print(ApisClass.getAllDataItem());

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: TextFormField(
              keyboardType: TextInputType.text,

              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

                hintText: "Enter Locality / Landmark / Colony",
                prefixIcon: Icon(Icons.search_rounded),
                suffixIcon: Icon(Icons.mic),
                isDense: false,

                contentPadding: EdgeInsets.only(bottom: 5,),

              ),
            ),
          ),

        ],
      ),
    );
  }
}
