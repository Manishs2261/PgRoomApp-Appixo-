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
        title: Text("Details info"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${data.houseName}",
                style: TextStyle(fontSize: 22),
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
                      dotHeight: 12,
                    )),
              ),

              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Text(
                    "Rental Room Type :-",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text("  ${data.roomType}")
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Price :-",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60),
                child: Column(
                  children: [
                    DetailsRowWidgets(
                      title: "Single Person :-  ",
                      price: '${data.singlePersonPrice}/- '
                          'month',
                      isIcon: true,
                    ),
                    DetailsRowWidgets(
                      title: "doble Person :-  ",
                      price: '${data.doublePersionPrice}/- '
                          'month',
                      isIcon: true,
                    ),
                    DetailsRowWidgets(
                      title: "triple Person :-  ",
                      price: '${data.triplePersionPrice}/- '
                          'month',
                      isIcon: true,
                    ),
                    DetailsRowWidgets(
                      title: "four Pluse Person :-  ",
                      price: '${data.fourPersionPrice}/- '
                          'month',
                      isIcon: true,
                    ),
                    DetailsRowWidgets(
                      title: "Famaily  :-  ",
                      price: '${data.faimlyPrice}/- '
                          'month',
                      isIcon: true,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Services :-",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
              SizedBox(
                height: 10,
              ),
              Text(
                "Bills & charges:-",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
              SizedBox(
                height: 10,
              ),
              Text(
                "Permission:-",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, top: 15),
                child: Column(
                  children: [
                    DetailsRowWidgets(
                      title: "Girl",
                      isIcon: data.girls!,
                    ),
                    DetailsRowWidgets(
                      title: "Boy",
                      isIcon: data.boy!,
                    ),
                    DetailsRowWidgets(
                      title: "family member",
                      isIcon: data.faimlyMember!,
                    ),
                    DetailsRowWidgets(
                      title: "cooking",
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
                height: 30,
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
              SizedBox(
                height: 40,
              ),

              Text(
                "Rating now :-",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
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
