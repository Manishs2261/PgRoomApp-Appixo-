import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//for radio button
enum FaltTypeEnum{OneBhk,TwoBhk,ThreeBhk}


class MyFlatRadioButtonWidget extends StatelessWidget {
  MyFlatRadioButtonWidget({
    required this.titel,
    required this.value,
    required this.flatTypeEnum,
    required this.onChange,
    super.key});

  String titel;
  FaltTypeEnum value;
  FaltTypeEnum?  flatTypeEnum;
  Function(FaltTypeEnum?)? onChange;
  @override
  Widget build(BuildContext context) {
    return RadioListTile<FaltTypeEnum>(
      contentPadding: EdgeInsets.zero,
      title: Text(titel),
      value: value,
      groupValue: flatTypeEnum,
      onChanged:  onChange,
    );
  }
}
