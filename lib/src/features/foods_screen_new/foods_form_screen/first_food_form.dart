import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/widgets/com_reuse_elevated_button.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../utils/Constants/colors.dart';
import '../../../utils/logger/logger.dart';
import '../../../utils/validator/text_field_validator.dart';
import '../../../utils/widgets/form_process_step.dart';
import '../../../utils/widgets/my_text_form_field.dart';

class FirstFoodForm extends StatefulWidget {
  const FirstFoodForm({super.key});

  @override
  State<FirstFoodForm> createState() => _FirstFoodFormState();
}

class _FirstFoodFormState extends State<FirstFoodForm> {

  final _formKey = GlobalKey<FormState>();
  // food type
  String roomOwnerType = 'Owner';

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - FirstFoodForm......................................");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // Increase the height to accommodate the progress indicator
        title: FormProcessStep(
          isFormOne: true,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 64),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


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
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text(
                          'Room Mete',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                        value: 'RoomMate',
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



                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  //   controller: controller.houseAddressController.value,

                  labelText: '',
                  icon: const Icon(Icons.home, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: AddressValidator.validate,
                  maxLength: 100,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),

                //==========House Address================
                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  //   controller: controller.houseAddressController.value,

                  labelText: 'House address',
                  icon: const Icon(Icons.home, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: AddressValidator.validate,
                  maxLength: 100,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                //===========City Name================
                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  //   controller: controller.cityNameController.value,

                  labelText: 'Enter landmark',
                  icon: const Icon(Icons.location_on, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CityValidator.validate,
                  maxLength: 40,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                //============Land Mark address=================
                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  //    controller: controller.landMarkController.value,
                  labelText: 'Enter City',
                  icon: const Icon(Icons.location_city_outlined,
                      color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: LandMarkValidator.validate,
                  maxLength: 100,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),

                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  //    controller: controller.landMarkController.value,
                  labelText: 'Enter State',
                  icon: const Icon(Icons.map, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: LandMarkValidator.validate,
                  maxLength: 100,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),

                MyTextFormWidget(
                  textKeyBoard: TextInputType.number,
                  maxLength: 2,
                  // controller: controller.numberOfRoomsController.value,
                  labelText: 'Total number of rooms',
                  icon: const Icon(Icons.home_work_rounded,
                      color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),

                // 15. Meals availability
                Text(
                  "Meals Available",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: RadioListTile<String>(
                //         title: const Text('Yes'),
                //         value: 'Yes',
                //         dense: true,
                //         groupValue: mealsAvailable,
                //         onChanged: (value) {
                //           setState(() {
                //             mealsAvailable = value!;
                //           });
                //         },
                //       ),
                //     ),
                //     Expanded(
                //       child: RadioListTile<String>(
                //         title: const Text('No'),
                //         value: 'No',
                //         dense: true,
                //         groupValue: mealsAvailable,
                //         onChanged: (value) {
                //           setState(() {
                //             mealsAvailable = value!;
                //           });
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                // MyTextFormWidget(
                //   textKeyBoard: TextInputType.number,
                //   maxLength: 2,
                //   // controller: controller.numberOfRoomsController.value,
                //   labelText: 'One time security deposit',
                //   icon: const Icon(Icons.currency_rupee,
                //       color: AppColors.primary),
                //   borderRadius: BorderRadius.circular(11),
                //   contentPadding: const EdgeInsets.only(top: 5, left: 10),
                //   validator: CommonUseValidator.validate,
                //   inputFormatters: <TextInputFormatter>[
                //     FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                //   ],
                // ),
                //
                // const SizedBox(
                //   height: 16,
                // ),
                // // 12. Room facilities (Multiple choice)
                // Text("Room Facilities",
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w500,
                //         color: Colors.black)),
                // const SizedBox(
                //   height: 16,
                // ),
                // Column(
                //   children: [
                //     // Wrap for FilterChips
                //     Wrap(
                //       runSpacing: 8,
                //       spacing: 8,
                //       children: availableFacilities.map((facility) {
                //         final isSelected =
                //         selectedFacilities.contains(facility);
                //         return FilterChip(
                //           backgroundColor: Colors.white,
                //           selectedColor: AppColors.primary,
                //           label: Text(
                //             facility,
                //             style: TextStyle(
                //               color: isSelected
                //                   ? Colors.white
                //                   : Colors.black, // Selected text color
                //             ),
                //           ),
                //           selected: selectedFacilities.contains(facility),
                //           onSelected: (selected) {
                //             setState(() {
                //               if (selected) {
                //                 selectedFacilities.add(facility);
                //               } else {
                //                 selectedFacilities.remove(facility);
                //               }
                //             });
                //           },
                //         );
                //       }).toList(),
                //     ),
                //
                //     // TextField for adding new facilities
                //     Padding(
                //       padding: const EdgeInsets.only(top: 16.0),
                //       child: Row(
                //         children: [
                //           Expanded(
                //             child: TextField(
                //               controller: newFacilityController,
                //               inputFormatters: <TextInputFormatter>[
                //                 FilteringTextInputFormatter.allow(
                //                     RegExp("[a-zA-Z]")),
                //               ],
                //               decoration: InputDecoration(
                //                 labelText: 'Add a new facility',
                //                 border: OutlineInputBorder(
                //                     borderRadius: BorderRadius.circular(8)),
                //                 focusedBorder: OutlineInputBorder(
                //                   borderRadius: BorderRadius.circular(8),
                //                 ),
                //                 isDense: true,
                //               ),
                //             ),
                //           ),
                //           IconButton(
                //             icon: Icon(
                //               Icons.add_circle_outline_sharp,
                //               color: AppColors.primary,
                //               size: 35,
                //             ),
                //             onPressed: () {
                //               _addNewFacility(newFacilityController.text);
                //             },
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                //
                // const SizedBox(
                //   height: 16,
                // ),

                // 16. Common areas
                // Text("Common Areas",
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w500,
                //         color: Colors.black)),
                // const SizedBox(
                //   height: 16,
                // ),
                //
                // Column(
                //   children: [
                //     Wrap(
                //         runSpacing: 8,
                //         spacing: 8,
                //         children: availableCommonAreas.map((area) {
                //           final isSelected = selectedCommonAreas.contains(area);
                //           return FilterChip(
                //             label: Text(
                //               area,
                //               style: TextStyle(
                //                 color: isSelected
                //                     ? Colors.white
                //                     : Colors.black, // Selected text color
                //               ),
                //             ),
                //             selectedColor: AppColors.primary,
                //             backgroundColor: Colors.white,
                //             selected: selectedCommonAreas.contains(area),
                //             onSelected: (selected) {
                //               setState(() {
                //                 if (selected) {
                //                   selectedCommonAreas.add(area);
                //                 } else {
                //                   selectedCommonAreas.remove(area);
                //                 }
                //               });
                //             },
                //           );
                //         }).toList()),
                //   ],
                // ),
                // SizedBox(
                //   height: 16,
                // ),
                // // 17. Bill responsibilities
                // Text(
                //   "Bills",
                //   style: TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.w500,
                //       color: Colors.black),
                // ),
                // SizedBox(
                //   height: 16,
                // ),
                // Wrap(
                //   runSpacing: 8,
                //   spacing: 8,
                //   children: availableBills.map((bill) {
                //     final isSelected = selectedCommonAreas.contains(bill);
                //
                //     return FilterChip(
                //       label: Text(
                //         bill,
                //         style: TextStyle(
                //           color: isSelected
                //               ? Colors.white
                //               : Colors.black, // Selected text color
                //         ),
                //       ),
                //       selectedColor: AppColors.primary,
                //       backgroundColor: Colors.white,
                //       selected: selectedCommonAreas.contains(bill),
                //       onSelected: (selected) {
                //         setState(() {
                //           if (selected) {
                //             selectedCommonAreas.add(bill);
                //           } else {
                //             selectedCommonAreas.remove(bill);
                //           }
                //         });
                //       },
                //     );
                //     ;
                //   }).toList(),
                // ),

                // Save button
                SizedBox(height: 20),
                ReuseElevButton(
                  onPressed: () => Get.toNamed(RoutesName.thirdRoomFormScreen),
                  title: "Save & Next",
                ),

                SizedBox(height: 20),
                ReuseElevButton(
                  color: Colors.orange,
                  onPressed: () => Get.back(),
                  title: "Back",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  }

