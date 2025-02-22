import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../res/route_name/routes_name.dart';
import '../../../model/food_model.dart';

class SecondFoodFormController extends GetxController {
  RxString foodType = 'Veg'.obs;

  RxList<SubscriptionList> subscriptionItem = <SubscriptionList>[].obs;
  final formKey = GlobalKey<FormState>();

  RxList<DailyItemList> dailyItem = <DailyItemList>[].obs;

  RxList<RestructureMenuList> restructureItem = <RestructureMenuList>[].obs;

  final breakfastController = TextEditingController();
  final lunchOrDinnerController = TextEditingController();
  final dinnerAndLunchCostController = TextEditingController();
  final breakfastAndLunchDinnerController = TextEditingController();

  final thaliController = TextEditingController();
  final cupOfRiceController = TextEditingController();
  final dalController = TextEditingController();
  final rotiController = TextEditingController();
  final sabjiController = TextEditingController();



  // Function to add a new item
  void addSubscriptionItem(String name, String price) {
    subscriptionItem.add(SubscriptionList(name: name, price: price));
  }

  // Function to add a new item
  void addDailyItem(String name, String price) {
    dailyItem.add( DailyItemList(name: name, price: price));
  }

  // Function to add a new item
  void addRestructureItem(String name, String price) {
    restructureItem.add(RestructureMenuList(name: name, price: price));
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
                  addSubscriptionItem(itemName, itemPrice);
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
                  addRestructureItem(itemName, itemPrice);
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
                  addDailyItem(itemName, itemPrice);
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
