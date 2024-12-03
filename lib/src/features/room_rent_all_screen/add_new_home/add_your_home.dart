import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import '../../../data/repository/apis/apis.dart';
import '../../../model/user_rent_model/user_rent_model.dart';

// ignore: must_be_immutable
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
          ReuseElevButton(
            onPressed: () => Get.toNamed(RoutesName.addImageScreen),
            title: "Add New Room",
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
                          itemCount: rentList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  height: 240,
                                  width: double.infinity,
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: dark ? AppColors.dark : Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(.8),
                                          offset: const Offset(2, 4),
                                        )
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          children: [
                                            //====== front image========

                                            Container(
                                              width: 150,
                                              height: 280,
                                              decoration: BoxDecoration(
                                                  color: dark ? Colors.blueGrey.shade900 : Colors.grey.shade200,
                                                  borderRadius: BorderRadius.circular(5)),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
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
                                            ),

                                            const SizedBox(
                                              width: 10,
                                            ),
                                            // =====Details ============

                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Gap(10),
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
                                                      text: 'Rent ₹',
                                                      style: DefaultTextStyle.of(context).style,
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: (rentList[index].singlePersonPrice!.isNotEmpty)
                                                                ? '${rentList[index].singlePersonPrice}'
                                                                : '${rentList[index].familyPrice}',
                                                            style: const TextStyle(fontWeight: FontWeight.bold)),
                                                        const TextSpan(text: '/-Monthly'),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      "Address:- ${rentList[index].address} ",
                                                      overflow: TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Flexible(child: Text("City - ${rentList[index].city}")),
                                                  (rentList[index].bhkType!.isEmpty)
                                                      ? Flexible(
                                                          child: Text(
                                                          "Room Type - ${rentList[index].roomType}",
                                                          maxLines: 1,
                                                        ))
                                                      : Flexible(
                                                          child: Text(
                                                            "Room Type - ${rentList[index].roomType} - "
                                                            "${rentList[index].bhkType}",
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  (rentList[index].roomAvailable!)
                                                      ? Text(
                                                          "Available :- ${rentList[index].numberOfRooms}",
                                                          style: const TextStyle(color: Colors.green),
                                                        )
                                                      : const Text(
                                                          "Not Available",
                                                          style: TextStyle(color: Colors.red),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Gap(5),
                                      SizedBox(
                                          width: double.infinity,
                                          child: OutlinedButton(
                                              onPressed: () {
                                                final itemId = snapshot.data?.docs[index].id;
                                                final imageUrl = rentList[index].coverImage;
                                                Get.toNamed(
                                                  RoutesName.editAddNewHome_Screen,
                                                  arguments: {'list': rentList[index], 'id': itemId, 'url': imageUrl},
                                                );
                                              },
                                              child: const Text(
                                                "Edit",
                                                style: TextStyle(color: Colors.blue),
                                              )))
                                    ],
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
