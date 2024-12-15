import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/services_model.dart';

class ThirdServicesFormController extends GetxController {
  // Observable list of ServiceFAQ objects
  RxList<ServiceFAQ> servicesFAQ = <ServiceFAQ>[].obs;

// Function to add a new item
  void addServicesFAQ(String question, String answer) {
    servicesFAQ.add(ServiceFAQ(question: question, answer: answer));
  }

  // Function to show dialog for adding new item
  void showAddServicesFAQDialog() {
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
                  addServicesFAQ(itemQuestion, itemAnswer);
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
  void removeServicesFAQ(int index) {
    servicesFAQ.removeAt(index);
  }
}
