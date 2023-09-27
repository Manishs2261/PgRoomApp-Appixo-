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
  bool _checkbox1 = false;
  bool _checkbox2 = false;
  bool _checkbox3 = false;
  bool _checkbox4 = false;
  bool _checkbox5 = false;
  bool _checkbox6 = false;
  bool _checkbox7 = false;
  bool _checkbox8 = false;
  bool _checkbox9 = false;
  bool _checkbox10 = false;
  bool _checkbox11 = false;
  bool _checkbox12 = false;
  bool _checkbox13 = false;
  bool _checkbox14 = false;
  bool _checkbox15 = false;
  bool _checkbox16 = false;
  bool _checkbox17 = false;
  bool _checkbox18 = false;
  bool _checkbox19 = false;
  bool _checkbox20 = false;
  bool _checkbox21 = false;
  bool _checkbox22 = false;
  bool _checkbox23 = false;
  bool _checkbox24 = false;
  bool _checkbox25 = false;
  bool _checkbox26 = false;
  bool _checkbox27 = false;

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
                                            print("remove = $index");
                                            print(isBool);
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
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Form(
                  key: _globlekey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormWedgit(
                        hintText: "Enter Home / House Name",
                        lableText: 'House Name',
                        icon: Icon(Icons.home),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormWedgit(
                        hintText: "House Address",
                        lableText: 'House addsress',
                        icon: Icon(Icons.location_city_outlined),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormWedgit(
                        hintText: "City Name",
                        lableText: 'City Name',
                        icon: Icon(Icons.location_city_rounded),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormWedgit(
                        hintText: "Land Mark address",
                        lableText: 'Land Makr address',
                        icon: Icon(Icons.home),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Hostel Type :- ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox19,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox19 = value!;
                                });
                              }),
                          Text("Boys Hostel"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox19,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox19 = value!;
                                });
                              }),
                          Text("Girls Hostel"),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Room Type & Price :- ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox1,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox1 = value!;
                                });
                              }),
                          Text("Single Person"),
                          _checkbox1
                              ? Flexible(
                                  child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "price",
                                      labelText: "price",
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 15),
                                      isDense: true,
                                    ),
                                  ),
                                ))
                              : Text("")
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox2,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox2 = value!;
                                });
                              }),
                          Text("Doble Person"),
                          _checkbox2
                              ? Flexible(
                                  child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "price",
                                      labelText: "price",
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 15),
                                      isDense: true,
                                    ),
                                  ),
                                ))
                              : Text("")
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox3,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox3 = value!;
                                });
                              }),
                          Text("Triple Person"),
                          _checkbox3
                              ? Flexible(
                                  child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "price",
                                      labelText: "price",
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 15),
                                      isDense: true,
                                    ),
                                  ),
                                ))
                              : Text("")
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox4,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox4 = value!;
                                });
                              }),
                          Text("Four Person + "),
                          _checkbox4
                              ? Flexible(
                                  child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "price",
                                      labelText: "price",
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 15),
                                      isDense: true,
                                    ),
                                  ),
                                ))
                              : Text("")
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Provide a Facilities :- ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox5,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox5 = value!;
                                });
                              }),
                          Text("Wi-Fi"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox6,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox6 = value!;
                                });
                              }),
                          Text("Bed"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox7,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox7 = value!;
                                });
                              }),
                          Text("Chair"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox8,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox8 = value!;
                                });
                              }),
                          Text("Table"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox9,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox9 = value!;
                                });
                              }),
                          Text("Fan"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox10,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox10 = value!;
                                });
                              }),
                          Text("Gadda"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox11,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox11 = value!;
                                });
                              }),
                          Text("Light"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox12,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox12 = value!;
                                });
                              }),
                          Text("Bed Sheet"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox13,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox13 = value!;
                                });
                              }),
                          Text("Locker"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox14,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox14 = value!;
                                });
                              }),
                          Text("Washing machin"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox15,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox15 = value!;
                                });
                              }),
                          Text("Parking"),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Additional charges :- ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "In this chargs include your roon rent or not",
                        style: TextStyle(color: Colors.orange),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  value: _checkbox16,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkbox16 = value!;
                                    });
                                  }),
                              Text("Electricity Bill"),
                            ],
                          ),
                          _checkbox16
                              ? Text(
                                  "Electricity bill are  include in your room rent",
                                  style: TextStyle(color: Colors.green),
                                )
                              : Text(
                                  "Electricity bill are not include in your room rent",
                                  style: TextStyle(color: Colors.orange),
                                )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  value: _checkbox17,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkbox17 = value!;
                                    });
                                  }),
                              Text("Water Bill"),
                            ],
                          ),
                          _checkbox17
                              ? Text(
                                  "Water bill are  include in your room rent",
                                  style: TextStyle(color: Colors.green),
                                )
                              : Text(
                                  "Water bill are not include in your room rent",
                                  style: TextStyle(color: Colors.orange),
                                )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Door Closing Time :- ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox4,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox4 = value!;
                                });
                              }),
                          Text("Restricted Time "),
                          _checkbox4
                              ? Flexible(
                                  child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Enter at time",
                                      labelText: "Time",
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 15),
                                      isDense: true,
                                    ),
                                  ),
                                ))
                              : Text("")
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox18,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox18 = value!;
                                });
                              }),
                          Text("Fexible time"),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Permission :- ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Column(

                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: _checkbox19,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkbox19 = value!;
                                    });
                                  }),
                              Text("Cooking allow"),
                            ],
                          ),
                          _checkbox19
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                              value: _checkbox20,
                                              onChanged: (value) {
                                                setState(() {
                                                  _checkbox20 = value!;
                                                });
                                              }),
                                          Text("veg"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                              value: _checkbox21,
                                              onChanged: (value) {
                                                setState(() {
                                                  _checkbox21 = value!;
                                                });
                                              }),
                                          Text("Non - veg"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                              value: _checkbox22,
                                              onChanged: (value) {
                                                setState(() {
                                                  _checkbox22 = value!;
                                                });
                                              }),
                                          Text("Both"),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : Text("")
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox23,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox23 = value!;
                                });
                              }),
                          Text("Girl allow"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox24,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox24 = value!;
                                });
                              }),
                          Text("Boy allow"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _checkbox25,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox25 = value!;
                                });
                              }),
                          Text("Family member  allow"),
                        ],
                      ),
                    ],
                  ),
                ),
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
    super.key,
    required this.hintText,
    required this.lableText,
    required this.icon,
  });

  final String hintText, lableText;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(11)),
          hintText: hintText,
          labelText: lableText,
          contentPadding: EdgeInsets.only(top: 5, left: 10),
          prefixIcon: icon),
      validator: (value) {
        return null;
      },
    );
  }
}
