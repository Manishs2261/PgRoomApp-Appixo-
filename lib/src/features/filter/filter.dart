import 'package:flutter/material.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String location = "Bilaspur";
  RangeValues _budgetRange = RangeValues(5000, 50000);
  List<String> accommodationType = ['PG', 'Rent', 'Flat', 'Co-living'];
  String selectedGender = 'Any';
  String roomType = 'Private';
  String? selectedAccommodationType;

  void _clearAllFilters() {
    setState(() {
      selectedGender = 'Any';
      roomType = 'Private';
      _budgetRange = RangeValues(5000, 50000);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.grey.shade200, boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 4,
                  offset: Offset(1, 2))
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.arrow_back,
                ),
                Row(
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
                Row(
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
                        Text(
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
                SizedBox(
                  height: 8,
                ),
                Divider(),
                Text(
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
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          children: [
                            Text(
                              'Bilaspur',
                              // You can update this with dynamic data if needed
                              style: TextStyle(
                                fontSize: 16,
                                height: 0,
                                color: Colors.blueAccent,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                                backgroundColor:
                                    Colors.blueAccent.withOpacity(0.1),
                                radius: 10,
                                child: Icon(
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'I am looking to:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 8,
                  children: accommodationType
                      .map(
                        (type) => FilterChip(
                          label: Text(type),
                          labelStyle: TextStyle(color: selectedAccommodationType == type ? Colors.white:Colors.black),
                          selected: selectedAccommodationType == type,
                          selectedColor: Colors.blue,
                          backgroundColor: Colors.blue.withOpacity(0.08), // Set color to blue when selected
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
                )
              ],
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Gender',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          DropdownButton<String>(
            value: selectedGender,
            items: <String>['Any', 'Male', 'Female'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedGender = newValue!;
              });
            },
          ),
          SizedBox(height: 24),
          Text(
            'Room Type',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          DropdownButton<String>(
            value: roomType,
            items: <String>['Private', 'Double', 'Triple', '3+']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                roomType = newValue!;
              });
            },
          ),
          SizedBox(height: 24),
          Text(
            'Budget',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          RangeSlider(
            values: _budgetRange,
            min: 1000,
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
          SizedBox(height: 16),
          Text(
            'Selected Budget: ₹${_budgetRange.start.round()} - ₹${_budgetRange.end.round()}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Apply the filters
            },
            child: Text('Apply Filters'),
          ),
        ],
      ),
    );
  }
}
