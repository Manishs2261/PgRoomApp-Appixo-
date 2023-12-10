import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';

import '../add_tiffin_screen/add_tiffin_screen.dart';

class AddYourTiffineServicesScreen extends StatelessWidget {
  const AddYourTiffineServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [

          SizedBox(height: 20,),
          ComReuseElevButton(onPressed: (){
            Get.to(()=> AddTiffineScreen());
          }, title: "Add your Tiffine Services"),

        ],
      ),
    );
  }
}
