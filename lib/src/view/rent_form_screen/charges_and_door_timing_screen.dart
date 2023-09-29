import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgroom/src/view/rent_form_screen/permission_screen.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/my_check_boxwidget.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/my_text_form_field.dart';

class ChargesAndDoorTime extends StatefulWidget {
  const ChargesAndDoorTime({super.key});

  @override
  State<ChargesAndDoorTime> createState() => _ChargesAndDoorTimeState();
}

class _ChargesAndDoorTimeState extends State<ChargesAndDoorTime> {

  bool _checkbox16 = false;
  bool _checkbox17 = false;
  bool _checkbox18 = false;
  bool _checkbox26 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("charge "),),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "Additional charges :- ",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "In this chargs include your roon rent or not",
                style: TextStyle(color: Colors.orange),
              ),
              SizedBox(
                height: 30,
              ),

              //======for Electricity bill =============
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MYCheckBoxWidget(
                      materialTapTargetSize:
                      MaterialTapTargetSize.shrinkWrap,
                      title: "Electricity Bill",
                      checkBool: _checkbox16,
                      onChanged: (value) {
                        setState(() {
                          _checkbox16 = value!;
                        });
                      }),

                  // ==========for checking Electricity bill condition=======
                  _checkbox16
                      ? Text(
                    "Electricity bill are include in your room rent",
                    style: TextStyle(color: Colors.green),
                  )
                      : Text(
                    "Electricity bill are not include in your room rent",
                    style: TextStyle(color: Colors.orange),
                  )
                ],
              ),

              //======for water bill =============
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      MYCheckBoxWidget(
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          title: "Water Bill",
                          checkBool: _checkbox17,
                          onChanged: (value) {
                            setState(() {
                              _checkbox17 = value!;
                            });
                          }),
                    ],
                  ),
                  //=========for checking water bill condition============
                  _checkbox17
                      ? Text(
                    "Water bill are  include in your room rent",
                    style: TextStyle(color: Colors.green),
                  )
                      : Text(
                    "Water bill are not include in your room rent",
                    style: TextStyle(color: Colors.orange),
                  )
                ],
              ),

              SizedBox(
                height: 20,
              ),
              Text(
                "Door Closing Time :- ",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [


                  //=============for Restricted Time ============
                  MYCheckBoxWidget(
                      title:"Restricted Time" ,
                      checkBool:  _checkbox26,
                      onChanged:  (value) {
                        setState(() {
                          _checkbox26 = value!;
                        });
                      } ),
                  // =======for checking a condition ===========
                  if(_checkbox26)
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child:  MyTextFormWedgit(
                            hintText: "Enter at time",
                            lableText: "Time",
                            isDense: true,
                            isCollapsed: true,
                            borderRadius: BorderRadius.zero,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                          ),

                        ))

                ],
              ),
              //=============for fexible time ============
              MYCheckBoxWidget(
                  title:"Fexible time" ,
                  checkBool:  _checkbox18,
                  onChanged:  (value) {
                    setState(() {
                      _checkbox18 = value!;
                    });
                  } ),

              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PermissioinScreen()));
                }, child:Text("next")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
