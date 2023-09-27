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

     bool? _checkBox = false;
  final _globlekey = GlobalKey<FormState>();
  // for bool value false not show a image
  bool isBool = false;
 // for storing a more image in list
  List<dynamic> imageFileList = [];

  // image picker form Gallary
  File? _selectedCoverImage;
  File? _selectImage;

  Future _pickeImageFromGallery() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image == null) return;
    setState(() {
       //_selectedCoverImage = File(image.path);
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
                height: 5,
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
                height: 10,
              ),

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
                            decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
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
                                      onTap: (){
                                        setState(() {

                                           imageFileList.removeAt(index);
                                          print("remove = $index");
                                          print(isBool);
                                        });
                                      },
                                      child: CircleAvatar(

                                          radius: 11,
                                          backgroundColor: Colors.black26,
                                          child: Icon(Icons.close,size: 18,color: Colors.white,)

                                      ),
                                    )
                                )
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
                child: Icon(Icons.image_outlined,size: 50,),
                    ),

              SizedBox(height: 10,),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      _pickeImageFromGallery();
                      isBool = true;

                    },
                    child: Text("Add image")),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Form(
                  key: _globlekey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormWedgit(
                          hintText: "Enter Home / House Name",
                          lableText: 'House Name',
                          icon: Icon(Icons.home),),
                        SizedBox(height: 10,),
                        TextFormWedgit(
                          hintText: "Enter Rent Price",
                          lableText: 'Rent Price',
                          icon: Icon(Icons.currency_rupee),),
                        SizedBox(height: 10,),
                        TextFormWedgit(
                          hintText: "House Address",
                          lableText: 'House addsress',
                          icon: Icon(Icons.location_city_outlined),),
                        SizedBox(height: 10,),
                        TextFormWedgit(
                          hintText: "City Name",
                          lableText: 'City Name',
                          icon: Icon(Icons.location_city_rounded),),
                        SizedBox(height: 10,),
                        TextFormWedgit(
                          hintText: "Land Mark address",
                          lableText: 'Land Makr address',
                          icon: Icon(Icons.home),),
                        SizedBox(height: 20,),
                        
                        Text("Room Type :- ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                       CheckboxListTile(
                         title: Text("Single person"),
                           value: _checkBox,
                           onChanged: (value){
                         setState(() {
                           _checkBox = value;

                           if(_checkBox == true)
                             {
                                setState(() {
                                  Text("heloo");
                                });
                             }

                         });
                           },
                         controlAffinity: ListTileControlAffinity.leading,
                       )

                      ],
                    )),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class TextFormWedgit extends StatelessWidget {
  const TextFormWedgit({
    super.key, required this.hintText, required this.lableText, required this.icon,
  });

  final String hintText,lableText;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
        hintText: hintText,
        labelText: lableText,
        contentPadding: EdgeInsets.only(top: 5,left: 10),
        prefixIcon: icon
      ),
      validator: (value){
        return null;
        },

    );
  }
}
