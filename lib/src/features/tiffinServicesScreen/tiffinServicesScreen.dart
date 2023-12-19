import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/apis.dart';
import 'package:pgroom/src/features/tiffinServicesScreen/widgets/app_bar.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';

import '../../model/tiffin_services_model/tiffen_services_model.dart';
import '../../utils/Constants/colors.dart';

class TiffineServicesScreen extends StatelessWidget {
  TiffineServicesScreen({super.key});

  List<TiffineServicesModel> tiffineList = [];
  var snapData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(108),
          child: Column(
            children: [
              AppBarTiffineWidgets(),


              Container(
                color: AppColors.primary,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 5,
                  ),
                  child: TextFormField(
                    onTap: () {
                      Get.toNamed(RoutesName.searchTiffineScreen, arguments: {
                        'list':  tiffineList,
                        'id': snapData,
                      });
                    },
                    autofocus: false,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      fillColor: Colors.yellow[50],
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter Service / Landmark / Colony",
                      hintStyle: const TextStyle(color: Colors.black54),
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: const Icon(Icons.mic),
                      isDense: true,
                      contentPadding: const EdgeInsets.only(bottom: 5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: StreamBuilder(
            stream: ApisClass.firebaseFirestore.collection('tiffineServicesCollection').snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.signal_wifi_connected_no_internet_4),
                        Text("No Internet Connection"),
                        SizedBox(
                          height: 10,
                        ),
                        CircularProgressIndicator(
                          color: Colors.blue,
                        )
                      ],
                    ),
                  );
                case ConnectionState.none:
                  return const Center(
                    child: Row(
                      children: [
                        Icon(Icons.signal_wifi_connected_no_internet_4),
                        Text("No Internet Connection"),
                        CircularProgressIndicator(
                          color: Colors.blue,
                        )
                      ],
                    ),
                  );

                case ConnectionState.active:
                case ConnectionState.done:
                  final data = snapshot.data?.docs;

                  // for(var i in data!)
                  //   {
                  //     log("Data : ${jsonEncode(i.data())}");
                  //   }

                  snapData = snapshot;
                  tiffineList = data?.map((e) => TiffineServicesModel.fromJson(e.data())).toList() ?? [];

                  return ListView.builder(
                      itemCount: tiffineList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(RoutesName.tiffinDetailsScreen, arguments: {
                              'list': tiffineList[index],
                              'id': snapshot.data?.docs[index].id,
                            });
                          },
                          child: Card(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl: tiffineList[index].foodImage.toString(),
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
                                      "${tiffineList[index].servicesName}",
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
                                          "${tiffineList[index].averageRating}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("(${tiffineList[index].numberOfRating} Ratings)"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Address :- ${tiffineList[index].address}",
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
                                      children: [Text("Stating Price :- ${tiffineList[index].foodPrice} Ru  day/- ")],
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
                      });
              }
            }));
  }
}
