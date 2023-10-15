import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/my_check_boxwidget.dart';

class PermissioinScreen extends StatefulWidget {
  const PermissioinScreen({super.key});

  @override
  State<PermissioinScreen> createState() => _PermissioinScreenState();
}

class _PermissioinScreenState extends State<PermissioinScreen> {


  bool cookingAllow = false;
  bool veg = false;

  bool both = false;
  bool girl = false;
  bool boy = false;
  bool faimlyMamber = false;
  String cookingType = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Permmission"),),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Permission :- ",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),

            //=======PErmission ===============
            Column(
              children: [
                //=============for cooking ============
                MYCheckBoxWidget(
                    title:"Cooking allow" ,
                    checkBool:  cookingAllow,
                    onChanged:  (value) {
                      setState(() {
                        cookingAllow = value!;

                        if(cookingAllow == false){
                          veg = false;
                          both = false;
                          cookingType = "";
                        }

                      });
                    } ),

                // ===========for coocking conditions  ===============
                if( cookingAllow)
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Column(
                      children: [

                        //=============for veg allows============
                        MYCheckBoxWidget(
                            title:"veg only " ,
                            checkBool:  veg,
                            onChanged:  (value) {
                              setState(() {
                                veg = value!;
                                both = false;
                                cookingType = "veg Only";
                              });
                            } ),


                        //=============for Non-veg allows============


                        //=============for Both allows============
                        MYCheckBoxWidget(
                            title:"veg and non-veg both allow" ,
                            checkBool:  both,
                            onChanged:  (value) {
                              setState(() {
                                both = value!;
                                veg = false;
                                cookingType = "veg and non-veg both allow";
                              });
                            } ),

                      ],
                    ),
                  )

              ],
            ),

            //=============for Girls allows============
            MYCheckBoxWidget(
                title:"Girl allow" ,
                checkBool:  girl,
                onChanged:  (value) {
                  setState(() {
                    girl = value!;
                  });
                } ),

            //=============for Boys allows============
            MYCheckBoxWidget(
                title:"Boy allow" ,
                checkBool:  boy,
                onChanged:  (value) {
                  setState(() {
                    boy = value!;
                  });
                } ),

            //=============for Family member allows============

            MYCheckBoxWidget(
                title:"Family member  allow" ,
                checkBool:  faimlyMamber,
                onChanged:  (value) {
                  setState(() {
                    faimlyMamber = value!;
                  });
                } ),

            SizedBox(height: 30,),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(onPressed: (){

                ApisClass.newPermission(
                    cookingAllow,
                    cookingType,
                    girl,
                    boy,
                    faimlyMamber).then((value) {

                      Get.snackbar("add","sussefluy");
                }).onError((error, stackTrace) {

                  Get.snackbar("error", "error");
                  print("errror + $error");
                });



              },
              child: Text("Save "),),
            )
          ],
        ),
      ),
    );
  }
}
