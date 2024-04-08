// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:pgroom/src/data/repository/apis/apis.dart';
// import 'package:pgroom/src/features/tiffinServicesScreen/widgets/app_bar.dart';
// import 'package:pgroom/src/res/route_name/routes_name.dart';
//
// import '../../model/tiffin_services_model/tiffen_services_model.dart';
// import '../../utils/Constants/colors.dart';
//
// class TiffineServicesScreen extends StatelessWidget {
//   TiffineServicesScreen({super.key});
//
//   List<TiffineServicesModel> tiffineList = [];
//   var snapData;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(108),
//           child: Column(
//             children: [
//               AppBarTiffineWidgets(),
//
//
//               Container(
//                 color: AppColors.primary,
//                 height: 50,
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                     left: 20,
//                     right: 20,
//                     bottom: 5,
//                   ),
//                   child: TextFormField(
//                     onTap: () {
//                       Get.toNamed(RoutesName.searchTiffineScreen, arguments: {
//                         'list':  tiffineList,
//                         'id': snapData,
//                       });
//                     },
//                     autofocus: false,
//                     keyboardType: TextInputType.none,
//                     decoration: InputDecoration(
//                       fillColor: Colors.yellow[50],
//                       filled: true,
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                       hintText: "Enter Service / Landmark / Colony",
//                       hintStyle: const TextStyle(color: Colors.black54),
//                       prefixIcon: const Icon(Icons.search_rounded),
//                       suffixIcon: const Icon(Icons.mic),
//                       isDense: true,
//                       contentPadding: const EdgeInsets.only(bottom: 5),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: StreamBuilder(
//             stream: ApisClass.firebaseFirestore.collection('tiffineServicesCollection').snapshots(),
//             builder: (context, snapshot) {
//               switch (snapshot.connectionState) {
//                 case ConnectionState.waiting:
//                   return const Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.signal_wifi_connected_no_internet_4),
//                         Text("No Internet Connection"),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         CircularProgressIndicator(
//                           color: Colors.blue,
//                         )
//                       ],
//                     ),
//                   );
//                 case ConnectionState.none:
//                   return const Center(
//                     child: Row(
//                       children: [
//                         Icon(Icons.signal_wifi_connected_no_internet_4),
//                         Text("No Internet Connection"),
//                         CircularProgressIndicator(
//                           color: Colors.blue,
//                         )
//                       ],
//                     ),
//                   );
//
//                 case ConnectionState.active:
//                 case ConnectionState.done:
//                   final data = snapshot.data?.docs;
//
//                   // for(var i in data!)
//                   //   {
//                   //     log("Data : ${jsonEncode(i.data())}");
//                   //   }
//
//                   snapData = snapshot;
//                   tiffineList = data?.map((e) => TiffineServicesModel.fromJson(e.data())).toList() ?? [];
//
//                   return ListView.builder(
//                       itemCount: tiffineList.length,
//                       itemBuilder: (context, index) {
//                         return InkWell(
//                           onTap: () {
//                             Get.toNamed(RoutesName.tiffinDetailsScreen, arguments: {
//                               'list': tiffineList[index],
//                               'id': snapshot.data?.docs[index].id,
//                             });
//                           },
//                           child: Card(
//                               child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               CachedNetworkImage(
//                                 imageUrl: tiffineList[index].foodImage.toString(),
//                                 width: double.infinity,
//                                 height: 200,
//                                 fit: BoxFit.fill,
//                                 placeholder: (context, url) => Container(
//                                   color: Colors.transparent,
//                                   width: double.infinity,
//                                   height: 200,
//                                   child: SpinKitFadingCircle(
//                                     color: AppColors.primary,
//                                     size: 35,
//                                   ),
//                                 ),
//                                 errorWidget: (context, url, error) => Container(
//                                   width: double.infinity,
//                                   height: 200,
//                                   alignment: Alignment.center,
//                                   child: const Icon(
//                                     Icons.food_bank,
//                                     size: 50,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 5, top: 3),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "${tiffineList[index].servicesName}",
//                                       overflow: TextOverflow.ellipsis,
//                                       softWrap: false,
//                                       maxLines: 1,
//                                       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                                     ),
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.star,
//                                           color: Colors.yellow,
//                                         ),
//                                         SizedBox(
//                                           width: 2,
//                                         ),
//                                         Text(
//                                           "${tiffineList[index].averageRating}",
//                                           style: TextStyle(fontSize: 17),
//                                         ),
//                                         SizedBox(
//                                           width: 5,
//                                         ),
//                                         Text("(${tiffineList[index].numberOfRating} Ratings)"),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Flexible(
//                                           child: Text(
//                                             "Address :- ${tiffineList[index].address}",
//                                             softWrap: false,
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       children: [Text("Stating Price :- ${tiffineList[index].foodPrice} Ru  day/- ")],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 8,
//                               ),
//                             ],
//                           )),
//                         );
//                       });
//               }
//             }));
//   }
// }

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class TiffineServicesScreen  extends StatefulWidget {
  const TiffineServicesScreen ({super.key});

  @override
  State<TiffineServicesScreen > createState() => _RealEstate2HomePageState();
}

class _RealEstate2HomePageState extends State<TiffineServicesScreen > {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.menu,
                              ),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Current Location",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 20,
                                      ),
                                      Text(
                                        "Seoul, Republic of Korea",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Badge(
                                child: Icon(
                                  Icons.notifications_none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(24),
                        Container(
                          decoration: ShapeDecoration(
                            shape: const StadiumBorder(),
                            color: Colors.white.withOpacity(.2),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: const TextField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.search,
                              ),
                              iconColor: Colors.grey,
                              hintText: "Search for your homestay",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Gap(8),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: SizedBox(
                      height: 42,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.2),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.local_fire_department_outlined,
                                  color: Colors.white,
                                ),
                                Gap(4),
                                Text(
                                  "Trending",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(12),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.2),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.home_outlined,
                                  color: Colors.white,
                                ),
                                Gap(4),
                                Text(
                                  "House",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(12),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.2),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.apartment_rounded,
                                  color: Colors.white,
                                ),
                                Gap(4),
                                Text(
                                  "Apartment",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(12),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.2),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.apartment_rounded,
                                  color: Colors.white,
                                ),
                                Gap(4),
                                Text(
                                  "Apartment",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed("/detail");
                            },
                            child: Container(
                              height: 400,
                              margin: const EdgeInsets.only(bottom: 24),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://cdn.pixabay.com/photo/2021/08/23/01/03/cubic-house-6566412_1280.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 18,
                                              color: Colors.orange,
                                            ),
                                            Gap(8),
                                            Text(
                                              "5.0",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      CircleAvatar(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        child: Icon(
                                          Icons.favorite,
                                        ),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.3),
                                      ),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 6,
                                          sigmaY: 8,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "The Elements",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "\$1,200",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text("/Night"),
                                              ],
                                            ),
                                            Gap(6),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                                Gap(6),
                                                Text(
                                                  "South Korea",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Gap(6),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.bed,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                                Gap(6),
                                                Text("2 bad",  style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                ),),
                                                Gap(12),
                                                Icon(
                                                  Icons.bathtub_outlined,
                                                  color: Colors.white,size: 18,
                                                ),
                                                Gap(6),
                                                Text("1 bath",  style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                ),),
                                                Gap(12),
                                                Icon(
                                                  Icons.expand,
                                                  color: Colors.white,size: 18,
                                                ),
                                                Gap(6),
                                                Text("250.00 m2",  style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                ),),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 24,
              left: 32,
              right: 32,
              child: Container(
                decoration: const ShapeDecoration(
                  shape: StadiumBorder(),
                  color: Colors.black,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          pageIndex = 0;
                        });
                      },
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: pageIndex == 0 ? Colors.white : Colors.transparent,
                        foregroundColor: pageIndex == 0 ? Colors.black : Colors.white,
                        child: const Icon(
                          Icons.home_filled,
                          size: 30,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          pageIndex = 1;
                        });
                      },
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: pageIndex == 1 ? Colors.white : Colors.transparent,
                        foregroundColor: pageIndex == 1 ? Colors.black : Colors.white,
                        child: const Icon(
                          Icons.list_alt,
                          size: 30,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          pageIndex = 2;
                        });
                      },
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: pageIndex == 2 ? Colors.white : Colors.transparent,
                        foregroundColor: pageIndex == 2 ? Colors.black : Colors.white,
                        child: const Icon(
                          Icons.favorite_border,
                          size: 30,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.blue,
                        // backgroundColor: pageIndex == 3 ? Colors.white : Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
