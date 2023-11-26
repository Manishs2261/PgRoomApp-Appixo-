import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//for radio button
enum HostelTypeEnum {BoysH, GirlsH,Faimaly,}


class MyHostelRadioButtonWidget extends StatelessWidget {
  MyHostelRadioButtonWidget({
    required this.titel,
    required this.value,
    required this.hostelTypeEnum,
    required this.onChange,
    super.key});

  String titel;
  HostelTypeEnum value;
  HostelTypeEnum? hostelTypeEnum;
  Function(HostelTypeEnum?)? onChange;
  @override
  Widget build(BuildContext context) {
    return RadioListTile<HostelTypeEnum>(
        contentPadding: EdgeInsets.zero,
        title: Text(titel),
        value: value,
        groupValue: hostelTypeEnum,
        onChanged:  onChange,
        );
  }
}
