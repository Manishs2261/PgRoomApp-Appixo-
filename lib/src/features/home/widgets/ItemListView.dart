import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import '../../../model/user_rent_model/user_rent_model.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../utils/helpers/helper_function.dart';

class ItemListView extends StatelessWidget {
  const ItemListView({
    super.key,
    required this.rentList,
    this.snapshot,
  });

  final List<UserRentModel> rentList;
  final snapshot;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 0.2, right: 0.2),
        itemCount: rentList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              final itemId = snapshot.data?.docs[index].id;

              Get.toNamed(RoutesName.detailsRentInfoScreen, arguments: {
                'list': rentList[index],
                'id': itemId,
              });
            },
            child: Container(

              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: 180,
                maxHeight: 200
              ),
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
                            "${rentList[index].houseName}",
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
                            "Address:-${rentList[index].address} ",
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
                            : Text("Room Type - ${rentList[index].roomType} - ${rentList[index].bhkType}"),

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
          );
        });
  }
}
