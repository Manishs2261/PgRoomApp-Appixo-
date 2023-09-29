import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';
import 'package:pgroom/src/view/rent_form_screen/rent_details_screen.dart';

class AddImageScreen extends StatefulWidget {
  const AddImageScreen({super.key});

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  // for bool value false not show a image
  bool isBool = false;

  // for storing a more image in list
  List<dynamic> imageFileList = [];

  // image picker form Gallary
  File? _selectedCoverImage;

  Future _pickeImageFromGallery() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image == null) return;
    setState(() {
      imageFileList.add(File(image.path));
    });
  }

  Future _pickeCoverImageFromGallery() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image == null) return;
    setState(() {
      _selectedCoverImage = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild add new scren");

    return Scaffold(
      appBar: AppBar(
        title: Text("Room Information"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Please complete the following information exactly as it appears in your rental contract",
                style: TextStyle(color: Colors.orange),
              ),
              SizedBox(
                height: 20,
              ),

              Text(
                "This Image show in your front page",
                style: TextStyle(color: Colors.green),
              ),
              SizedBox(
                height: 15,
              ),

              //========stack container ============
              Container(
                alignment: Alignment.center,
                height: 200,
                width: double.infinity,

                //======== cover image=================
                child: Stack(
                  children: [
                    // =====for initial image when your don't choose image============
                    _selectedCoverImage != null
                        ? Image.file(
                            _selectedCoverImage!,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image(
                            image: AssetImage(roomImage),
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),

                    // ========for add a image button=========

                    _selectedCoverImage != null
                        ? Text("")
                        : Positioned(
                            top: 60,
                            left: 80,
                            child: InkWell(
                              onTap: () {
                                _pickeCoverImageFromGallery();
                              },
                              child: Container(
                                height: 60,
                                width: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                                child: Text(
                                  "Add cover Image",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),

                    //==========for delete a image===========
                    _selectedCoverImage != null
                        ? Positioned(
                            right: 1,
                            child: InkWell(
                              onTap: () {
                                print("cut image");

                                setState(() {
                                  _selectedCoverImage = null;
                                });
                              },
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.black26,
                                child: Text(
                                  "X",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ))
                        : Text("")
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Text(
                " Othe images ",
                style: TextStyle(color: Colors.green),
              ),
              SizedBox(
                height: 10,
              ),

              //===========other image container============

              isBool
                  ? Container(
                      padding: EdgeInsets.all(10),
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageFileList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(2),
                              padding: EdgeInsets.all(1),
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black26)),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.file(
                                    imageFileList[index],
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                      top: 1,
                                      right: 1,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            imageFileList.removeAt(index);
                                          });
                                        },
                                        child: CircleAvatar(
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
                      child: Icon(
                        Icons.image_outlined,
                        size: 50,
                      ),
                    ),

              SizedBox(
                height: 10,
              ),

              //=============choose button ===========
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      _pickeImageFromGallery();
                      isBool = true;
                    },
                    child: Text("Chosse image")),
              ),

              SizedBox(
                height: 60,
              ),

              //=========save & next button ===============
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {


                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RentDetailsScsreen()));
                    },
                    child: Text(
                      "Save & Next",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
              ),

              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
