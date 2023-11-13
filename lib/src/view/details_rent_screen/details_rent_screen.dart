import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/model/rating_and_review_Model/rating_and_review_Model.dart';
import 'package:pgroom/src/model/user_rent_model/user_rent_model.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';
import 'package:pgroom/src/view/details_rent_screen/widget/circle_Container_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../uitels/icon_and_name_widgets/detaails_row_widgets.dart';

class DetailsRentInfoScreen extends StatelessWidget {
  DetailsRentInfoScreen({super.key});

  final imageIndecterController = PageController();

  final reviewController = TextEditingController();

  final itemId = Get.arguments["id"];

  UserRentModel data = Get.arguments['list'];
  var raingNow;

  List<  RatingAndReviewModel > ratingList = [];

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("build - deataislRnatInfoScreen 🍎 ");
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Center(
                child: Text(
                  "${data.houseName}",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              // Image(image: AssetImage(roomImage)),

              //=======Page view======
              Container(
                height: 250,
                width: double.infinity,
                child: PageView(
                  controller: imageIndecterController,
                  children: [
                    Image(
                        image: NetworkImage(data.coverImage.toString()),
                        fit: BoxFit.cover),
                    const Image(
                        image: AssetImage(room2Image), fit: BoxFit.cover),
                    const Image(
                        image: AssetImage(room3Image), fit: BoxFit.cover),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.center,
                child: SmoothPageIndicator(
                    controller: imageIndecterController,
                    count: 3,
                    effect: const WormEffect(
                      dotHeight: 6,
                    )),
              ),

              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 15)),
                  const Text(
                    "Address :- ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Text(
                      "${data.addres}",
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Padding(padding: EdgeInsets.only(left: 15)),
                  const Text(
                    "Rental Room Type :-",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text("  ${data.roomType}")
                ],
              ),

              const Padding(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  "Price :-",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Column(
                  children: [
                    if (data.singlePersonPrice != "")
                      DetailsRowWidgets(
                        title: "Single Person :-  ",
                        price: '${data.singlePersonPrice}/- '
                            'month',
                        isIcon: true,
                      ),
                    if (data.doublePersionPrice != "")
                      DetailsRowWidgets(
                        title: "doble Person :-  ",
                        price: '${data.doublePersionPrice}/- '
                            'month',
                        isIcon: true,
                      ),
                    if (data.triplePersionPrice != "")
                      DetailsRowWidgets(
                        title: "triple Person :-  ",
                        price: '${data.triplePersionPrice}/- '
                            'month',
                        isIcon: true,
                      ),
                    if (data.fourPersionPrice != "")
                      DetailsRowWidgets(
                        title: "four Pluse Person :-  ",
                        price: '${data.fourPersionPrice}/- '
                            'month',
                        isIcon: true,
                      ),
                    if (data.faimlyPrice != "")
                      DetailsRowWidgets(
                        title: "Famaily  :-  ",
                        price: '${data.faimlyPrice}/- '
                            'month',
                        isIcon: true,
                      ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  "Services :-",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DetailsRowWidgets(
                    title: "Wi-Fi",
                    isIcon: data.wifi!,
                  ),
                  DetailsRowWidgets(
                    title: "Fan",
                    isIcon: data.fan!,
                  ),
                  DetailsRowWidgets(
                    title: "Light",
                    isIcon: data.light!,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DetailsRowWidgets(
                    title: "table",
                    isIcon: data.table!,
                  ),
                  DetailsRowWidgets(
                    title: "chair",
                    isIcon: data.chair!,
                  ),
                  DetailsRowWidgets(
                    title: "locker",
                    isIcon: data.locker!,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DetailsRowWidgets(
                    title: "Bed",
                    isIcon: data.bed!,
                  ),
                  DetailsRowWidgets(
                    title: "gadda",
                    isIcon: data.gadda!,
                  ),
                  DetailsRowWidgets(
                    title: "bed sheet",
                    isIcon: data.bedSheet!,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DetailsRowWidgets(
                    title: "parking",
                    isIcon: data.parking!,
                  ),
                  DetailsRowWidgets(
                    title: "barhroom \n attech",
                    isIcon: false,
                  ),
                  DetailsRowWidgets(
                    title: "barhroom \n shareable",
                    isIcon: false,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  "Bills & charges:-",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DetailsRowWidgets(
                    title: "Electricity bill",
                    isIcon: data.electricityBill!,
                  ),
                  DetailsRowWidgets(
                    title: "water bill",
                    isIcon: data.waterBill!,
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Row(
                  children: [
                    const Text(
                      "Time :-  ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    (data.restrictedTime != '')
                        ? Text(" Restricted - ${data.restrictedTime}")
                        : const Text("Fexible"),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  "Permission:-",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, top: 15),
                child: Column(
                  children: [
                    if (data.girls != "")
                      DetailsRowWidgets(
                        title: "Girl Allow",
                        isIcon: data.girls!,
                      ),
                    if (data.boy != "")
                      DetailsRowWidgets(
                        title: "Boy Allow",
                        isIcon: data.boy!,
                      ),
                    if (data.faimlyMember != "")
                      DetailsRowWidgets(
                        title: "family member Allow",
                        isIcon: data.faimlyMember!,
                      ),
                    if (data.cooking!)
                      DetailsRowWidgets(
                        title: "cooking Allow :-  ${data.cookingType}",
                        isIcon: data.cooking!,
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("contect now"),
                ),
              ),

              const SizedBox(
                height: 50,
              ),
              ///===========================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //=========share =========
                  CircleContainerWidgets(
                    title: 'Share',
                    iconData: Icons.share_outlined,
                    ontap: () {},
                  ),

                  // ==========map view ===========
                  CircleContainerWidgets(
                      title: "Map view",
                      iconData: Icons.location_on_outlined,
                      ontap: () {})
                ],
              ),

              ///======================================================


              ///Rating Now
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 50),
                child: Text(
                  "Rating now :-",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Align(
                alignment: Alignment.center,
                child: RatingBar.builder(
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {

                    raingNow = rating;
                    if (kDebugMode) {
                      print(rating);
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: reviewController,
                maxLines: 3,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.yellow.shade50,
                    border: const OutlineInputBorder(),
                    hintText: "write your Review..."),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {

                    ApisClass.ratingAndReviewCreateData(raingNow,
                        reviewController.text, itemId).then((value) {

                          Get.snackbar("raing", "submit");
                    }).onError((error, stackTrace) {
                      Get.snackbar("error", "error");
                      print(error);
                    });

                  },
                  child: const Text("Submit"),
                ),
              ),


              const Padding(
                padding: EdgeInsets.only(left: 15, top: 50),
                child: Text(
                  "Review :-",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ),

              
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StreamBuilder(
                      stream: ApisClass.firestore.collection("userReview").doc
                        ("reviewCollection").collection("$itemId").snapshots(),
                      builder: (context, snapshot){
                        final data = snapshot.data?.docs;

                        ratingList = data
                            ?.map((e) => RatingAndReviewModel.fromJson(e.data()))
                            .toList() ??
                            [];

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: ratingList.length,
                            itemBuilder: (context, index){
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                 Row(
                                   children: [
                                     Container(
                                       height: 25,
                                       width: 25,
                                       decoration:BoxDecoration(
                                         borderRadius: BorderRadius.circular(50),
                                         color: Colors.blue
                                       ),

                                     ),
                                     SizedBox(width: 10,),
                                     Text("Manish sahu",style: TextStyle
                                       (fontWeight: FontWeight.w600),),
                                   ],
                                 ),

                                  RatingBar.builder(
                                    ignoreGestures: true,
                                    itemSize: 17,
                                    initialRating: ratingList[index].rating!,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric
                                      (horizontal: 2.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ), onRatingUpdate: (double value) {  },

                                  ),
                                  Container(
                                     margin: EdgeInsets.only(top: 10,bottom: 20),
                                    padding: EdgeInsets.all(10.0),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50
                                    ),
                                    child: Text("${ratingList[index].title}"),
                                  )


                                ],
                              );


                            });

                      }
                  ),
                ],
              ),

              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
