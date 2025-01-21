import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/route_name/routes_name.dart';
import '../../../utils/logger/logger.dart';

class EditFoodPostList extends StatefulWidget {
  const EditFoodPostList({super.key});

  @override
  State<EditFoodPostList> createState() => _EditFoodPostList();
}

class _EditFoodPostList extends State<EditFoodPostList> {
  final foodData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - EditPostList.........................");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Post',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 16),
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Details'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () => Get.toNamed(RoutesName.firstFoodUpdateForm,
                arguments: foodData),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Address'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () => Get.toNamed(RoutesName.secondFoodUpdateForm,
                arguments: foodData),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('FAQ'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () => Get.toNamed(RoutesName.fourthFoodUpdateForm,
                arguments: foodData),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Map'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () => Get.toNamed(RoutesName.thirdFoodUpdateForm,
                arguments: foodData),
          ),
        ],
      ),
    );
  }
}
