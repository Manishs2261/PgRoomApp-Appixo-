import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/Constants/image_string.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../utils/logger/logger.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen();

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final filterIndex = Get.arguments;

  Set<int> selectedIndices = {};
  String location = "Bilaspur";
  RangeValues _budgetRange = const RangeValues(1000, 10000);
  List<String> accommodationType = ['PG', 'Flat', 'Co-living'];
  List<String> gender = ['Boy', 'Girl', 'Both'];
  List<String> messType = ['Vag', 'Non-Vag', 'Both'];
  List<String> food = ['Yes', 'No'];
  List<String> roomType = [
    'Private Room',
    'Double Sharing',
    'Triple Sharing',
    '3+ Sharing'
  ];
  List<String> flatType = ['1RK', '1BHK', '2BHK', '3BHK', '4BHK'];
  List<String> foodType = ['Mess', 'Restaurants', 'Chopati'];
  List<String> furnishedType = [
    'Un Furnished',
    'semi Furnished',
    'Fully Furnished'
  ];
  String? selectedAccommodationType;
  String? selectedGender;
  String? selectedRoomType;
  String? selectedFood;
  String? selectedFlatType;
  String? selectedFurnishedType;
  String? selectedFoodType;
  String? selectedMessType;

  final List<String> nameOfServices = [
    'ATM',
    'Plumber',
    'Electrician',
    'Clinic',
    'Medical Shop',
    'Grocery Shop',
    'Cloth Store',
    'Bank'
  ];
  final List<String> imageOfServices = [
    AppImage.atmImage,
    AppImage.plumberImage,
    AppImage.electricianImage,
    AppImage.clinicImage,
    AppImage.medicalShopImage,
    AppImage.groceryShopImage,
    AppImage.plumberImage,
    AppImage.bankImage
  ];

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - FilterScreen......................................");

    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.grey.shade100, boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 2,
                  offset: const Offset(1, 1))
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Clear All',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('You are searching in '),
                        Text(
                          'Bilaspur',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Chnage Location',
                          style: TextStyle(fontSize: 12),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.blue,
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const Text(
                  'Filter Applied',
                  style: TextStyle(color: Colors.grey),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 10,
                    // Set the number of times to repeat the container
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          children: [
                            const Text(
                              'Bilaspur',
                              // You can update this with dynamic data if needed
                              style: TextStyle(
                                fontSize: 16,
                                height: 0,
                                color: Colors.blueAccent,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                                backgroundColor:
                                    Colors.blueAccent.withOpacity(0.1),
                                radius: 10,
                                child: const Icon(
                                  Icons.close,
                                  color: AppColors.primary,
                                  size: 16,
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          /// for room filter
          Visibility(
            visible: (filterIndex == 0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'I am looking to:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Wrap(
                    spacing: 8,
                    children: accommodationType
                        .map(
                          (type) => FilterChip(
                            label: Text(type),
                            labelStyle: TextStyle(
                                color: selectedAccommodationType == type
                                    ? Colors.white
                                    : Colors.black),
                            selected: selectedAccommodationType == type,
                            selectedColor: AppColors.primary,
                            backgroundColor: Colors.blue.withOpacity(0.08),
                            // Set color to blue when selected
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  selectedAccommodationType = type;
                                } else {
                                  selectedAccommodationType =
                                      null; // Deselect when tapped again
                                }
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: (selectedAccommodationType == 'PG'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Gender:',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Wrap(
                          spacing: 8,
                          children: gender
                              .map(
                                (type) => FilterChip(
                                  label: Text(type),
                                  labelStyle: TextStyle(
                                      color: selectedGender == type
                                          ? Colors.white
                                          : Colors.black),
                                  selected: selectedGender == type,
                                  selectedColor: AppColors.primary,
                                  backgroundColor:
                                      Colors.blue.withOpacity(0.08),
                                  // Set color to blue when selected
                                  onSelected: (selected) {
                                    setState(() {
                                      if (selected) {
                                        selectedGender = type;
                                      } else {
                                        selectedGender =
                                            null; // Deselect when tapped again
                                      }
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: (selectedAccommodationType == 'PG'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Room Type:',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          // Set the scroll direction to horizontal
                          child: Wrap(
                            spacing: 8, // Spacing between chips
                            children: roomType
                                .map(
                                  (type) => FilterChip(
                                    label: Text(type),
                                    labelStyle: TextStyle(
                                      color: selectedRoomType == type
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    selected: selectedRoomType == type,
                                    selectedColor: AppColors.primary,
                                    backgroundColor:
                                        Colors.blue.withOpacity(0.08),
                                    // Background when not selected
                                    onSelected: (selected) {
                                      setState(() {
                                        if (selected) {
                                          selectedRoomType = type;
                                        } else {
                                          selectedRoomType =
                                              null; // Deselect when tapped again
                                        }
                                      });
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (selectedAccommodationType == 'Flat'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'BHK Type:',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          // Set the scroll direction to horizontal
                          child: Wrap(
                            spacing: 8, // Spacing between chips
                            children: flatType
                                .map(
                                  (type) => FilterChip(
                                    label: Text(type),
                                    labelStyle: TextStyle(
                                      color: selectedFlatType == type
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    selected: selectedFlatType == type,
                                    selectedColor: AppColors.primary,
                                    backgroundColor:
                                        Colors.blue.withOpacity(0.08),
                                    // Background when not selected
                                    onSelected: (selected) {
                                      setState(() {
                                        if (selected) {
                                          selectedFlatType = type;
                                        } else {
                                          selectedFlatType =
                                              null; // Deselect when tapped again
                                        }
                                      });
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'Furnishing Type:',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          // Set the scroll direction to horizontal
                          child: Wrap(
                            spacing: 8, // Spacing between chips
                            children: furnishedType
                                .map(
                                  (type) => FilterChip(
                                    label: Text(type),
                                    labelStyle: TextStyle(
                                      color: selectedFurnishedType == type
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    selected: selectedFurnishedType == type,
                                    selectedColor: AppColors.primary,
                                    backgroundColor:
                                        Colors.blue.withOpacity(0.08),
                                    // Background when not selected
                                    onSelected: (selected) {
                                      setState(() {
                                        if (selected) {
                                          selectedFurnishedType = type;
                                        } else {
                                          selectedFurnishedType =
                                              null; // Deselect when tapped again
                                        }
                                      });
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: (selectedAccommodationType == 'PG' ||
                        selectedAccommodationType == 'Co-living'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Food:',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Wrap(
                          spacing: 8,
                          children: food
                              .map(
                                (type) => FilterChip(
                                  label: Text(type),
                                  labelStyle: TextStyle(
                                      color: selectedFood == type
                                          ? Colors.white
                                          : Colors.black),
                                  selected: selectedFood == type,
                                  selectedColor: AppColors.primary,
                                  backgroundColor:
                                      Colors.blue.withOpacity(0.08),
                                  // Set color to blue when selected
                                  onSelected: (selected) {
                                    setState(() {
                                      if (selected) {
                                        selectedFood = type;
                                      } else {
                                        selectedFood =
                                            null; // Deselect when tapped again
                                      }
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Budget:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  RangeSlider(
                    activeColor: AppColors.primary,
                    values: _budgetRange,
                    min: 500,
                    max: 100000,
                    divisions: 100,
                    labels: RangeLabels(
                      _budgetRange.start.round().toString(),
                      _budgetRange.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _budgetRange = values;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Selected Budget: ₹${_budgetRange.start.round()} - ₹${_budgetRange.end.round()}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),

                 ReuseElevButton(onPressed: (){
                   Get.toNamed(RoutesName.listOfRooms);
                 }, title: 'Apply Filter')
                ],
              ),
            ),
          ),

          /// for food filter
          Visibility(
            visible: (filterIndex == 1),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'I am looking to:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Wrap(
                    spacing: 8,
                    children: foodType
                        .map(
                          (type) => FilterChip(
                            label: Text(type),
                            labelStyle: TextStyle(
                                color: selectedFood == type
                                    ? Colors.white
                                    : Colors.black),
                            selected: selectedFood == type,
                            selectedColor: AppColors.primary,
                            backgroundColor: Colors.blue.withOpacity(0.08),
                            // Set color to blue when selected
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  selectedFood = type;
                                } else {
                                  selectedFood =
                                      null; // Deselect when tapped again
                                }
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: (selectedFood == 'Mess'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mess Type',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Wrap(
                          spacing: 8,
                          children: messType
                              .map(
                                (type) => FilterChip(
                                  label: Text(type),
                                  labelStyle: TextStyle(
                                      color: selectedMessType == type
                                          ? Colors.white
                                          : Colors.black),
                                  selected: selectedMessType == type,
                                  selectedColor: AppColors.primary,
                                  backgroundColor:
                                      Colors.blue.withOpacity(0.08),
                                  // Set color to blue when selected
                                  onSelected: (selected) {
                                    setState(() {
                                      if (selected) {
                                        selectedMessType = type;
                                      } else {
                                        selectedMessType =
                                            null; // Deselect when tapped again
                                      }
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: (selectedAccommodationType == 'PG'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Room Type:',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          // Set the scroll direction to horizontal
                          child: Wrap(
                            spacing: 8, // Spacing between chips
                            children: roomType
                                .map(
                                  (type) => FilterChip(
                                    label: Text(type),
                                    labelStyle: TextStyle(
                                      color: selectedRoomType == type
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    selected: selectedRoomType == type,
                                    selectedColor: AppColors.primary,
                                    backgroundColor:
                                        Colors.blue.withOpacity(0.08),
                                    // Background when not selected
                                    onSelected: (selected) {
                                      setState(() {
                                        if (selected) {
                                          selectedRoomType = type;
                                        } else {
                                          selectedRoomType =
                                              null; // Deselect when tapped again
                                        }
                                      });
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (selectedAccommodationType == 'Flat'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'BHK Type:',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          // Set the scroll direction to horizontal
                          child: Wrap(
                            spacing: 8, // Spacing between chips
                            children: flatType
                                .map(
                                  (type) => FilterChip(
                                    label: Text(type),
                                    labelStyle: TextStyle(
                                      color: selectedFlatType == type
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    selected: selectedFlatType == type,
                                    selectedColor: AppColors.primary,
                                    backgroundColor:
                                        Colors.blue.withOpacity(0.08),
                                    // Background when not selected
                                    onSelected: (selected) {
                                      setState(() {
                                        if (selected) {
                                          selectedFlatType = type;
                                        } else {
                                          selectedFlatType =
                                              null; // Deselect when tapped again
                                        }
                                      });
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'Furnishing Type:',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          // Set the scroll direction to horizontal
                          child: Wrap(
                            spacing: 8, // Spacing between chips
                            children: furnishedType
                                .map(
                                  (type) => FilterChip(
                                    label: Text(type),
                                    labelStyle: TextStyle(
                                      color: selectedFurnishedType == type
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    selected: selectedFurnishedType == type,
                                    selectedColor: AppColors.primary,
                                    backgroundColor:
                                        Colors.blue.withOpacity(0.08),
                                    // Background when not selected
                                    onSelected: (selected) {
                                      setState(() {
                                        if (selected) {
                                          selectedFurnishedType = type;
                                        } else {
                                          selectedFurnishedType =
                                              null; // Deselect when tapped again
                                        }
                                      });
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ReuseElevButton(onPressed: (){
                    Get.toNamed(RoutesName.listOfFoods);
                  }, title: 'Apply Filter')
                ],
              ),
            ),
          ),

          /// for services card
          Visibility(
            visible: (filterIndex == 3),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: nameOfServices.asMap().entries.map((entry) {
                        int index = entry.key;
                        String name = entry.value;

                        return GestureDetector(
                          onTap: (){

                            setState(() {
                              // Toggle selection state
                              if (selectedIndices.contains(index)) {
                                selectedIndices.remove(index); // Deselect if already selected
                              } else {
                                selectedIndices.add(index); // Select if not selected
                              }
                            });
                          },
                          child: Container(
                              height: 80,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selectedIndices.contains(index)
                                    ? AppColors.primary
                                    : Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(imageOfServices[index]),
                                    backgroundColor: Colors.white,
                                  ),

                                  // Spacing between image and text
                                  // Name text
                                  Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: selectedIndices.contains(index)
                                        ? Colors.white
                                        : Colors.black,

                                    ),
                                  ),
                                ],
                              )),
                        );
                      }).toList()),

                  const SizedBox(height: 24,),
                  ReuseElevButton(onPressed: (){
                    Get.toNamed(RoutesName.listOfServices);
                  }, title: 'Apply Filter')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
