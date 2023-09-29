import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgroom/src/view/rent_form_screen/provide_facilites_screen.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/flat_radio_button_wedget.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/hostel_radio_button_widget.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/my_check_boxwidget.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/my_text_form_field.dart';


class HostelAndRoomTypeScreen extends StatefulWidget {
  const HostelAndRoomTypeScreen({super.key});

  @override
  State<HostelAndRoomTypeScreen> createState() =>
      _HostelAndRoomTypeScreenState();
}

class _HostelAndRoomTypeScreenState extends State<HostelAndRoomTypeScreen> {
  HostelTypeEnum? _hostelTypeEnum;
  FaltTypeEnum? _faltTypeEnum;

bool isBool = false;
  bool _checkboxSingle1 = false;
  bool _checkboxDoble2 = false;
  bool _checkboxTriple3 = false;
  bool _checkboxFour4 = false;
  bool _checkboxFaimalyRoom = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hostel and room type"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===========Hostel type================={

              Text(
                "Hostel Type :- ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              // ======boys hostel =====
              MyHostelRadioButtonWidget(
                  titel: "Boys Hostel",
                  value: HostelTypeEnum.BoysH,
                  hostelTypeEnum: _hostelTypeEnum,
                  onChange: (value) {
                    setState(() {
                      _hostelTypeEnum = value;
                      isBool = false;
                    });
                  }),

              // ======Girls hostel =====
              MyHostelRadioButtonWidget(
                  titel: "Girls Hostel",
                  value: HostelTypeEnum.GirlsH,
                  hostelTypeEnum: _hostelTypeEnum,
                  onChange: (value) {
                    setState(() {
                      _hostelTypeEnum = value;
                      isBool = false;
                    });
                  }),

              // ======Flat Room =====
              MyHostelRadioButtonWidget(
                  titel: "Flat",
                  value: HostelTypeEnum.Faimaly,
                  hostelTypeEnum: _hostelTypeEnum,
                  onChange: (value) {
                    setState(() {
                      _hostelTypeEnum = value;
                      isBool = true;
                    });
                  }),

              if(isBool)
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Column(
                  children: [
                    // ==========check a flat  conditiion==========

                      MyFlatRadioButtonWidget(
                          titel: "1BHK",
                          value: FaltTypeEnum.OneBhk,
                          flatTypeEnum: _faltTypeEnum,
                          onChange: (value) {
                            setState(() {
                              _faltTypeEnum = value;
                            });
                          }),

                      MyFlatRadioButtonWidget(
                          titel: "2BHK",
                          value: FaltTypeEnum.TwoBhk,
                          flatTypeEnum: _faltTypeEnum,
                          onChange: (value) {
                            setState(() {
                              _faltTypeEnum = value;
                            });
                          }),

                      MyFlatRadioButtonWidget(
                          titel: "3BHK",
                          value: FaltTypeEnum.ThreeBhk,
                          flatTypeEnum: _faltTypeEnum,
                          onChange: (value) {
                            setState(() {
                              _faltTypeEnum = value;
                            });
                          }),

                  ],
                ),
              ),

              //==============================}

              SizedBox(
                height: 20,
              ),
              Text(
                "Room Type & Monthly Price :- ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              //========for Single Person ============
              Row(
                children: [
                  MYCheckBoxWidget(
                      title: "Single Person",
                      checkBool: _checkboxSingle1,
                      onChanged: (value) {
                        setState(() {
                          _checkboxSingle1 = value!;
                        });
                      }),
                  if (_checkboxSingle1)
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MyTextFormWedgit(
                        hintText: "Price",
                        lableText: "Price",
                        isCollapsed: true,
                        isDense: true,
                        borderRadius: BorderRadius.circular(11),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      ),
                    ))
                ],
              ),

              //====== double person===========
              Row(
                children: [
                  MYCheckBoxWidget(
                      title: "Doble Person",
                      checkBool: _checkboxDoble2,
                      onChanged: (value) {
                        setState(() {
                          _checkboxDoble2 = value!;
                        });
                      }),
                  if (_checkboxDoble2)
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MyTextFormWedgit(
                        hintText: "Price",
                        lableText: "Price",
                        isCollapsed: true,
                        isDense: true,
                        borderRadius: BorderRadius.circular(11),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      ),
                    ))
                ],
              ),
              //==========for Triple person ==========
              Row(
                children: [
                  MYCheckBoxWidget(
                      title: "Triple Person",
                      checkBool: _checkboxTriple3,
                      onChanged: (value) {
                        setState(() {
                          _checkboxTriple3 = value!;
                        });
                      }),
                  if (_checkboxTriple3)
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MyTextFormWedgit(
                        hintText: "Price",
                        lableText: "Price",
                        isCollapsed: true,
                        isDense: true,
                        borderRadius: BorderRadius.circular(11),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      ),
                    ))
                ],
              ),
              //======four person room type =========
              Row(
                children: [
                  MYCheckBoxWidget(
                      title: "Four Person +",
                      checkBool: _checkboxFour4,
                      onChanged: (value) {
                        setState(() {
                          _checkboxFour4 = value!;
                        });
                      }),
                  if (_checkboxFour4)
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MyTextFormWedgit(
                        hintText: "Price",
                        lableText: "Price",
                        isCollapsed: true,
                        isDense: true,
                        borderRadius: BorderRadius.circular(11),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      ),
                    ))
                ],
              ),

              //==========faimaly Room ===========
              Row(
                children: [
                  MYCheckBoxWidget(
                      title: "Faimaly Room / Flat",
                      checkBool: _checkboxFaimalyRoom,
                      onChanged: (value) {
                        setState(() {
                          _checkboxFaimalyRoom = value!;
                        });
                      }),
                  if (_checkboxFaimalyRoom)
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MyTextFormWedgit(
                            hintText: "Price",
                            lableText: "Price",
                            isCollapsed: true,
                            isDense: true,
                            borderRadius: BorderRadius.circular(11),
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          ),
                        ))
                ],
              ),

              SizedBox(height: 20,),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProvideFacilitesScreen()));
                    },
                    child: Text("Save & Next")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
