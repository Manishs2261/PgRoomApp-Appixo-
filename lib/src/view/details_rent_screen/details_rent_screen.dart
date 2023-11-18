import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/model/other_image_model.dart';
import 'package:pgroom/src/model/rating_and_review_Model/rating_and_review_Model.dart';
import 'package:pgroom/src/model/user_rent_model/user_rent_model.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/uitels/Constants/image_string.dart';
import 'package:pgroom/src/view/details_rent_screen/controller/details_screen_controller.dart';
import 'package:pgroom/src/view/details_rent_screen/widget/circle_Container_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../uitels/icon_and_name_widgets/detaails_row_widgets.dart';

class DetailsRentInfoScreen extends StatelessWidget {
  DetailsRentInfoScreen({super.key});

  // Getx Controller controller for besiness code
  final controller = Get.put(
      DetailsScreenController(Get.arguments["id"], Get.arguments['list']));
  final itemId = Get.arguments['id'];

  @override
  Widget build(BuildContext context) {
    //debug code ========
    if (kDebugMode) {
      print("build - deataislRnatInfoScreen 🍎 ");
    }
    //============
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  // house name
                  child: Text(
                    "${controller.data.houseName}",
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
                    controller: controller.imageIndecterController.value,
                    children: [
                      Image(
                          image: NetworkImage(
                              controller.data.coverImage.toString()),
                          fit: BoxFit.cover),
                      Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: (){
                                Get.toNamed(RoutesName.viewALlImage ,
                                    arguments: itemId);
                                },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 130,
                                decoration: BoxDecoration(
                                  color: Colors.blue[400],
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                child: Text("View All Photo",style: TextStyle
                                  (color: Colors.white,fontSize: 15,fontWeight:
                                FontWeight.w600,),),
                              ),
                            ),

                          ),


                    ],
                  ),
                ),
                //===============
                const SizedBox(
                  height: 5,
                ),

                // smooth page indicater ============
                Align(
                  alignment: Alignment.center,
                  child: SmoothPageIndicator(
                      controller: controller.imageIndecterController.value,
                      count: 2,
                      effect: const WormEffect(
                        dotHeight: 6,
                      )),
                ),
                //=================

                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 15)),

                    // house Address=====
                    const Text(
                      "Address :- ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Text(
                        "${controller.data.addres}",
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
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Text("  ${controller.data.roomType}")
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
                      if (controller.data.singlePersonPrice != "")
                        DetailsRowWidgets(
                          title: "Single Person :-  ",
                          price: '${controller.data.singlePersonPrice}/- '
                              'month',
                          isIcon: true,
                        ),
                      if (controller.data.doublePersionPrice != "")
                        DetailsRowWidgets(
                          title: "doble Person :-  ",
                          price: '${controller.data.doublePersionPrice}/- '
                              'month',
                          isIcon: true,
                        ),
                      if (controller.data.triplePersionPrice != "")
                        DetailsRowWidgets(
                          title: "triple Person :-  ",
                          price: '${controller.data.triplePersionPrice}/- '
                              'month',
                          isIcon: true,
                        ),
                      if (controller.data.fourPersionPrice != "")
                        DetailsRowWidgets(
                          title: "four Pluse Person :-  ",
                          price: '${controller.data.fourPersionPrice}/- '
                              'month',
                          isIcon: true,
                        ),
                      if (controller.data.faimlyPrice != "")
                        DetailsRowWidgets(
                          title: "Famaily  :-  ",
                          price: '${controller.data.faimlyPrice}/- '
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
                      isIcon: controller.data.wifi!,
                    ),
                    DetailsRowWidgets(
                      title: "Fan",
                      isIcon: controller.data.fan!,
                    ),
                    DetailsRowWidgets(
                      title: "Light",
                      isIcon: controller.data.light!,
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
                      isIcon: controller.data.table!,
                    ),
                    DetailsRowWidgets(
                      title: "chair",
                      isIcon: controller.data.chair!,
                    ),
                    DetailsRowWidgets(
                      title: "locker",
                      isIcon: controller.data.locker!,
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
                      isIcon: controller.data.bed!,
                    ),
                    DetailsRowWidgets(
                      title: "gadda",
                      isIcon: controller.data.gadda!,
                    ),
                    DetailsRowWidgets(
                      title: "bed sheet",
                      isIcon: controller.data.bedSheet!,
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
                      isIcon: controller.data.parking!,
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
                      isIcon: controller.data.electricityBill!,
                    ),
                    DetailsRowWidgets(
                      title: "water bill",
                      isIcon: controller.data.waterBill!,
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Row(
                    children: [
                      const Text(
                        "Time :-  ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      (controller.data.restrictedTime != '')
                          ? Text(
                              " Restricted - ${controller.data.restrictedTime}")
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
                      if (controller.data.girls != "")
                        DetailsRowWidgets(
                          title: "Girl Allow",
                          isIcon: controller.data.girls!,
                        ),
                      if (controller.data.boy != "")
                        DetailsRowWidgets(
                          title: "Boy Allow",
                          isIcon: controller.data.boy!,
                        ),
                      if (controller.data.faimlyMember != "")
                        DetailsRowWidgets(
                          title: "family member Allow",
                          isIcon: controller.data.faimlyMember!,
                        ),
                      if (controller.data.cooking!)
                        DetailsRowWidgets(
                          title:
                              "cooking Allow :-  ${controller.data.cookingType}",
                          isIcon: controller.data.cooking!,
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

                //===========================================
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

                //======================================================

                //Rating Now
                const Padding(
                  padding: EdgeInsets.only(left: 15, top: 50,bottom: 10),
                  child: Text(
                    "Rating now :-",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: RatingBar.builder(
                    initialRating: 0,
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
                      controller.raingNow = rating;
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
                  controller: controller.reviewController.value,
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
                      // call a controlle method
                      controller.onSubmitReviewButton();
                    },
                    child: const Text("Submit"),
                  ),
                ),

                Padding(
                  padding:
                      EdgeInsets.only(left: 15, top: 50, bottom: 20, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Review :-",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      InkWell(
                          onTap: () {
                            Get.toNamed(RoutesName.viewAllReview,
                                arguments: controller.itemId);
                          },
                          child: Text(
                            "view all",
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StreamBuilder(
                          stream: ApisClass.firestore
                              .collection("userReview")
                              .doc("reviewCollection")
                              .collection("${controller.itemId}")
                              .snapshots(),
                          builder: (context, snapshot) {

                            final snapshotdata = snapshot.data?.docs;
                            controller.ratingList = snapshotdata
                                    ?.map((e) =>
                                        RatingAndReviewModel.fromJson(e.data()))
                                    .toList() ??
                                [];

                            if (controller.ratingList.length == 0) {
                              controller.isView.value = false;
                              return Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.reviews_outlined),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text("No Review"),
                                ],
                              ));
                            } else {
                              Future.delayed(Duration.zero, () {
                                //your code goes here
                                controller.isView.value = true;
                              });

                              return ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  addRepaintBoundaries: true,
                                  physics: ScrollPhysics(),
                                  itemCount: controller.ratingList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.blue),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Manish sahu",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        RatingBar.builder(
                                          ignoreGestures: true,
                                          itemSize: 17,
                                          initialRating: controller
                                              .ratingList[index].rating!,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 2.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (double value) {},
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, bottom: 20),
                                          padding: EdgeInsets.all(10.0),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade50),
                                          child: Text(
                                              "${controller.ratingList[index].title}"),
                                        ),
                                      ],
                                    );
                                  });
                            }
                          }),
                    ],
                  ),
                ),
                Obx(
                  () => (controller.isView.value)
                      ? Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(RoutesName.viewAllReview,
                                    arguments: controller.itemId);
                              },
                              child: Text(
                                "View All",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                      : Text(""),
                ),

                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
