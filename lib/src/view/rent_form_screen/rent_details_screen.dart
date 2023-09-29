import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgroom/src/view/rent_form_screen/hostel_and_room_type_screen.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/my_text_form_field.dart';

class RentDetailsScsreen extends StatefulWidget {
  const RentDetailsScsreen({super.key});

  @override
  State<RentDetailsScsreen> createState() => _RentDetailsScsreenState();
}

class _RentDetailsScsreenState extends State<RentDetailsScsreen> {

  final _globlekey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rent Details"),),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 40),
        child: Form(
          key: _globlekey,

          child: Column(
            children: [

              // =================Home Name================
              MyTextFormWedgit(
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
                hintText: "Land Mark address",
                lableText: 'Land Makr address',
                icon: Icon(Icons.home),
                borderRadius: BorderRadius.circular(11),
                contentPadding: EdgeInsets.only(top: 5, left: 10),
              ),

              SizedBox(height: 50,),

              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){},
                  child: Text("Save"),
                ),
              ),
              SizedBox(height: 50,),

              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> HostelAndRoomTypeScreen()));
                  },
                  child: Text("Next"),
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}
