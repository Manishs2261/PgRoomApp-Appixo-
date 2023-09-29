import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/my_check_boxwidget.dart';

import 'charges_and_door_timing_screen.dart';

class ProvideFacilitesScreen extends StatefulWidget {
  const ProvideFacilitesScreen({super.key});

  @override
  State<ProvideFacilitesScreen> createState() => _ProvideFacilitesScreenState();
}

class _ProvideFacilitesScreenState extends State<ProvideFacilitesScreen> {

  bool _checkbox5 = false;
  bool _checkbox6 = false;
  bool _checkbox7 = false;
  bool _checkbox8 = false;
  bool _checkbox9 = false;
  bool _checkbox10 = false;
  bool _checkbox11 = false;
  bool _checkbox12 = false;
  bool _checkbox13 = false;
  bool _checkbox14 = false;
  bool _checkbox15 = false;
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
                checkBool: _checkbox5,
                onChanged: (value) {
                  setState(() {
                    _checkbox5 = value!;
                  });
                }),
            //======for Bed==========
            MYCheckBoxWidget(
                title: "Bed",
                checkBool: _checkbox6,
                onChanged: (value) {
                  setState(() {
                    _checkbox6 = value!;
                  });
                }),

            //======for chairs==========
            MYCheckBoxWidget(
                title: "Chair",
                checkBool: _checkbox7,
                onChanged: (value) {
                  setState(() {
                    _checkbox7 = value!;
                  });
                }),

            //======for Table ==========
            MYCheckBoxWidget(
                title: "Table",
                checkBool: _checkbox8,
                onChanged: (value) {
                  setState(() {
                    _checkbox8 = value!;
                  });
                }),
            //======for Fan==========
            MYCheckBoxWidget(
                title: "Fan",
                checkBool: _checkbox9,
                onChanged: (value) {
                  setState(() {
                    _checkbox9 = value!;
                  });
                }),
            //======for Gadda==========
            MYCheckBoxWidget(
                title: "Gadda",
                checkBool: _checkbox10,
                onChanged: (value) {
                  setState(() {
                    _checkbox10 = value!;
                  });
                }),
            //======for Light==========
            MYCheckBoxWidget(
                title: "Light",
                checkBool: _checkbox11,
                onChanged: (value) {
                  setState(() {
                    _checkbox11 = value!;
                  });
                }),
            //======for Locker==========
            MYCheckBoxWidget(
                title: "Locker",
                checkBool: _checkbox12,
                onChanged: (value) {
                  setState(() {
                    _checkbox12 = value!;
                  });
                }),
            //======for Bedsheet==========
            MYCheckBoxWidget(
                title: "Bed Sheet",
                checkBool: _checkbox13,
                onChanged: (value) {
                  setState(() {
                    _checkbox13 = value!;
                  });
                }),
            //======for washing machine==========
            MYCheckBoxWidget(
                title: "Washing Machine",
                checkBool: _checkbox14,
                onChanged: (value) {
                  setState(() {
                    _checkbox14 = value!;
                  });
                }),
            //======for parking==========
            MYCheckBoxWidget(
                title: "Parking",
                checkBool: _checkbox15,
                onChanged: (value) {
                  setState(() {
                    _checkbox15 = value!;
                  });
                }),

            SizedBox(height: 20,),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChargesAndDoorTime()));
              }, child: Text("next")),
            )

          ],
        ),
      ),
    );
  }
}
