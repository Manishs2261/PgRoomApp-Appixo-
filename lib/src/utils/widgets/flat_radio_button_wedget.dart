import 'package:flutter/material.dart';

//for radio button
enum FlatTypeEnum{oneBhk,twoBhk,threeBhk}


class MyFlatRadioButtonWidget extends StatelessWidget {
 const MyFlatRadioButtonWidget({
    required this.title,
    required this.value,
    required this.flatTypeEnum,
    required this.onChange,
    super.key});

  final String title;
  final FlatTypeEnum value;
  final FlatTypeEnum?  flatTypeEnum;
  final Function(FlatTypeEnum?)? onChange;
  @override
  Widget build(BuildContext context) {
    return RadioListTile<FlatTypeEnum>(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      groupValue: flatTypeEnum,
      onChanged:  onChange,
    );
  }
}
