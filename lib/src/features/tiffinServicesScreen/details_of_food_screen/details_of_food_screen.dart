import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';

import '../../../utils/Constants/colors.dart';

class TiffinDetailScreen extends StatelessWidget {
  const TiffinDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details food"),),

      body: Column(
        children: [

          Card(
            margin: EdgeInsets.all(5),
            
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
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
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
            child: Column(
              children: [

                Text(
                  " Name of Food Servises and Deviler  Name of Food Servises and Deviler",
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Icon(Icons.star,color: Colors.yellow,),
                    SizedBox(width: 2,),
                    Text("3.4",style: TextStyle(fontSize: 17),),
                    SizedBox(width: 5,),
                    Text("(258 Ratings)"),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text("Price :- 50/- day  ",style: TextStyle(fontSize: 18),)
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text("Address :- ",style: TextStyle(fontSize: 18),),
                    Flexible(
                      child: Text("Gour colony yadunandan nager tifra Bilaspur chhattigrh",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        softWrap: false,),
                    )
                  ],
                ),
                SizedBox(height: 10,),

                InkWell(
                  onTap: (){
                    showModalBottomSheet(
                        context: context,
                        builder: (context){
                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
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
                        style: TextStyle(fontSize: 16,color: Colors.blue),
                      ),
                      Icon(Icons.keyboard_arrow_down_sharp,color: Colors.blue,)
                    ],
                  ),
                ),

                SizedBox(height: 50,),
                ComReuseElevButton(onPressed: (){}, title:"Contact now"),

              ],
            ),
          )
        ],
      ),
    );
  }
}

