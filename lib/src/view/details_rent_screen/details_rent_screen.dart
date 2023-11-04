import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:pgroom/src/model/user_rent_model/user_rent_model.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';
import 'package:pgroom/src/view/details_rent_screen/controller/image_page_controller.dart';
import 'package:pgroom/src/view/details_rent_screen/widget/circle_Container_widgets.dart';
 import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../uitels/icon_and_name_widgets/detaails_row_widgets.dart';

class DetailsRentInfoScreen extends StatelessWidget {
  DetailsRentInfoScreen({super.key});

  final imageIndecterController = PageController();

  UserRentModel data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print("build - deataislRnatInfoScreen 🍎 ");

    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "${data.houseName}",
                  style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
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
                    Image(image:  NetworkImage(data.coverImage.toString()),
                        fit: BoxFit.cover),
                    Image(image: AssetImage(room2Image), fit: BoxFit.cover),
                    Image(image: AssetImage(room3Image), fit: BoxFit.cover),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.center,
                child: SmoothPageIndicator(
                    controller: imageIndecterController,
                    count: 3,
                    effect: WormEffect(
                      dotHeight: 6,
                    )),
              ),

              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 15)),
                  Text(
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
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 15)),
                  Text(
                    "Rental Room Type :-",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text("  ${data.roomType}")
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15,top: 10),
                child: Text(
                  "Price :-",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child: Column(
                  children: [

                    if(data.singlePersonPrice != "")
                    DetailsRowWidgets(
                      title: "Single Person :-  ",
                      price: '${data.singlePersonPrice}/- '
                          'month',
                      isIcon: true,
                    ),
                    if(data.doublePersionPrice != "")
                    DetailsRowWidgets(
                      title: "doble Person :-  ",
                      price: '${data.doublePersionPrice}/- '
                          'month',
                      isIcon: true,
                    ),
                    if(data.triplePersionPrice != "")
                    DetailsRowWidgets(
                      title: "triple Person :-  ",
                      price: '${data.triplePersionPrice}/- '
                          'month',
                      isIcon: true,
                    ),
                    if(data.fourPersionPrice != "")
                    DetailsRowWidgets(
                      title: "four Pluse Person :-  ",
                      price: '${data.fourPersionPrice}/- '
                          'month',
                      isIcon: true,
                    ),
                    if(data.faimlyPrice != "")
                    DetailsRowWidgets(
                      title: "Famaily  :-  ",
                      price: '${data.faimlyPrice}/- '
                          'month',
                      isIcon: true,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15,top: 10),
                child: Text(
                  "Services :-",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
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
              SizedBox(
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
              SizedBox(
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
              SizedBox(
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
              Padding(
                padding: const EdgeInsets.only(left: 15,top: 10),
                child: Text(
                  "Bills & charges:-",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
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
                padding: const EdgeInsets.only(left: 15,top: 10),
                child: Row(
                  children: [
                    Text(
                      "Time :-  ",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),

                    (data.restrictedTime != '')
                      ?
                    Text(" Restricted - ${data.restrictedTime}")
                       : Text("Fexible"),

                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15,top: 10),
                child: Text(
                  "Permission:-",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, top: 15),
                child: Column(
                  children: [

                    if(data.girls != "")
                    DetailsRowWidgets(
                      title: "Girl Allow",
                      isIcon: data.girls!,
                    ),

                    if(data.boy != "")
                    DetailsRowWidgets(
                      title: "Boy Allow",
                      isIcon: data.boy!,
                    ),
                    if(data.faimlyMember != "")
                    DetailsRowWidgets(
                      title: "family member Allow",
                      isIcon: data.faimlyMember!,
                    ),

                    if(data.cooking!)
                    DetailsRowWidgets(
                      title: "cooking Allow :-  ${data.cookingType}",
                      isIcon: data.cooking!,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("contect now"),
                ),
              ),

              SizedBox(
                height: 50,
              ),
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


              Padding(
                padding: const EdgeInsets.only(left: 15,top: 50),
                child: Text(
                  "Rating now :-",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Align(
                alignment: Alignment.center,
                child: RatingBar.builder(
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                    fillColor: Colors.yellow.shade50,
                    border: OutlineInputBorder(),
                    hintText: "write your Review..."),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Submit"),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
