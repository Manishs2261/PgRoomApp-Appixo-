import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//for radio button
enum HostelTypeEnum {BoysH, GirlsH}

class MyRadioButtonWidget extends StatelessWidget {
  MyRadioButtonWidget({
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
    return RadioListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(titel),
        value: value,
        groupValue: hostelTypeEnum,
        onChanged:  onChange,
        );
  }
}
