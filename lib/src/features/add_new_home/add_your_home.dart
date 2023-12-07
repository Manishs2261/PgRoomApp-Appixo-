import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import '../../data/repository/apis/apis.dart';
import '../../model/user_rent_model/user_rent_model.dart';

class AddYourHome extends StatelessWidget {
  AddYourHome({super.key});

  List<UserRentModel> rentList = [];

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - AddYourHome");
    final dark = AppHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.only(top: 15)),

          //Button
          ComReuseElevButton(
            onPressed: () => Get.toNamed(RoutesName.addImageScreen),
            title: "Add New",
            loading: false,
          ),

          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: StreamBuilder(
                stream: ApisClass.firebaseFirestore
                    .collection('userRentDetails')
                    .doc(ApisClass.user.uid)
                    .collection(ApisClass.user.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;

                      // for(var i in data!)
                      //   {
                      //     log("Data : ${jsonEncode(i.data())}");
                      //   }

                      rentList = data?.map((e) => UserRentModel.fromJson(e.data())).toList() ?? [];

                      return ListView.builder(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          itemCount: rentList.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    final itemId = snapshot.data?.docs[index].id;
                                    final imageUrl = rentList[index].coverImage;
                                    Get.toNamed(
                                      RoutesName.editAddNewHome_Screen,
                                      arguments: {'list': rentList[index], 'id': itemId, 'url': imageUrl},
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    height: 200,
                                    width: double.infinity,
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

                                        Container(
                                          width: 150,
                                          height: 280,
                                          color: dark ? Colors.blueGrey.shade900 : Colors.grey.shade200,
                                          child: CachedNetworkImage(
                                              imageUrl: '${rentList[index].coverImage}',
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
                                                  "${rentList[index].houseName} ",
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
                                                  Text("${rentList[index].average}"),
                                                  Text(" (${rentList[index].numberOfRating} Reviews)")
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
                                                        text: (rentList[index].singlePersonPrice!.isNotEmpty)
                                                            ? '${rentList[index].singlePersonPrice}'
                                                            : '${rentList[index].familyPrice}',
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
                                                  "Adress:- ${rentList[index].address} ",
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text("City - ${rentList[index].city}"),
                                              (rentList[index].bhkType!.isEmpty)
                                                  ? Text("Room Type - ${rentList[index].roomType}")
                                                  : Text("Room Type - ${rentList[index].roomType} - "
                                                      "${rentList[index].bhkType}"),
                                              const SizedBox(
                                                height: 3,
                                              ),

                                              (rentList[index].roomAvailable!)
                                                  ?  Text("Available :- ${rentList[index].numberOfRooms}",style: TextStyle(color: Colors.green),)
                                                  : Text("Not Available",style: TextStyle(color: Colors.red),)
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
