import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/my_check_boxwidget.dart';

class PermissioinScreen extends StatefulWidget {
  const PermissioinScreen({super.key});

  @override
  State<PermissioinScreen> createState() => _PermissioinScreenState();
}

class _PermissioinScreenState extends State<PermissioinScreen> {


  bool _checkbox19 = false;
  bool _checkbox20 = false;
  bool _checkbox21 = false;
  bool _checkbox22 = false;
  bool _checkbox23 = false;
  bool _checkbox24 = false;
  bool _checkbox25 = false;

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
                    checkBool:  _checkbox19,
                    onChanged:  (value) {
                      setState(() {
                        _checkbox19 = value!;
                      });
                    } ),

                // ===========for coocking conditions  ===============
                if( _checkbox19)
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Column(
                      children: [

                        //=============for veg allows============
                        MYCheckBoxWidget(
                            title:"veg only " ,
                            checkBool:  _checkbox20,
                            onChanged:  (value) {
                              setState(() {
                                _checkbox20 = value!;
                              });
                            } ),


                        //=============for Non-veg allows============
                        MYCheckBoxWidget(
                            title:"Non - veg" ,
                            checkBool:  _checkbox21,
                            onChanged:  (value) {
                              setState(() {
                                _checkbox21 = value!;
                              });
                            } ),

                        //=============for Both allows============
                        MYCheckBoxWidget(
                            title:"Both" ,
                            checkBool:  _checkbox22,
                            onChanged:  (value) {
                              setState(() {
                                _checkbox22 = value!;
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
                checkBool:  _checkbox23,
                onChanged:  (value) {
                  setState(() {
                    _checkbox23 = value!;
                  });
                } ),

            //=============for Boys allows============
            MYCheckBoxWidget(
                title:"Boy allow" ,
                checkBool:  _checkbox24,
                onChanged:  (value) {
                  setState(() {
                    _checkbox24 = value!;
                  });
                } ),

            //=============for Family member allows============

            MYCheckBoxWidget(
                title:"Family member  allow" ,
                checkBool:  _checkbox25,
                onChanged:  (value) {
                  setState(() {
                    _checkbox25 = value!;
                  });
                } ),

            SizedBox(height: 30,),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(onPressed: (){},
              child: Text("Save "),),
            )
          ],
        ),
      ),
    );
  }
}
