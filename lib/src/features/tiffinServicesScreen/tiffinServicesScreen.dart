import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';

import '../../utils/Constants/colors.dart';

class TiffineServicesScreen extends StatelessWidget {
  const TiffineServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("food"),
      ),
      body:  ListView.builder(
        itemCount: 5,
          itemBuilder: (context,index){

            return   InkWell(
              onTap: (){
               Get.toNamed(RoutesName.tiffinDetailsScreen);
              },
              child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                        'https://media.istockphoto.com/id/1372205277/photo/traditional-indian-food-thali-served-in-plate-top-view.jpg?s=612x612&w=0&k=20&c=mufjX4i0bjmNB_9VSrbQ0zLOBH08FWZb5oFcOItclVc=',
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


                      Padding(
                        padding: const EdgeInsets.only(left: 5,top: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              " Name of Food Servises and Deviler  Name of Food Servises and Deviler",
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 1,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star,color: Colors.yellow,),
                                SizedBox(width: 2,),
                                Text("3.4",style: TextStyle(fontSize: 17),),
                                SizedBox(width: 5,),
                                Text("(258 Ratings)"),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text("Address :- Gour colony yaduna skjdf dskjfhs fsknfskd sfjs sdsk df",
                                  softWrap: false,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text("Stating Price :- 80 Ru  day/- ")
                              ],
                            )
                          ],
                        ),
                      ),

                      SizedBox(height: 8,),


                    ],
                  )),
            );
          })
    );
  }
}
