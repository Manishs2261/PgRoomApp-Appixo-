import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../model/tiffin_services_model/tiffen_services_model.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../utils/Constants/colors.dart';



class SearchTiffineScreen extends StatefulWidget {
  const SearchTiffineScreen({super.key});

  @override
  State<SearchTiffineScreen> createState() => _SearchTiffineScreenState();
}

class _SearchTiffineScreenState extends State<SearchTiffineScreen> {
  final searchController = TextEditingController();
  List<TiffineServicesModel> data = Get.arguments['list'];
  var snapData = Get.arguments['id'];

  List<TiffineServicesModel> displayList = [];

  void updateList(String value) {
    setState(() {
      displayList = data
          .where((element) =>
      element.servicesName!.toLowerCase().contains(value.toLowerCase()) ||
          element.address!.toLowerCase().contains(value.toLowerCase()))
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
    AppLoggerHelper.debug("Build -SearchTiffineScreen  ");

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10,top: 15),
            child: TextField(
                controller: searchController,
                maxLines: 1,
                autofocus: true,
                minLines: 1,
                keyboardType: TextInputType.text,
                onChanged: (value) => updateList(value),
                onSubmitted: (value) {},
                style: TextStyle(color: Colors.black87),

                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Enter Locality / Landmark / Colony",
                  hintStyle: TextStyle(color: Colors.black54),
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
            child: ListView.builder(
                itemCount: displayList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      final itemId = snapData.data?.docs[index].id;
                      Get.toNamed(RoutesName.tiffinDetailsScreen, arguments: {
                        'list': displayList[index],
                        'id': itemId,
                      });
                    },
                    child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl:displayList[index].foodImage.toString(),
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Container(
                                color: Colors.transparent,
                                width: double.infinity,
                                height: 200,
                                child: SpinKitFadingCircle(
                                  color: AppColors.primary,
                                  size: 35,
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: double.infinity,
                                height: 200,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.food_bank,
                                  size: 50,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, top: 3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${displayList[index].servicesName}",
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        "${displayList[index].averageRating}",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("(${displayList[index].numberOfRating} Ratings)"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "Address :- ${displayList[index].address}",
                                          softWrap: false,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [Text("Stating Price :- ${displayList[index].foodPrice} Ru  day/- ")],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        )),
                  );
                }),
          )
        ],
      ),
    );
  }
}
