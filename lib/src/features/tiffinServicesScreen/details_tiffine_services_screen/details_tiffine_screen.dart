import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import '../../../utils/Constants/colors.dart';
import 'controller/controller.dart';

class DetailsTiffineServicesScreen extends StatelessWidget {
  DetailsTiffineServicesScreen({super.key});

  final controller = Get.put(DetailsTiffineController(Get.arguments["id"], Get.arguments['list']));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details food"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: controller.data.foodImage.toString(),
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.data.servicesName}",
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
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
                      "${controller.data.averageRating}",
                      style: TextStyle(fontSize: 17),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("(${controller.data.numberOfRating} Ratings)"),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Price :- ${controller.data.foodPrice} ₹/- day  ",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Address :- ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Flexible(
                      child: Text(
                        "${controller.data.address}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        softWrap: false,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    imageUrl: controller.data.menuImage.toString(),
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
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Row(
                    children: [
                      Text(
                        "View Menu",
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ComReuseElevButton(onPressed: () {}, title: "Contact now"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
