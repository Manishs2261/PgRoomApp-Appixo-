import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/widgets/form_headline.dart';

import '../../../utils/logger/logger.dart';
import '../../../utils/widgets/form_process_step.dart';

class FourthFoodForm extends StatefulWidget {
  const FourthFoodForm({super.key});

  @override
  _FourthFoodFormState createState() => _FourthFoodFormState();
}

class _FourthFoodFormState extends State<FourthFoodForm> {
  final _formKey = GlobalKey<FormState>();

  final List<String> availableHouseRules = [
    "In one Thali, only one person is allowed to eat",
    "Sabji (vegetable dish) can be taken extra only once. (Additional servings can be purchased separately.)",
    "Extra roti (bread) will not be provided. (Additional roti can be purchased separately.)",
    "Apart from the designated Salad/Papad, no additional variety in Salad or Papad will be available.",
    "Please wait patiently for your turn; food will be served to everyone.",
    "Only leaves between 2 to 7 days will be considered for the Monthly Mess Plan (2 times).",
    "It is necessary to inform at least 5 hours in advance for leave; otherwise, it will not be considered.",
    "Half-day leaves cannot be counted, as planning is done on a per-day basis.",
    "No refund will be given after 24 hours of Mess Plan registration. To get a refund, inform within 24 hours of registration.",
    "For 1 month, 1 time plans or plans shorter than a month, leave and refund facilities are not available."
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

  List<Map<String, dynamic>> foodFAQ = [];

  // Function to add a new item
  void _addFoodFAQ(String question, String answer) {
    setState(() {
      foodFAQ.add({'question': question, 'answer': answer});
    });
  }

  // Function to show dialog for adding new item
  void _showAddFoodFAQDialog() {
    String  itemQuestion = '';
    String itemAnswer = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Add New FAQ"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration:
                    InputDecoration(labelText: 'Enter Questions'),
                maxLines: 2,
                minLines: 1,
                onChanged: (value) {
                   itemQuestion = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration:
                    InputDecoration(labelText: 'Enter Answer'),
                keyboardType: TextInputType.text,
                maxLines: 5,
                minLines: 1,
                onChanged: (value) {
                  itemAnswer = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Save",
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                if ( itemQuestion.isNotEmpty && itemAnswer.isNotEmpty) {
                  _addFoodFAQ( itemQuestion, itemAnswer);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Function to remove an item
  void _removeFoodFAQ(int index) {
    setState(() {
      foodFAQ.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - _FourthRoomFormScreenState......................................");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                FormHeadline(title: 'Mess rule'),
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

                FormHeadline(title: 'Mess FAQ'),
                SizedBox(
                  height: 5,
                ),

                foodFAQ.isEmpty
                    ? Center(child: Text(''))
                    : Column(
                        children: foodFAQ.asMap().entries.map((entry) {
                          int index = entry.key;
                          Map<String, dynamic> item = entry.value;

                          return ListTile(
                            title: Text(  'Q${index + 1} :-  ${foodFAQ[index]['question']}'),
                            subtitle:
                                Text('Answer :-  ${foodFAQ[index]['answer']}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeFoodFAQ(index),
                            ),
                          );
                        }).toList(),
                      ),



                Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: _showAddFoodFAQDialog,
                      icon: Icon(
                        Icons.add_circle_outline_sharp,
                        size: 40,
                      ),
                    )),

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
