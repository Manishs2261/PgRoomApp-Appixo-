import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';

import 'package:pgroom/src/view/auth_screen/login_screen/login_screen.dart';
import 'package:pgroom/src/view/details_rent_screen/details_rent_screen.dart';
import 'package:pgroom/src/view/search/search.dart';

import '../../model/user_rent_model/user_rent_model.dart';
import '../drawer_screen/drawer_screen.dart';
import '../splash/controller/splash_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<UserRentModel> rentList = [];
  var snapData ;

  @override
  Widget build(BuildContext context) {
    print("home build : Home Screen 🔴");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Get.toNamed(RoutesName.loginScreen);
        },
      ),
      //==preferrendSize provide a maximum appbar length
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125),
        child: SafeArea(
          child: Column(
            children: [
              //=======App bar code ====================
              AppBar(
                actions: [
                  //   ===post room free   ==================
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () {

                        (ApisClass.auth.currentUser?.uid == finalUserUidGloble)
                            ? Get.toNamed(RoutesName.addYourHomeScreen)
                            : Get.defaultDialog(
                                title: "Login please",
                                middleText:
                                    "Without lonin your are not post home",
                                actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Get.offAllNamed(
                                              RoutesName.loginScreen);
                                        },
                                        child: Text("Login"))
                                  ]);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        width: 135,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all()),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Post Room", textAlign: TextAlign.center),

                            //===========free container =============
                            Container(
                              alignment: Alignment.center,
                              height: 15,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                "Free",
                                style: TextStyle(fontSize: 10),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),

              //========search field code ==============
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 5,
                ),
                child: TextFormField(
                  onTap: () {
                    Get.toNamed(RoutesName.searchScreen, arguments: {
                      'list': rentList,
                      'id': snapData,
                    });
                  },
                  autofocus: false,
                  decoration: InputDecoration(
                    fillColor: Colors.yellow[50],
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Enter Locality / Landmark / Colony",
                    prefixIcon: Icon(Icons.search_rounded),
                    suffixIcon: Icon(Icons.mic),
                    isDense: false,
                    contentPadding: EdgeInsets.only(
                      bottom: 5,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

      //======drawer code ===============
      drawer: DrawerScreen(),
      //=======list view builder code==============
      body: StreamBuilder(
          stream: ApisClass.firestore.collection('rentCollection').snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
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
                return Center(
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
                rentList = data
                        ?.map((e) => UserRentModel.fromJson(e.data()))
                        .toList() ??
                    [];

                return ItemListView(
                  rentList: rentList,
                  snapshost: snapshot,
                );
            }
          }),
    );
  }
}

class ItemListView extends StatelessWidget {
  const ItemListView({
    super.key,
    required this.rentList,
    this.snapshost,
  });

  final List<UserRentModel> rentList;
  final snapshost;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(left: 5, right: 5),
        itemCount: rentList.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              // Navigation DetailRentInfo_Screen button
              GestureDetector(
                onTap: () {

                  final itemid = snapshost.data?.docs[index].id;

                  Get.toNamed(RoutesName.detailsRentInfoScreen, arguments: {
                    'list': rentList[index],
                    'id': itemid,
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(3),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(200, 200, 40, 0.01),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 3,
                        )
                      ]),
                  child: Row(
                    children: [
                      //====== front image========
                      CachedNetworkImage(
                        width: 150,
                        height: 300,

                        imageUrl: '${rentList[index].coverImage}',
                        fit: BoxFit.fill,
                        // placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => CircleAvatar(
                          child: Icon(Icons.image_outlined),
                        ),
                      ),

                      SizedBox(
                        width: 10,
                      ),
                      // =====Details ============

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                "${rentList[index].houseName} ",
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 17,
                                ),
                                Text("${rentList[index].review}"),
                                Text(" (28 reviews)")
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Rent - ₹',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          '${rentList[index].singlePersonPrice}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: ' /- montly'),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Flexible(
                              child: Text(
                                "${rentList[index].addres} ",
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text("city - ${rentList[index].city}"),
                            Text("Room Type - ${rentList[index].roomType}")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
