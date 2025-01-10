import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pgroom/src/features/foods_screen_new/model/food_model.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/widgets/faq_widgets.dart';

import '../../../utils/widgets/com_ratingbar_widgets.dart';
import '../../../utils/Constants/colors.dart';
import '../../../utils/Constants/image_string.dart';

class DetailsFood extends StatefulWidget {
  const DetailsFood({super.key});

  @override
  State<DetailsFood> createState() => _DetailsFoodState();
}

class _DetailsFoodState extends State<DetailsFood> {

  final FoodModel  data = Get.arguments;


  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title:  Text(
          data.shopName.toString(),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: Colors.black,
              ))
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 1,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.center,
              width: AppHelperFunction.screenWidth() * 0.4,
              height: 40,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('Chat Now'),
            ),
            Container(
              alignment: Alignment.center,
              height: 40,
              width: AppHelperFunction.screenWidth() * 0.4,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 204, 102, 1.0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Call Now',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterFloat,
      body: SingleChildScrollView(
        child: Padding(
          padding:
          const EdgeInsets.only(right: 16, top: 16, left: 16, bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                width: 400, // Set a fixed height for the PageView
                child: Stack(
                  children: [
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.imageList?.length,
                      onPageChanged: (int page) {
                        setState(() {
                          currentPage = page;
                        });
                      },
                      itemBuilder: (context, imageIndex) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              imageUrl: data.imageList?[imageIndex] ?? '',
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
                      bottom: 16,
                      right: 4,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          '${currentPage + 1}/ ${data.imageList?.length}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: false
                              ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                              : const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Expanded(
                    child: Text(
                      '${data.shopName}',
                      maxLines: 2,

                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,height:0),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.green,
                    ),
                    child:  Text(
                      '${data.foodCategory}',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4,),
               Text(
                '${data.description}',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.grey),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.blue,
                ),
                child:  Text(
                  '${data.typeOfShop}',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),

              const SizedBox(
                height: 16,
              ),
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
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImage.mapIcon),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Add some spacing between the icon and text
                       Expanded(
                        // Allow the column to take up the remaining space
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Align text to the start
                          children: [
                            Text(
                              '${data.landmark} ${data.address}, ${data.city}, ${data.state}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            InkWell(
                              onTap: ()=> AppHelperFunction.launchMap(double.parse(data.latitude.toString()), double.parse(data.longitude.toString())),
                              child: Text(
                                'View On Map',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Subscription',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all()),
                child: Column(
                  children:  data.fAQ!.map((room) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                room.question.toString(),
                                style: const TextStyle(fontWeight: FontWeight.w500,),
                              ),
                            ),
                            Text(
                              '₹${room.answer}/-',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Daily meals',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 1.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child:    Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(

                  ),
                  child: Column(
                    children:  data.dailyItemList!.map((room) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  room.name.toString(),
                                  style: const TextStyle(fontWeight: FontWeight.w400,),
                                ),
                              ),
                              Text(
                                '₹${room.price}/-',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          const Divider(),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(
                height: 16,
              ),
              const Text(
                'Mess Rules',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                  children:  data.messRules!.map((rule) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.greenAccent,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(child: Text(rule))
                        ],
                      ),
                    );
                  }).toList()),

              const SizedBox(height: 16,),
              Container(
                width:double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Submit Your Review'),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
              const SizedBox(height: 16,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Review',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,

                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.blue),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                height: 25,
                                width: 25,
                                fit: BoxFit.cover,
                                imageUrl: "",
                                placeholder: (context, _) =>  const Center(
                                  child: SpinKitFadingCircle(
                                    color: AppColors.primary,
                                    size: 30,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                const CircleAvatar(
                                    backgroundColor: AppColors.primary,
                                    child: Icon(CupertinoIcons.person,size: 18,color: Colors.white,)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Manish sahu",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const Text('12/12/2000',style: TextStyle(color: Colors.grey,fontSize: 10),)
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    children: [
                      ComRatingBarWidgets(
                        initialRating: 5,
                        itemSize: 10.0,
                        ignoreGestures: true,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "2.5",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    padding: const EdgeInsets.all(10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppHelperFunction.isDarkMode(context)
                            ? Colors.blueGrey.shade900
                            : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text("To add an underline to your Text widget in Flutter, you can modify the TextStyle to include decoration: TextDecoration.underline. Here's how you can update your code:"),
                  ),
                ],
              ),


              Container(
                width:double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Report About Mess',style: TextStyle(color: Colors.white),),
                    Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,)
                  ],
                ),
              ),

              const SizedBox(
                height: 16,
              ),
              const Text(
                'FAQ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

              Column(
                children: data.fAQ!.map((faq) {
                  // Mapping each FAQ item to a FAQTile widget
                  return FAQWidgets(
                    question: faq.question!,
                    answer: faq.answer!,
                  );
                }).toList(),
              ),


            ],
          ),
        ),
      ),
    );
  }
}



