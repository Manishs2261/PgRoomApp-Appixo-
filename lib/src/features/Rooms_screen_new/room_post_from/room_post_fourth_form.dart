import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';

import '../../../utils/logger/logger.dart';
import '../../../utils/widgets/form_process_step.dart';

class FourthRoomFormScreen extends StatefulWidget {
  const FourthRoomFormScreen({super.key});

  @override
  _FourthRoomFormScreenState createState() => _FourthRoomFormScreenState();
}

class _FourthRoomFormScreenState extends State<FourthRoomFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<String> availableHouseRules = [
    "Available for Students & Working Professionals  ",
    "Non veg food is allowed",
    "Smoking is allowed",
    "Drinking is allowed",
    "Guardian is allowed",
    "Visitors are allowed",
    "Guests of opposite gender are allowed"
  ];

  Set<String> selectedHouseRules =
      Set<String>(); // To store selected facilities
  TextEditingController newHouseRulesController =
      TextEditingController(); // For adding new facilities

  void _addNewFacility(String facility) {
    if (facility.isNotEmpty && !availableHouseRules.contains(facility)) {
      setState(() {
        availableHouseRules.add(facility);
      });
    }
    newHouseRulesController.clear();
  }

  @override
  Widget build(BuildContext context) {

    AppLoggerHelper.debug(
        "Build - _FourthRoomFormScreenState......................................");
    return Scaffold(
      appBar: AppBar(
        // Increase the height to accommodate the progress indicator
        title: FormProcessStep(
          isFormOne: true,
          isFormTwo: true,
          isFormThree: true,
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
                Text("House Rules",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    // Wrap for FilterChips
                    Wrap(
                      runSpacing: 8,
                      spacing: 8,
                      children: availableHouseRules.map((facility) {
                        final isSelected =
                            selectedHouseRules.contains(facility);
                        return FilterChip(
                          backgroundColor: Colors.white,
                          selectedColor: AppColors.primary,
                          label: Text(
                            facility,

                            overflow: TextOverflow.ellipsis,
                            // Optionally add an ellipsis for long text
                            maxLines: 5,
                            // Set the maximum number of lines
                            softWrap: true,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.black, // Selected text color
                            ),
                          ),
                          selected: selectedHouseRules.contains(facility),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedHouseRules.add(facility);
                              } else {
                                selectedHouseRules.remove(facility);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),

                    // TextField for adding new facilities
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onTapOutside: (event) =>
                                  FocusScope.of(context).unfocus(),
                              controller: newHouseRulesController,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z ]")),
                              ],
                              decoration: InputDecoration(
                                labelText: 'Add a new facility',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                isDense: true,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add_circle_outline_sharp,
                              color: AppColors.primary,
                              size: 35,
                            ),
                            onPressed: () {
                              _addNewFacility(newHouseRulesController.text);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),

                // Save button
                SizedBox(height: 20),
                ReuseElevButton(
                  onPressed: () {},
                  title: "Done",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
