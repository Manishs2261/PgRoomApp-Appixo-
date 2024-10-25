import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';

import '../../../common/widgets/com_reuse_elevated_button.dart';
import '../../../utils/validator/text_field_validator.dart';
import '../../../utils/widgets/form_process_step.dart';
import '../../../utils/widgets/my_text_form_field.dart';

class FirstRoomFormScreen extends StatefulWidget {
  @override
  _FirstRoomFormScreenState createState() => _FirstRoomFormScreenState();
}

class _FirstRoomFormScreenState extends State<FirstRoomFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Room ownership type
  String roomOwnerType = 'Owner';

  // Room type
  String roomType = 'Private';

  // Room category
  String roomCategory = 'PG';

  // Gender type
  String genderType = 'Boys';

  // Meal availability
  String mealsAvailable = 'Yes';

  // Multiple image picker
  List<XFile>? _images = [];
  final ImagePicker _picker = ImagePicker();

  // Conditional fields
  TextEditingController singleRoomPriceController = TextEditingController();
  TextEditingController doubleRoomPriceController = TextEditingController();
  TextEditingController tripleRoomPriceController = TextEditingController();

  // Common facilities & house rules
  List<String> selectedFacilities = [];
  List<String> selectedCommonAreas = [];
  List<String> selectedBills = [];
  List<String> selectedHouseRules = [];

  // Form fields
  TextEditingController roomNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController securityDepositController = TextEditingController();
  TextEditingController totalRoomsController = TextEditingController();
  TextEditingController noticePeriodController = TextEditingController();

  Future<void> _pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();

    if (selectedImages != null) {
      setState(() {
        if (selectedImages.length > 10) {
          // Show a message or alert if more than 10 images are selected
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('You can only select up to 10 images!')));

          // Limit the list to 10 images
          _images = selectedImages.sublist(0, 10);
        } else {
          _images = selectedImages;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Increase the height to accommodate the progress indicator
        title: FormProcessStep(
          isFormOne: true,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 8, bottom: 64),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Room ownership type
                Text("Room Ownership Type"),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text(
                          'Owner',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                        value: 'Owner',
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity(horizontal: -4),
                        groupValue: roomOwnerType,
                        onChanged: (value) {
                          setState(() {
                            roomOwnerType = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text(
                          'Broker',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                        value: 'Broker',
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity(horizontal: -4),
                        groupValue: roomOwnerType,
                        onChanged: (value) {
                          setState(() {
                            roomOwnerType = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                // 3. Room Name
                MyTextFormWidget(
                  controller: roomNameController,
                  labelText: 'House Name',
                  icon: const Icon(
                    Icons.home,
                    color: AppColors.primary,
                  ),
                  borderRadius: BorderRadius.circular(4),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: EmailValidator.validate,
                  textKeyBoard: TextInputType.text,
                  maxLength: 40,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                  ],
                ),

                // 4. Room type - Shareable or Private
                SizedBox(
                  height: 40,
                ),
                Text("Room Type"),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity(horizontal: -4),
                        title: Text(
                          'Private',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                        value: 'Private',
                        groupValue: roomType,
                        onChanged: (value) {
                          setState(() {
                            roomType = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity(horizontal: -4),
                        dense: true,
                        title: const Text('Shareable',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14)),
                        value: 'Shareable',
                        groupValue: roomType,
                        onChanged: (value) {
                          setState(() {
                            roomType = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                if (roomType == 'Shareable') ...[
                  MyTextFormWidget(
                    textKeyBoard: TextInputType.number,
                    controller: singleRoomPriceController,

                    labelText: "Single Person Rent",

                    ///  isCollapsed: true,
                    maxLength: 6,
                    icon: Icon(
                      Icons.currency_rupee,
                      size: 20,
                      color: AppColors.primary,
                    ),

                    borderRadius: BorderRadius.circular(4),
                    //contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  MyTextFormWidget(
                    textKeyBoard: TextInputType.number,
                    controller: singleRoomPriceController,

                    labelText: "Double Person Rent",

                    ///  isCollapsed: true,
                    maxLength: 6,
                    icon: Icon(
                      Icons.currency_rupee,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    borderRadius: BorderRadius.circular(4),
                    //contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  MyTextFormWidget(
                    textKeyBoard: TextInputType.number,
                    controller: singleRoomPriceController,
                    icon: Icon(
                      Icons.currency_rupee,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    labelText: "Triple  Person Rent",

                    ///  isCollapsed: true,
                    maxLength: 6,

                    borderRadius: BorderRadius.circular(4),
                    //contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  MyTextFormWidget(
                    textKeyBoard: TextInputType.number,
                    controller: singleRoomPriceController,

                    labelText: "+ Triple Person Rent",

                    ///  isCollapsed: true,
                    maxLength: 6,
                    icon: Icon(
                      Icons.currency_rupee,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    borderRadius: BorderRadius.circular(4),
                    //contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                    ],
                  ),
                ] else if (roomType == 'Private') ...[
                  MyTextFormWidget(
                    textKeyBoard: TextInputType.number,
                    controller: singleRoomPriceController,
                    icon: Icon(
                      Icons.currency_rupee,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    labelText: "Room Rent",

                    ///  isCollapsed: true,
                    maxLength: 6,

                    borderRadius: BorderRadius.circular(4),
                    //contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                    ],
                  ),
                ],

                SizedBox(
                  height: 16,
                ),
                // 5. Room category - PG, Co-living, Flat
                Text("Room Category"),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity(horizontal: -4),
                        title: const Text('PG',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14)),
                        value: 'PG',
                        groupValue: roomCategory,
                        onChanged: (value) {
                          setState(() {
                            roomCategory = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity(horizontal: -4),
                        title: const Text('Co-living',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14)),
                        value: 'Co-living',
                        groupValue: roomCategory,
                        onChanged: (value) {
                          setState(() {
                            roomCategory = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity(horizontal: -4),
                        title: const Text('Flat',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14)),
                        value: 'Flat',
                        groupValue: roomCategory,
                        onChanged: (value) {
                          setState(() {
                            roomCategory = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                // 6. Gender types
                SizedBox(
                  height: 16,
                ),
                if (roomCategory == 'PG') ...[
                  Text("Gender Types"),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity(horizontal: -4),
                          title: const Text('Boys',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14)),
                          value: 'Boys',
                          groupValue: genderType,
                          onChanged: (value) {
                            setState(() {
                              genderType = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity(horizontal: -4),
                          title: const Text('Girls',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14)),
                          value: 'Girls',
                          groupValue: genderType,
                          onChanged: (value) {
                            setState(() {
                              genderType = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity(horizontal: -4),
                          title: const Text('Both',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14)),
                          value: 'Both',
                          groupValue: genderType,
                          onChanged: (value) {
                            setState(() {
                              genderType = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(
                  height: 16,
                ),
                // 2. Select images
                InkWell(
                  onTap: _pickImages,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.image,
                          color: AppColors.primary,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Choose Images",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                (_images != null && _images!.isNotEmpty)
                    ? Container(
                        margin: EdgeInsets.only(top: 16),
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _images!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(File(_images![index].path)),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Icon(
                        Icons.image_outlined,
                        size: 80,
                        color: Colors.grey,
                      )),

                SizedBox(
                  height: 32,
                ),

                ComReuseElevButton(
                  onPressed: () {},
                  title: 'Save & Next',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
