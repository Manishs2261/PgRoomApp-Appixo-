import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';

import '../../../data/repository/apis/apis.dart';
import '../../../utils/Constants/colors.dart';
import '../details_rooms/details_room.dart';

class ListOfRooms extends StatefulWidget {
  const ListOfRooms({super.key});

  @override
  State<ListOfRooms> createState() => _ListOfRoomsState();
}

class _ListOfRoomsState extends State<ListOfRooms> {
  late ScrollController _scrollController;
  double _buttonOpacity = 1.0;
  var snapData;
  final List<String> roomImages = [
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
  ];

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Add scroll listener to update button opacity
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        // User is scrolling down, reduce the button's opacity
        setState(() {
          _buttonOpacity = 0.0;
        });
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        // User is scrolling up, increase the button's opacity
        setState(() {
          _buttonOpacity = 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 4,
                            offset: Offset(1, 2))
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          Icon(
                            Icons.search_rounded,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text.rich(
                        style: TextStyle(fontSize: 12),
                        TextSpan(
                          text: 'Awesome! ',
                          children: <TextSpan>[
                            TextSpan(
                              text: '8',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' results found for '),
                            TextSpan(
                              text: 'pg!',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 12, bottom: 12),
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.blue,
                            ),
                            Text(
                              'Add Location',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Row(
                                children: [
                                  Text(
                                    'Bilaspur',
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 0,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  CircleAvatar(
                                      backgroundColor:
                                          Colors.blueAccent.withOpacity(0.1),
                                      radius: 8,
                                      child: Icon(
                                        Icons.close,
                                        color: AppColors.primary,
                                        size: 14,
                                      ))
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: StreamBuilder(
                      stream: ApisClass.firebaseFirestore
                          .collection('newRoomDetails')
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
                           // final data = snapshot.data?.docs;

                            // for creating json model

                            // for(var i in data!)
                            //   {
                            //     log("Data : ${jsonEncode(i.data())}");
                            //   }

                            snapData = snapshot;


                            return  ListView.builder(
                            controller: _scrollController,
                                                    itemCount: 5,
                                                    itemBuilder: (context, index) {
                                                    return InkWell(
                                                    onTap: () {
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => DetailsRoom()));
                                                    },
                                                    child: Container(
                                                    margin: EdgeInsets.only(top: 12, left: 12, right: 12),
                                                    // You can adjust this height to fit the content
                                                    padding: const EdgeInsets.all(12.0),
                                                    decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(16.0),
                                                    boxShadow: [
                                                    BoxShadow(
                                                    color: Colors.grey.withOpacity(0.3),
                                                    spreadRadius: 1,
                                                    blurRadius: 1,
                                                    offset: Offset(0, 1),
                                                    ),
                                                    ],
                                                    ),
                                                    child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                    // Image Slider
                                                    Container(
                                                    height: 140,
                                                    // Set a fixed height for the PageView
                                                    child: Stack(
                                                    children: [
                                                    PageView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: roomImages.length,
                                                    onPageChanged: (int page) {
                                                    setState(() {
                                                    currentPage = page;
                                                    });
                                                    },
                                                    itemBuilder: (context, index) {
                                                    return Padding(
                                                    padding:
                                                    const EdgeInsets.only(right: 8),
                                                    child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(10.0),
                                                    child: CachedNetworkImage(
                                                    imageUrl: roomImages[index],
                                                    placeholder: (context, url) => Center(
                                                    child:
                                                    CircularProgressIndicator()),
                                                    errorWidget:
                                                    (context, url, error) =>
                                                    Icon(Icons.error),
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
                                                    margin: EdgeInsets.all(8),
                                                    padding:
                                                    EdgeInsets.symmetric(horizontal: 8),
                                                    decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                    BorderRadius.circular(50),
                                                    ),
                                                    child: Text(
                                                    '${currentPage + 1}/ ${roomImages.length}',
                                                    style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    ),
                                                    ),
                                                    ),
                                                    ),
                                                    Positioned(
                                                    top: 1,
                                                    left: 1,
                                                    child: Container(
                                                    margin: EdgeInsets.all(8),
                                                    padding: EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                    color:
                                                    Colors.black.withOpacity(0.5),
                                                    borderRadius:
                                                    BorderRadius.circular(100),
                                                    ),
                                                    child: false
                                                    ? Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                    )
                            : Icon(
                                                    Icons
                            .favorite_border_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                    )),
                                                    ),
                                                    ],
                                                    ),
                                                    ),
                                                    SizedBox(height: 12),
                                                    // Room details
                                                    Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                    Text(
                                                    '₹500/-',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    ),
                                                    ),
                                                    Container(
                                                    padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 2),
                                                    decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(4),
                                                    color: Colors.blueAccent,
                                                    ),
                                                    child: Text(
                                                    'BOYS',
                                                    style: TextStyle(
                                                    color: Colors.white, fontSize: 12),
                                                    ),
                                                    ),
                                                    ],
                                                    ),
                                                    SizedBox(height: 4),
                                                    Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                    Text(
                                                    'Room Name',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(fontSize: 14),
                                                    ),
                                                    Container(
                                                    padding: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 2),
                                                    decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(4),
                                                    color: Colors.amber,
                                                    ),
                                                    child: Text(
                                                    'PG',
                                                    style: TextStyle(
                                                    fontSize: 12,
                                                    ),
                                                    ),
                                                    ),
                                                    ],
                                                    ),

                                                    SizedBox(height: 4),
                                                    Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                    Text(
                                                    'Shareable',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.green,
                                                    fontStyle: FontStyle.italic),
                                                    ),
                                                    Row(
                                                    children: [
                                                    const Icon(
                                                    Icons.star,
                                                    size: 18,
                                                    color: Colors.orange,
                                                    ),
                                                    const Gap(4),
                                                    Text(
                                                    "2.5",
                                                    style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    ),
                                                    )
                                                    ],
                                                    ),
                                                    ],
                                                    ),

                                                    SizedBox(height: 4),
                                                    Text(
                                                    'Address: 123 Main St, Springfield Addrfgff dgfdkf ess: 123 Main St, SpringfieldAddress: 123 Main St, Springfield',
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(fontSize: 14),
                                                    ),
                                                    SizedBox(height: 4),
                                                    Card(
                                                    shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(16.0),
                                                    ),
                                                    child: Container(
                                                    decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                    colors: [Colors.black, Colors.blueAccent],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    ),
                                                    borderRadius: BorderRadius.circular(16.0),
                                                    ),
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                    Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                    Row(
                                                    children: [
                                                    CircleAvatar(
                                                    radius: 16,
                                                    backgroundImage: NetworkImage(
                                                    'https://plus.unsplash.com/premium_photo-1668127295858-552a0ef56309?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Z2lybCUyMGltYWdlc3xlbnwwfHwwfHx8MA%3D%3D'),
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                    'John Doe',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    ),
                                                    ),
                                                    ],
                                                    ),
                                                    Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                    Text(
                                                    'Updated',
                                                    style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white70,
                                                    ),
                                                    ),
                                                    Text(
                                                    '3w ago',
                                                    style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white70,
                                                    ),
                                                    ),
                                                    ],
                                                    ),
                                                    ],
                                                    ),
                                                    SizedBox(height: 8),
                                                    // Buttons for "Chat Now" and "Call Now"
                                                    Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                    // Chat Now Button with Gradient
                                                    GradientButton(
                                                    icon: Icons.chat,
                                                    label: 'Chat Now',
                                                    colors: [Colors.orange, Colors.red],
                                                    onPressed: () {
                                                    // Handle chat action
                                                    },
                                                    ),
                                                    // Call Now Button with Gradient
                                                    GradientButton(
                                                    icon: Icons.phone,
                                                    label: 'Call Now',
                                                    colors: [Colors.green, Colors.teal],
                                                    onPressed: () {
                                                    // Handle call action
                                                    },
                                                    ),
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

              ],
            ),
          ),

          // Floating button at the bottom center
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: _buttonOpacity,
                child: FloatingActionButton.extended(
                    elevation: 2,
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      // Add action for the button
                    },
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.filter_list,
                              color: Colors.white,
                            ),
                            Text(
                              "Sort",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.filter_alt_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              "Filter",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<Color> colors;
  final VoidCallback onPressed;

  GradientButton({
    required this.icon,
    required this.label,
    required this.colors,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors, // Button gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 16, // White icon
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                  color: Colors.white, // White text
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
