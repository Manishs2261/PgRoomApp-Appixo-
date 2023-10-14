import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/view/rent_form_screen/hostel_and_room_type_screen.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/my_text_form_field.dart';

class RentDetailsScsreen extends StatefulWidget {
  const RentDetailsScsreen({super.key});

  @override
  State<RentDetailsScsreen> createState() => _RentDetailsScsreenState();
}

class _RentDetailsScsreenState extends State<RentDetailsScsreen> {
  final _globlekey = GlobalKey<FormState>();

  final houseNameController = TextEditingController();
  final houseAddressController = TextEditingController();
  final cityNameController = TextEditingController();
  final landdMarkController = TextEditingController();
  final contactNumberController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rent Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
          child: Form(
            key: _globlekey,
            child: Column(

              children: [
                // =================Home Name================
                MyTextFormWedgit(

                  controller: houseNameController,
                  hintText: "Enter Home / House Name",
                  lableText: 'House Name',
                  icon: Icon(Icons.home),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: EdgeInsets.only(top: 5, left: 10),
                ),
                SizedBox(
                  height: 10,
                ),

                //==========House Address================
                MyTextFormWedgit(
                  controller: houseAddressController,
                  hintText: "House Address",
                  lableText: 'House addsress',
                  icon: Icon(Icons.location_city_outlined),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: EdgeInsets.only(top: 5, left: 10),
                ),
                SizedBox(
                  height: 10,
                ),
                //===========City Name================
                MyTextFormWedgit(
                  controller: cityNameController,
                  hintText: "City Name",
                  lableText: 'City Name',
                  icon: Icon(Icons.location_city_rounded),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: EdgeInsets.only(top: 5, left: 10),
                ),
                SizedBox(
                  height: 10,
                ),
                //============Land Mark address=================
                MyTextFormWedgit(
                  controller: landdMarkController,
                  hintText: "Land Mark address",
                  lableText: 'Land Makr address',
                  icon: Icon(Icons.home),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: EdgeInsets.only(top: 5, left: 10),
                ),
                SizedBox(
                  height: 10,
                ),

                //==========Contuct Number================
                MyTextFormWedgit(
                  controller: contactNumberController,
                  hintText: "Contact Number",
                  lableText: 'Contuct Number',
                  icon: Icon(Icons.phone),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: EdgeInsets.only(top: 5, left: 10),
                ),


                SizedBox(
                  height: 80,
                ),




                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {

                      print(houseAddressController.text);
                      print(houseNameController.text);
                      print(cityNameController.text);
                      print(landdMarkController.text);
                      print(contactNumberController.text);
                       //
                       // ApisClass.newRentDetailsCollection(
                       //     houseNameController.text,
                       //     houseAddressController.text,
                       //     cityNameController.text,
                       //     landdMarkController.text,
                       //     contactNumberController.text).then((value) {
                       //
                       //       Get.snackbar("add", "sussfulyy");
                       // }).onError((error, stackTrace) {
                       //
                       //   Get.snackbar("errror", "errrr");
                       //   print("Error + : $error");
                       // });



                      Navigator.push(context, MaterialPageRoute(builder:
                     (context)=> HostelAndRoomTypeScreen()));

                    },
                    child: Text("Save & Next"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
