import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/Rooms_screen_new/model/room_model.dart';

class FourthRoomUpdateFormController extends GetxController {
  final formKey = GlobalKey<FormState>();
final RoomModel roomData = Get.arguments;
  final RxList availableHouseRules = [
    "Available for Students & Working Professionals  ",
    "Non veg food is allowed",
    "Smoking is allowed",
    "Drinking is allowed",
    "Guardian is allowed",
    "Visitors are allowed",
    "Guests of opposite gender are allowed"
  ].obs;

  RxList<String> selectedHouseRules = <String>[].obs;

  // To store selected facilities
  TextEditingController newHouseRulesController = TextEditingController();



  @override
  void onInit() {
    selectedHouseRules.addAll(roomData.houseRules ?? []);
    houseFAQ.addAll(roomData.houseFAQ ?? []);
    super.onInit();
  }

  // For adding new facilities
  void addNewFacility(String facility) {
    if (facility.isNotEmpty && !availableHouseRules.contains(facility)) {
      availableHouseRules.add(facility);
    }
    newHouseRulesController.clear();
  }

  RxList<HouseFAQ> houseFAQ = <HouseFAQ>[].obs;

  // Function to add a new item
  void addHouseFAQ(String question, String answer) {
    houseFAQ.add(HouseFAQ(question: question, answer: answer));
  }

  // Function to show dialog for adding new item
  void showAddHouseFAQDialog() {
    String itemQuestion = '';
    String itemAnswer = '';

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Add New FAQ"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Enter Questions'),
                maxLines: 2,
                minLines: 1,
                onChanged: (value) {
                  itemQuestion = value;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'Enter Answer'),
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
              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                if (itemQuestion.isNotEmpty && itemAnswer.isNotEmpty) {
                  addHouseFAQ(itemQuestion, itemAnswer);
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
  void removeHouseFAQ(int index) {
    houseFAQ.removeAt(index);
  }
}
