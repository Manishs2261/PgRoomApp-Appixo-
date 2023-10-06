import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';
import 'package:pgroom/src/view/details_rent_screen/controller/image_page_controller.dart';
import 'package:pgroom/src/view/details_rent_screen/widget/circle_Container_widgets.dart';
import 'package:pgroom/src/view/details_rent_screen/widget/detaails_row_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailsRentInfoScreen extends StatefulWidget {
  const DetailsRentInfoScreen({super.key});

  @override
  State<DetailsRentInfoScreen> createState() => _DetailsRentInfoScreenState();
}

class _DetailsRentInfoScreenState extends State<DetailsRentInfoScreen> {

  final imageIndecterController = PageController();

  @override
  Widget build(BuildContext context) {
    print("build - deataisl ");
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
                "House Name ",
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
                    Image(image: AssetImage(roomImage),fit: BoxFit.cover),
                    Image(image: AssetImage(room2Image),fit: BoxFit.cover),
                    Image(image: AssetImage(room3Image),fit: BoxFit.cover),

                  ],
                ),
              ),
              SizedBox(height: 5,),
              Align(
                alignment: Alignment.center,
                child: SmoothPageIndicator(
                    controller: imageIndecterController,
                    count: 3,
                  effect: WormEffect(
                    dotHeight: 12,
                  )

                ),
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
                      " gour colony yadunandan nager tifra bilaspur , chhatttisgarh, near papu popular palar salun",
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
                  Text("  Boys hostal")
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
                      price: '2000/- '
                          'month',
                      icon: Icons.done,
                    ),
                    DetailsRowWidgets(
                      title: "doble Person :-  ",
                      price: '1600/- '
                          'month',
                      icon: Icons.done,
                    ),
                    DetailsRowWidgets(
                      title: "triple Person :-  ",
                      price: '1200/- '
                          'month',
                      icon: Icons.done,
                    ),
                    DetailsRowWidgets(
                      title: "four + :-  ",
                      price: '1000/- '
                          'month',
                      icon: Icons.done,
                    ),
                    DetailsRowWidgets(
                      title: "Famaily  :-  ",
                      price: '5000/- '
                          'month',
                      icon: Icons.done,
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
                  DetailsRowWidgets(title: "Wi-Fi", icon: Icons.close),
                  DetailsRowWidgets(title: "Fan", icon: Icons.done),
                  DetailsRowWidgets(title: "Light", icon: Icons.done),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DetailsRowWidgets(title: "table", icon: Icons.close),
                  DetailsRowWidgets(title: "chair", icon: Icons.done),
                  DetailsRowWidgets(title: "locker", icon: Icons.close),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DetailsRowWidgets(title: "Bed", icon: Icons.close),
                  DetailsRowWidgets(title: "gadda", icon: Icons.done),
                  DetailsRowWidgets(title: "bed sheet", icon: Icons.done),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DetailsRowWidgets(title: "parking", icon: Icons.done),
                  DetailsRowWidgets(
                      title: "barhroom \n attech", icon: Icons.done),
                  DetailsRowWidgets(
                      title: "barhroom \n shareable", icon: Icons.done),
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
                      title: "Electricity bill", icon: Icons.done),
                  DetailsRowWidgets(title: "water bill", icon: Icons.done),
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
                    DetailsRowWidgets(title: "Girl", icon: Icons.done),
                    DetailsRowWidgets(title: "Boy", icon: Icons.done),
                    DetailsRowWidgets(title: "family member", icon: Icons.done),
                    DetailsRowWidgets(title: "cooking", icon: Icons.done),
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
                      onPressed: () {}, child: Text("contect now"),),
              ),

              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //=========share =========
                 CircleContainerWidgets(title: 'Share', iconData: Icons.share_outlined,
                   ontap: () {  },),

                  // ==========map view ===========
                  CircleContainerWidgets(title: "Map view",
                      iconData: Icons.location_on_outlined,
                      ontap: (){})
                ],
              ),
              SizedBox(
                height: 40,
              ),

          Text("Rating now :-",style: TextStyle(fontWeight: FontWeight.w500,
          fontSize: 18),),
          SizedBox(height: 10,),

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
             SizedBox(height: 10,),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "write your Review..."
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){},
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


