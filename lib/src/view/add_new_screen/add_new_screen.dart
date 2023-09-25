import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';

class AddNewRoom extends StatefulWidget {
  const AddNewRoom({super.key});

  @override
  State<AddNewRoom> createState() => _AddNewRoomState();
}

class _AddNewRoomState extends State<AddNewRoom> {


  // image picker form Gallary
  File? _selectedIMage;

  Future _pickeImageFromGallery() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image == null) return;
    setState(() {
      _selectedIMage = File(image.path);
    });
  }


  @override
  Widget build(BuildContext context) {
    print("rebuild add new scren");
    print(_selectedIMage);
    return Scaffold(
      appBar: AppBar(
        title: Text("Room Information"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Please complete the following information exactly as it appears in your rental contract",
            style: TextStyle(color: Colors.orange),),
            SizedBox(height: 5,),
            Container(
              alignment: Alignment.center,
              height: 200,
              width: double.infinity,

              // cover image
              child:  Stack(

                children: [

                  // for initial image when your don't choose image
                  _selectedIMage != null
                  ? Image.file(_selectedIMage!,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,)
                      : Image(image: AssetImage(roomImage),
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,),

                  // for add a image button

                  _selectedIMage != null
                  ? Text("")
                      : Positioned(
                    top: 60,
                    left: 80,
                    child: InkWell(
                      onTap: (){
                        _pickeImageFromGallery();
                      },
                      child: Container(
                        height: 60,
                        width: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)
                        ),
                        child:  Text("Add cover Image",style: TextStyle(fontSize: 25,
                            color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),

                 // for delete a image
                  _selectedIMage != null
                  ? Positioned(
                    right: 1,
                      child: InkWell(
                        onTap: (){
                          print("cut image");

                          setState(() {
                            _selectedIMage = null;
                          });
                        },
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.black26,
                          child: Text("X",style: TextStyle(color: Colors.white),),),
                      ))
                      : Text("")
                ],
              ),


            )
          ],
        ),
      ),
    );
  }
}
