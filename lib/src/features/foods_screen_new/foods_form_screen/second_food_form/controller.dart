import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/route_name/routes_name.dart';

class SecondFoodFormController extends GetxController {
  RxString foodType = 'Veg'.obs;

  RxList subscriptionItem = [].obs;
  final formKey = GlobalKey<FormState>();

  RxList dailyItem = [].obs;

  RxList restructureItem = [].obs;

  final breakfastController = TextEditingController();
  final lunchOrDinnerController = TextEditingController();
  final dinnerAndBreakfastController = TextEditingController();
  final breakfastAndLunchController = TextEditingController();

  final thaliController = TextEditingController();
  final cupOfRiceController = TextEditingController();
  final dalController = TextEditingController();
  final rotiController = TextEditingController();
  final sabjiController = TextEditingController();



  // Function to add a new item
  void addSubscriptionItem(String name, double price) {
    subscriptionItem.add({'name': name, 'price': price});
  }

  // Function to add a new item
  void addDailyItem(String name, double price) {
    dailyItem.add({'name': name, 'price': price});
  }

  // Function to add a new item
  void addRestructureItem(String name, double price) {
    restructureItem.add({'name': name, 'price': price});
  }

  // Function to show dialog for adding new item
  void showAddSubscriptionItemDialog() {
    String itemName = '';
    String itemPrice = '';

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Add New Subscription"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Enter Subscription Name'),
                onChanged: (value) {
                  itemName = value;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Enter Subscription Cost'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  itemPrice = value;
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
                if (itemName.isNotEmpty && itemPrice.isNotEmpty) {
                  addSubscriptionItem(itemName, double.parse(itemPrice));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showAddRestructureItemDialog() {
    String itemName = '';
    String itemPrice = '';

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Add New Subscription"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Enter Subscription Name'),
                onChanged: (value) {
                  itemName = value;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Enter Subscription Cost'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  itemPrice = value;
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
                if (itemName.isNotEmpty && itemPrice.isNotEmpty) {
                  addRestructureItem(itemName, double.parse(itemPrice));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showAddDailyItemDialog() {
    String itemName = '';
    String itemPrice = '';

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Add New Daily Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Enter Daily Itme Name'),
                onChanged: (value) {
                  itemName = value;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'Enter Cost'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  itemPrice = value;
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
                if (itemName.isNotEmpty && itemPrice.isNotEmpty) {
                  addDailyItem(itemName, double.parse(itemPrice));
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
  void removeSubscriptionItem(int index) {
    subscriptionItem.removeAt(index);
  }

  void removeDailyItem(int index) {
    dailyItem.removeAt(index);
  }

  void removeRestructureItem(int index) {
    restructureItem .removeAt(index);
  }


  onSaveAndNext(){

    if(!formKey.currentState!.validate()){
      return;
    }
    Get.toNamed(RoutesName.thirdFoodFormScreen);
  }
}
