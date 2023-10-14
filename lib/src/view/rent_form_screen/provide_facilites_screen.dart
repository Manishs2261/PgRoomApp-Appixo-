import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/my_check_boxwidget.dart';

import 'charges_and_door_timing_screen.dart';

class ProvideFacilitesScreen extends StatefulWidget {
  const ProvideFacilitesScreen({super.key});

  @override
  State<ProvideFacilitesScreen> createState() => _ProvideFacilitesScreenState();
}

class _ProvideFacilitesScreenState extends State<ProvideFacilitesScreen> {

  bool wifi = false;
  bool bed = false;
  bool chari = false;
  bool table = false;
  bool fan = false;
  bool gadda = false;
  bool light = false;
  bool locker = false;
  bool bedSheet = false;
  bool washingMachin = false;
  bool parking = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("provide facilites"),),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Provide a Facilities :- ",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),

            //======for Wi-fi==========
            MYCheckBoxWidget(
                title: "Wi-Fi",
                checkBool: wifi,
                onChanged: (value) {
                  setState(() {
                    wifi = value!;
                  });
                }),
            //======for Bed==========
            MYCheckBoxWidget(
                title: "Bed",
                checkBool: bed,
                onChanged: (value) {
                  setState(() {
                    bed = value!;
                  });
                }),

            //======for chairs==========
            MYCheckBoxWidget(
                title: "Chair",
                checkBool: chari,
                onChanged: (value) {
                  setState(() {
                    chari = value!;
                  });
                }),

            //======for Table ==========
            MYCheckBoxWidget(
                title: "Table",
                checkBool: table,
                onChanged: (value) {
                  setState(() {
                    table = value!;
                  });
                }),
            //======for Fan==========
            MYCheckBoxWidget(
                title: "Fan",
                checkBool: fan,
                onChanged: (value) {
                  setState(() {
                    fan = value!;
                  });
                }),
            //======for Gadda==========
            MYCheckBoxWidget(
                title: "Gadda",
                checkBool: gadda,
                onChanged: (value) {
                  setState(() {
                    gadda = value!;
                  });
                }),
            //======for Light==========
            MYCheckBoxWidget(
                title: "Light",
                checkBool: light,
                onChanged: (value) {
                  setState(() {
                    light = value!;
                  });
                }),
            //======for Locker==========
            MYCheckBoxWidget(
                title: "Locker",
                checkBool: locker,
                onChanged: (value) {
                  setState(() {
                    locker = value!;
                  });
                }),
            //======for Bedsheet==========
            MYCheckBoxWidget(
                title: "Bed Sheet",
                checkBool: bedSheet,
                onChanged: (value) {
                  setState(() {
                    bedSheet = value!;
                  });
                }),
            //======for washing machine==========
            MYCheckBoxWidget(
                title: "Washing Machine",
                checkBool: washingMachin,
                onChanged: (value) {
                  setState(() {
                    washingMachin = value!;
                  });
                }),
            //======for parking==========
            MYCheckBoxWidget(
                title: "Parking",
                checkBool: parking,
                onChanged: (value) {
                  setState(() {
                    parking = value!;
                  });
                }),

            SizedBox(height: 20,),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(onPressed: (){

                // ApisClass.newProvidFacilites(
                //     wifi,
                //     bed,
                //     chari,
                //     table,
                //     fan,
                //     gadda,
                //     light,
                //     locker,
                //     bedSheet,
                //     washingMachin,
                //     parking).then((value) {
                //
                //       Get.snackbar("add","sussefully");
                // }).onError((error, stackTrace) {
                //   print("error ${error}");
                //   Get.snackbar("error", "error");
                // });



               Navigator.push(context, MaterialPageRoute(builder: (context)
               =>ChargesAndDoorTime()));
              }, child: Text("next")),
            )

          ],
        ),
      ),
    );
  }
}
