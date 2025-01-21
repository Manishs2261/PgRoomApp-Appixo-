
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/foods_screen_new/model/food_model.dart';

class FourFoodUpdateFormController extends GetxController {

  final formKey = GlobalKey<FormState>();

  final FoodModel foodModel = Get.arguments;

  final RxList<String> availableHouseRules = [
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
  ].obs;

  RxList<String> selectedHouseRules =
      <String>[].obs;
  // To store selected facilities
  TextEditingController newHouseRulesController = TextEditingController();



  @override
  void onInit() {
    selectedHouseRules.addAll(foodModel.messRules ?? []);
    foodFAQ.addAll(foodModel.fAQ ?? []);
    super.onInit();
  }


  // For adding new facilities
  void addNewFacility(String facility) {
    if (facility.isNotEmpty && !availableHouseRules.contains(facility)) {
      availableHouseRules.add(facility);

    }
    newHouseRulesController.clear();
  }

  RxList<FoodFAQ> foodFAQ = <FoodFAQ>[].obs;

  // Function to add a new item
  void addFoodFAQ(String question, String answer) {
    foodFAQ.add(FoodFAQ(question: question, answer: answer));

  }

  // Function to show dialog for adding new item
  void showAddFoodFAQDialog() {
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
                  addFoodFAQ(itemQuestion, itemAnswer);
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
  void removeFoodFAQ(int index) {
    foodFAQ.removeAt(index);

  }



}