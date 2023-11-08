import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pgroom/main.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/view/edit_add_new_home/edit_add_new_home.dart';

import '../../model/user_rent_model/user_rent_model.dart';
import '../../repositiry/apis/apis.dart';
import '../details_rent_screen/details_rent_screen.dart';
import '../rent_form_screen/add_image_/add_image_screen.dart';

class AddYourHome extends StatefulWidget {
  const AddYourHome({super.key});

  @override
  State<AddYourHome> createState() => _AddYourHomeState();
}

class _AddYourHomeState extends State<AddYourHome> {
  List<UserRentModel> rentList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: mediaQuery.width * .8,
            child: ElevatedButton(
              onPressed: () {
                 Get.toNamed(RoutesName.addImageScreen);
              },
              child: Text("Add New "),
            ),
          ),
          SizedBox(height: 15,),
          Expanded(
            child: StreamBuilder(
                stream: ApisClass.firestore
                    .collection('userRentDetails')
                    .doc(ApisClass.user.uid)
                    .collection("${ApisClass.user.uid}")
                    .snapshots(),
                // stream: ApisClass.firestore.collection('rentUser').doc
                //   ("s30wXWQIDuPPzjrNmf7Q").collection('permission').snapshots(),

                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;

                      // for(var i in data!)
                      //   {
                      //     log("Data : ${jsonEncode(i.data())}");
                      //   }

                      rentList = data
                              ?.map((e) => UserRentModel.fromJson(e.data()))
                              .toList() ??
                          [];

                      return ListView.builder(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          itemCount: rentList.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {

                                    final itemid = snapshot.data?.docs[index].id;
                                    final imageUrl = rentList[index].coverImage;
                                    Get.toNamed(RoutesName
                                        .editAddNewHome_Screen, arguments:
                                    {'list': rentList[index], 'id': itemid,
                                      'url': imageUrl},);

                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(200, 200, 40, 0.01),
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

                                          imageUrl:
                                              '${rentList[index].coverImage}',
                                          fit: BoxFit.fill,
                                          // placeholder: (context, url) => CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              CircleAvatar(
                                            child: Icon(Icons.image_outlined),
                                          ),
                                        ),

                                        SizedBox(
                                          width: 10,
                                        ),
                                        // =====Details ============

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  "${rentList[index].houseName} ",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500),
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
                                                  Text(
                                                      "${rentList[index].review}"),
                                                  Text(" (28 reviews)")
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text: 'Rent - ₹',
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text:
                                                            '${rentList[index].singlePersonPrice}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    TextSpan(
                                                        text: ' /- montly'),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  "${rentList[index].addres} ",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                  "city - ${rentList[index].city}"),
                                              Text(
                                                  "Room Type - ${rentList[index].roomType}")
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
                }),
          )
        ],
      ),
    );
  }
}
