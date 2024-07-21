
import 'package:flutter/material.dart';

//for radio button
enum HostelTypeEnum {boysH, girlsH,family,}


class MyHostelRadioButtonWidget extends StatelessWidget {
 const MyHostelRadioButtonWidget({
    required this.title,
    required this.value,
    required this.hostelTypeEnum,
    required this.onChange,
    super.key});

 final String title;
 final HostelTypeEnum value;
 final HostelTypeEnum? hostelTypeEnum;
 final Function(HostelTypeEnum?)? onChange;
  @override
  Widget build(BuildContext context) {
    return RadioListTile<HostelTypeEnum>(
        contentPadding: EdgeInsets.zero,
        title: Text(title),
        value: value,
        groupValue: hostelTypeEnum,
        onChanged:  onChange,
        );
  }
}
