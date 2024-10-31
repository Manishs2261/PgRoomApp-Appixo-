import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/Constants/colors.dart';
import '../../../utils/validator/text_field_validator.dart';
import '../../../utils/widgets/form_process_step.dart';
import '../../../utils/widgets/my_text_form_field.dart';

class SecondFoodForm extends StatefulWidget {
  const SecondFoodForm({super.key});

  @override
  State<SecondFoodForm> createState() => _SecondFoodFormState();
}

class _SecondFoodFormState extends State<SecondFoodForm> {
  String roomOwnerType = 'Veg';

  List<Map<String, dynamic>> subscriptionItem = [];
  List<Map<String, dynamic>> dailyItem = [];



  // Function to add a new item
  void _addSubscriptionItem(String name, double price) {
    setState(() {
      subscriptionItem.add({'name': name, 'price': price});
    });
  }

  // Function to add a new item
  void _addDailyItem(String name, double price) {
    setState(() {
      dailyItem.add({'name': name, 'price': price});
    });
  }

  // Function to show dialog for adding new item
  void _showAddSubscriptionItemDialog() {
    String itemName = '';
    String itemPrice = '';

    showDialog(
      context: context,

      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Add New Subscription"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Enter Subscription Name'),
                onChanged: (value) {
                  itemName = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Enter Subscription Cost'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  itemPrice = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel",style: TextStyle(fontSize: 18),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Save",style: TextStyle(fontSize: 18),),
              onPressed: () {
                if (itemName.isNotEmpty && itemPrice.isNotEmpty) {
                  _addSubscriptionItem(itemName, double.parse(itemPrice));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
  void _showAddDailyItemDialog() {
    String itemName = '';
    String itemPrice = '';

    showDialog(
      context: context,

      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Add New Daily Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Enter Daily Itme Name'),
                onChanged: (value) {
                  itemName = value;
                },
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'Enter Cost'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  itemPrice = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel",style: TextStyle(fontSize: 18),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Save",style: TextStyle(fontSize: 18),),
              onPressed: () {
                if (itemName.isNotEmpty && itemPrice.isNotEmpty) {
                  _addDailyItem(itemName, double.parse(itemPrice));
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
  void _removeSubscriptionItem(int index) {
    setState(() {
      subscriptionItem.removeAt(index);
    });
  }


  void _removeDailyItem(int index) {
    setState(() {
      dailyItem.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Food Type",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Wrap(
                children: [
                  _buildRadioListTile('Veg', 'Veg'),
                  _buildRadioListTile('Nonveg', 'Non-Veg'),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Monthly Subscription",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              MyTextFormWidget(
                textKeyBoard: TextInputType.text,
                //   controller: controller.houseAddressController.value,
        
                labelText: 'Breakfast',
                icon: const Icon(Icons.currency_rupee, color: AppColors.primary),
                borderRadius: BorderRadius.circular(11),
                contentPadding: const EdgeInsets.only(top: 5, left: 10),
                validator: AddressValidator.validate,
                maxLength: 100,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              MyTextFormWidget(
                textKeyBoard: TextInputType.text,
                //   controller: controller.houseAddressController.value,
        
                labelText: 'Lunch Or Dinner (only One)',
                icon: const Icon(Icons.currency_rupee, color: AppColors.primary),
                borderRadius: BorderRadius.circular(11),
                contentPadding: const EdgeInsets.only(top: 5, left: 10),
                validator: AddressValidator.validate,
                maxLength: 100,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              MyTextFormWidget(
                textKeyBoard: TextInputType.text,
                //   controller: controller.houseAddressController.value,
        
                labelText: 'Lunch Or Dinner (Both)',
                icon: const Icon(Icons.currency_rupee, color: AppColors.primary),
                borderRadius: BorderRadius.circular(11),
                contentPadding: const EdgeInsets.only(top: 5, left: 10),
                validator: AddressValidator.validate,
                maxLength: 100,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              MyTextFormWidget(
                textKeyBoard: TextInputType.text,
                //   controller: controller.houseAddressController.value,
        
                labelText: 'Breakfast, Lunch & Dinner',
                icon: const Icon(Icons.currency_rupee, color: AppColors.primary),
                borderRadius: BorderRadius.circular(11),
                contentPadding: const EdgeInsets.only(top: 5, left: 10),
                validator: AddressValidator.validate,
                maxLength: 100,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                ],
              ),
              subscriptionItem.isEmpty
                  ? Center(child: Text(''))
                  : Column(
                children: subscriptionItem.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> item = entry.value;
                  return  ListTile(
                    title: Text(subscriptionItem[index]['name']),
                    subtitle: Text('Cost: \₹ ${subscriptionItem[index]['price']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeSubscriptionItem(index),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                  alignment: Alignment.center,
                  child: IconButton(
                onPressed: _showAddSubscriptionItemDialog,
                icon: Icon(
                  Icons.add_circle_outline_sharp,
                  size: 40,
                ),
              )),


               SizedBox(
                height: 16,),


              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Add padding if needed
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.pink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8), // Rounded corners if desired
                ),
                child: Text(
                  "Daily meals cost",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white, // Text color to contrast with the background
                  ),
                ),
              ),


              SizedBox(
                height: 16,
              ),
              MyTextFormWidget(
                textKeyBoard: TextInputType.text,
                //   controller: controller.houseAddressController.value,

                labelText: 'Thali',
                icon: const Icon(Icons.currency_rupee, color: AppColors.primary),
                borderRadius: BorderRadius.circular(11),
                contentPadding: const EdgeInsets.only(top: 5, left: 10),
                validator: AddressValidator.validate,
                maxLength: 100,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              MyTextFormWidget(
                textKeyBoard: TextInputType.text,
                //   controller: controller.houseAddressController.value,

                labelText: 'a cup of rice',
                icon: const Icon(Icons.currency_rupee, color: AppColors.primary),
                borderRadius: BorderRadius.circular(11),
                contentPadding: const EdgeInsets.only(top: 5, left: 10),
                validator: AddressValidator.validate,
                maxLength: 100,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              MyTextFormWidget(
                textKeyBoard: TextInputType.text,
                //   controller: controller.houseAddressController.value,

                labelText: 'Roti per pice',
                icon: const Icon(Icons.currency_rupee, color: AppColors.primary),
                borderRadius: BorderRadius.circular(11),
                contentPadding: const EdgeInsets.only(top: 5, left: 10),
                validator: AddressValidator.validate,
                maxLength: 100,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              MyTextFormWidget(
                textKeyBoard: TextInputType.text,
                //   controller: controller.houseAddressController.value,

                labelText: 'Sabaji',
                icon: const Icon(Icons.currency_rupee, color: AppColors.primary),
                borderRadius: BorderRadius.circular(11),
                contentPadding: const EdgeInsets.only(top: 5, left: 10),
                validator: AddressValidator.validate,
                maxLength: 100,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              MyTextFormWidget(
                textKeyBoard: TextInputType.text,
                //   controller: controller.houseAddressController.value,

                labelText: 'Dal',
                icon: const Icon(Icons.currency_rupee, color: AppColors.primary),
                borderRadius: BorderRadius.circular(11),
                contentPadding: const EdgeInsets.only(top: 5, left: 10),
                validator: AddressValidator.validate,
                maxLength: 100,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                ],
              ),
               dailyItem.isEmpty
                  ? Center(child: Text(''))
                  : Column(
                children: dailyItem.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> item = entry.value;
                  return  ListTile(
                    title: Text(dailyItem[index]['name']),
                    subtitle: Text('Cost: \₹ ${dailyItem[index]['price']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeDailyItem(index),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed:  _showAddDailyItemDialog,
                    icon: Icon(
                      Icons.add_circle_outline_sharp,
                      size: 40,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  /// Radio List Tile for food type
  Widget _buildRadioListTile(String title, String value) {
    return SizedBox(
      width: 150,
      child: RadioListTile<String>(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        value: value,
        dense: false,
        contentPadding: EdgeInsets.zero,
        visualDensity: VisualDensity(
          horizontal: -4,
        ),
        groupValue: roomOwnerType,
        onChanged: (value) {
          setState(() {
            roomOwnerType = value!;
          });
        },
      ),
    );
  }
}
