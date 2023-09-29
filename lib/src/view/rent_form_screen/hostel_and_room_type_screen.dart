import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgroom/src/view/rent_form_screen/provide_facilites_screen.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/my_check_boxwidget.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/my_text_form_field.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/radio_button_widget.dart';

class HostelAndRoomTypeScreen extends StatefulWidget {
  const HostelAndRoomTypeScreen({super.key});

  @override
  State<HostelAndRoomTypeScreen> createState() => _HostelAndRoomTypeScreenState();
}

class _HostelAndRoomTypeScreenState extends State<HostelAndRoomTypeScreen> {

  HostelTypeEnum? _hostelTypeEnum;

  bool _checkbox1 = false;
  bool _checkbox2 = false;
  bool _checkbox3 = false;
  bool _checkbox4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hostel and room type"),),
      body: Column(
        children: [
          // ===========Hostel type================={
          SizedBox(
            height: 20,
          ),
          Text(
            "Hostel Type :- ",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold),
          ),

          // ======boys hostel =====
          MyRadioButtonWidget(
              titel: "Boys Hostel",
              value: HostelTypeEnum.BoysH,
              hostelTypeEnum: _hostelTypeEnum,
              onChange: (value) {
                setState(() {
                  _hostelTypeEnum = value;
                });
              }),

          // ======Girls hostel =====
          MyRadioButtonWidget(
              titel: "Girls Hostel",
              value: HostelTypeEnum.GirlsH,
              hostelTypeEnum: _hostelTypeEnum,
              onChange: (value) {
                setState(() {
                  _hostelTypeEnum = value;
                });
              }),

          //==============================}

          SizedBox(
            height: 20,
          ),
          Text(
            "Room Type & Price :- ",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold),
          ),

          //========for Single Person ============
          Row(
            children: [
              MYCheckBoxWidget(
                  title: "Single Person",
                  checkBool: _checkbox1,
                  onChanged: (value) {
                    setState(() {
                      _checkbox1 = value!;
                    });
                  }),
              if(_checkbox1)
                Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:  MyTextFormWedgit(
                        hintText: "Price",
                        lableText: "Price",
                        isCollapsed: true,
                        isDense: true,
                        borderRadius: BorderRadius.circular(11),
                        contentPadding:EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                      ),
                    )
                )

            ],
          ),

          //====== double person===========
          Row(
            children: [
              MYCheckBoxWidget(
                  title: "Doble Person",
                  checkBool: _checkbox2,
                  onChanged: (value) {
                    setState(() {
                      _checkbox2 = value!;
                    });
                  }),
              if(  _checkbox2)
                Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MyTextFormWedgit(
                        hintText: "Price",
                        lableText: "Price",
                        isCollapsed: true,
                        isDense: true,
                        borderRadius: BorderRadius.circular(11),
                        contentPadding:EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                      ),
                    ))

            ],
          ),
          //==========for Triple person ==========
          Row(
            children: [
              MYCheckBoxWidget(
                  title: "Triple Person",
                  checkBool: _checkbox3,
                  onChanged: (value) {
                    setState(() {
                      _checkbox3 = value!;
                    });
                  }),
              if(  _checkbox3)
                Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MyTextFormWedgit(
                        hintText: "Price",
                        lableText: "Price",
                        isCollapsed: true,
                        isDense: true,
                        borderRadius: BorderRadius.circular(11),
                        contentPadding:EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                      ),
                    ))

            ],
          ),
          //======four person room type =========
          Row(
            children: [
              MYCheckBoxWidget(
                  title: "Four Person +",
                  checkBool: _checkbox4,
                  onChanged: (value) {
                    setState(() {
                      _checkbox4 = value!;
                    });
                  }),
              if( _checkbox4)
                Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:  MyTextFormWedgit(
                        hintText: "Price",
                        lableText: "Price",
                        isCollapsed: true,
                        isDense: true,
                        borderRadius: BorderRadius.circular(11),
                        contentPadding:EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                      ),
                    ))

            ],
          ),

          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProvideFacilitesScreen()));
          },
              child: Text("next"))
        ],
      ),
    );
  }
}
