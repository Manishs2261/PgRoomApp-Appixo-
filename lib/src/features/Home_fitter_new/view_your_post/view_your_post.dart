import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pgroom/src/features/Home_fitter_new/new_search_home/controller.dart';

import '../../../res/route_name/routes_name.dart';
import '../../../utils/logger/logger.dart';

class EditPostList extends StatefulWidget {
  const EditPostList({super.key});

  @override
  State<EditPostList> createState() => _EditPostListState();
}

class _EditPostListState extends State<EditPostList> {
  final homeController = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - EditPostList.........................");

    return Scaffold(
      appBar: AppBar(title: Text('Update Post',style: TextStyle(fontWeight: FontWeight.w400),),),
      body: ListView(
        padding: const EdgeInsets.only(top: 16),
        children: [
          ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Room'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              onTap: () => Get.toNamed(RoutesName.roomUpdateList),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Food '),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () => Get.toNamed(RoutesName.foodUpdateList),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Buy & Sell'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () => Get.toNamed(RoutesName.sellAndBuyUpdateList),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Services'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () => Get.toNamed(RoutesName.servicesUpdateList),
          ),

        ],
      ),
    );
  }
}
