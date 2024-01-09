import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pgroom/src/data/repository/apis/apis.dart';

import '../../model/user_rent_model/user_rent_model.dart';
import '../../res/route_name/routes_name.dart';
import '../../utils/Constants/colors.dart';
import '../../utils/helpers/helper_function.dart';
import '../room_rent_all_screen/home/widgets/ItemListView.dart';

class AddToCard extends StatelessWidget {
  AddToCard({super.key});

  List<UserRentModel> rentList = [];
  var snapData;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add to card"),
      ),
      body: StreamBuilder(
          stream: ApisClass.firebaseFirestore.collection('rentCollection').snapshots(),
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

                snapData = snapshot;
                rentList = data?.map((e) => UserRentModel.fromJson(e.data())).toList() ?? [];
                // Filter the rentList based on the 'like' field being true
                final likedRentList = rentList.where((rent) => rent.like == true,).toList();
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(left: 0.2, right: 0.2),
                    itemCount: likedRentList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          final itemId = snapshot.data?.docs[index].id;

                          print(snapshot.data?.docs[index].id);
                          print("manish");
                          Get.toNamed(RoutesName.detailsRentInfoScreen, arguments: {
                            'list': likedRentList[index],
                            'id': itemId,
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(minHeight: 180, maxHeight: 200),
                          decoration: BoxDecoration(
                              color: dark ? AppColors.dark : const Color.fromRGBO(200, 200, 40, 0.01),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 0.2,
                                )
                              ]),
                          child: Row(
                            children: [
                              //====== front image========
                              Stack(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 280,
                                    color: dark ? Colors.blueGrey.shade900 : Colors.grey.shade200,
                                    child: CachedNetworkImage(
                                        imageUrl: '${likedRentList[index].coverImage}',
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) => Container(
                                              color: Colors.transparent,
                                              height: 100,
                                              width: 100,
                                              child: const SpinKitFadingCircle(
                                                color: AppColors.primary,
                                                size: 35,
                                              ),
                                            ),
                                        errorWidget: (context, url, error) => Container(
                                              width: 150,
                                              height: 280,
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.image_outlined,
                                                size: 50,
                                              ),
                                            )),
                                  ),
                                  Positioned(
                                      right: 5,
                                      top: 5,
                                      child: InkWell(
                                        onTap: () {

                                          final itemId = snapshot.data?.docs[index].id;
                                          ApisClass.updateAddToCart(likedRentList[index].userRentId, false);
                                          print(itemId);
                                          print(likedRentList[index].userRentId);

                                        },
                                        child: CircleAvatar(
                                          radius: 17,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ))
                                ],
                              ),

                              const SizedBox(
                                width: 10,
                              ),
                              // =====Details ============

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${likedRentList[index].houseName}",
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        maxLines: 1,
                                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 17,
                                        ),
                                        Text("${likedRentList[index].average}"),
                                        Text(" (${likedRentList[index].numberOfRating} Reviews)")
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Rent - ₹',
                                        style: DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: (likedRentList[index].singlePersonPrice!.isNotEmpty)
                                                  ? '${likedRentList[index].singlePersonPrice}'
                                                  : '${likedRentList[index].familyPrice}',
                                              style: const TextStyle(fontWeight: FontWeight.bold)),
                                          const TextSpan(text: ' /- monthly'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "Address:-${likedRentList[index].address} ",
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        maxLines: 2,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text("City - ${likedRentList[index].city}"),
                                    (likedRentList[index].bhkType!.isEmpty)
                                        ? Text("Room Type - ${likedRentList[index].roomType}")
                                        : Text("Room Type - ${likedRentList[index].roomType} - ${likedRentList[index].bhkType}"),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    (likedRentList[index].roomAvailable!)
                                        ? Text(
                                            "Available :- ${likedRentList[index].numberOfRooms}",
                                            style: TextStyle(color: Colors.green),
                                          )
                                        : Text(
                                            "Not Available",
                                            style: TextStyle(color: Colors.red),
                                          )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
            }
          }),
    );
  }
}
