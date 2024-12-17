import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/room_rent_all_screen/home/Controller/home_page_controller.dart';
import 'package:pgroom/src/features/room_rent_all_screen/home/widgets/ItemListView.dart';
import 'package:pgroom/src/features/room_rent_all_screen/home/widgets/appbar_widgets.dart';
import 'package:pgroom/src/features/sell_and_buy_screen/model/buy_and_sell_model.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/Constants/image_string.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../data/repository/apis/apis.dart';
import '../../../model/user_rent_model/user_rent_model.dart';
import '../../Home_fitter_new/new_search_home/new_home_screen.dart';
import '../../Rooms_screen_new/list_of_rooms/list_of_rooms.dart';

class ListOfRooms extends StatefulWidget {
  const ListOfRooms({super.key});

  @override
  State<ListOfRooms> createState() => _ListOfRoomsState();
}

class _ListOfRoomsState extends State<ListOfRooms> {
  List<BuyAndSellModel> buyAndSellList = [];

  var snapData;

  int currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - ListOfSellAndBuy......................................");
    return Scaffold(
      //==PreferredSize provide a maximum appbar length
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(155), child: Text('sdf')),

      //======drawer code ===============
      // drawer:  DrawerScreen(),
      //=======list view builder code==============
      body: CustomMaterialIndicator(
        onRefresh: () async {
          return await Future.delayed(const Duration(seconds: 2));
        },
        indicatorBuilder:
            (BuildContext context, IndicatorController controller) {
          return const Icon(
            Icons.refresh,
            color: Colors.blue,
            size: 30,
          );
        },
        child: StreamBuilder(
            stream: ApisClass.firebaseFirestore
                .collection('DevBuyAndSellCollection')
                .snapshots(),
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

                  buyAndSellList = data
                      ?.map((e) => BuyAndSellModel.fromJson(e.data()))
                      .toList() ??
                      [];

                  return ListView.builder(
                    // controller: _scrollController,
                    itemCount: buyAndSellList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const DetailsOfSellAndBuy()));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 12,left: 12,right: 12),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image Slider
                              Container(
                                height: 200, // Set a fixed height for the PageView
                                child: Stack(
                                  children: [
                                    PageView.builder(

                                      scrollDirection: Axis.horizontal,
                                      itemCount: buyAndSellList[index].image?.length,
                                      onPageChanged: (int page) {
                                        setState(() {
                                          // currentPage = page;
                                        });
                                      },
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 8),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10.0),
                                            child: CachedNetworkImage(
                                              imageUrl: buyAndSellList[index].image!.first.toString(),
                                              placeholder: (context, url) =>
                                              const Center(child: CircularProgressIndicator()),
                                              errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Positioned(
                                      bottom: 1,
                                      right: 8,
                                      child: Container(
                                        margin: const EdgeInsets.all(8),
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          '',// '${currentPage + 1}/ ${roomImages.length}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 1,
                                      left: 1,
                                      child: Container(
                                          margin: const EdgeInsets.all(8),
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.5),
                                            borderRadius: BorderRadius.circular(100),
                                          ),
                                          child: false ? const Icon(Icons.favorite ,color: Colors.red,) :const Icon(Icons.favorite_border_outlined,color: Colors.white,size: 20,)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Room details
                              Text(
                                '${buyAndSellList[index].itemName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),


                              const SizedBox(height: 4),
                              // Room details
                              Text(
                                '₹ ${buyAndSellList[index].price}/-',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              const SizedBox(height: 4),
                              Text(
                                '${buyAndSellList[index].landmark},${buyAndSellList[index].address},${buyAndSellList[index].city},${buyAndSellList[index].state}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14),
                              ),

                              const SizedBox(height: 16),
                              // Buttons for "Chat Now" and "Call Now"
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Colors.black, Colors.blueAccent],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    'https://plus.unsplash.com/premium_photo-1668127295858-552a0ef56309?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Z2lybCUyMGltYWdlc3xlbnwwfHwwfHx8MA%3D%3D'),
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                'John Doe',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'POST',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white70,
                                                ),
                                              ),
                                              Text(
                                                '12/12/2000',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      // Buttons for "Chat Now" and "Call Now"
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // Chat Now Button with Gradient
                                          // GradientButton(
                                          //   icon: Icons.chat,
                                          //   label: 'Chat Now',
                                          //   colors: [Colors.orange, Colors.red],
                                          //   onPressed: () {
                                          //     // Handle chat action
                                          //   },
                                          // ),
                                          // // Call Now Button with Gradient
                                          // GradientButton(
                                          //   icon: Icons.phone,
                                          //   label: 'Call Now',
                                          //   colors: [Colors.green, Colors.teal],
                                          //   onPressed: () {
                                          //     // Handle call action
                                          //   },
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );

              }
            }),
      ),
    );
  }
}
