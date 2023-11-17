import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'controller/controller.dart';

class EditOtherImageScreen extends StatelessWidget {
   EditOtherImageScreen({super.key});

   final controller = Get.put(EditOtherImageController());

  @override
  Widget build(BuildContext context) {

    print("Build +> Edit Other screen 🍒");
    return Scaffold(
      appBar: AppBar(title: Text("Edit Other Image jfg "),),

       body: SingleChildScrollView(
         child: Column(
           children: [



             Obx(
                   () => controller.isBool.value
                   ? Container(
                 padding: const EdgeInsets.all(10),
                 height: 100,
                 width: 100,
                 decoration: const BoxDecoration(),
                 child: ListView.builder(
                   addAutomaticKeepAlives: false,
                     physics: ScrollPhysics(),
                     scrollDirection: Axis.vertical,
                     itemCount: controller.imageFileList.length,
                     itemBuilder: (context, index) {
                       return Container(
                         margin: const EdgeInsets.all(2),
                         padding: const EdgeInsets.all(1),
                         height: 100,
                         width: 100,
                         decoration: BoxDecoration(
                             border:
                             Border.all(color: Colors.black26)),
                         child: Stack(
                           fit: StackFit.expand,
                           children: [
                             Image.file(
                               controller.imageFileList[index],
                               fit: BoxFit.cover,
                             ),
                             Positioned(
                                 top: 1,
                                 right: 1,
                                 child: InkWell(
                                   onTap: () {
                                     controller.imageFileList
                                         .removeAt(index);

                                     if (controller
                                         .imageFileList.isEmpty) {
                                       controller.isBool.value =
                                       false;
                                     }
                                   },
                                   child: const CircleAvatar(
                                       radius: 11,
                                       backgroundColor: Colors.black26,
                                       child: Icon(
                                         Icons.close,
                                         size: 18,
                                         color: Colors.white,
                                       )),
                                 ))
                           ],
                         ),
                       );
                     }),
               )
                   : Container(
                 height: 100,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   border: Border.all(color: Colors.black26),
                 ),
                 child: const Icon(
                   Icons.image_outlined,
                   size: 50,
                 ),
               ),
             ),

             const SizedBox(
               height: 10,
             ),

             //=============choose button ===========
             SizedBox(
               height: 40,
               width: double.infinity,
               child: ElevatedButton(
                   onPressed: () {
                     controller.pickeImageFromGallery();
                     controller.isBool.value = true;
                   },
                   child: const Text("Chosse image")),
             ),

             const SizedBox(
               height: 60,
             ),


           ],
         ),
       ),
    );
  }
}
