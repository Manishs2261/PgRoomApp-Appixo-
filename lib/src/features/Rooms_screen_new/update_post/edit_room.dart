import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/Home_fitter_new/new_search_home/controller.dart';

import '../../../res/route_name/routes_name.dart';
import '../../../utils/logger/logger.dart';

class EditRoomPostList extends StatefulWidget {
  const EditRoomPostList({super.key});

  @override
  State<EditRoomPostList> createState() => _EditRoomPostListState();
}

class _EditRoomPostListState extends State<EditRoomPostList> {
  final homeController = Get.put(HomeController());
  final roomData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - EditRoomPostList.........................");

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
            onTap: () => Get.toNamed(RoutesName.firstRoomUpdateFormScreen,
                arguments: roomData),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Address'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () => Get.toNamed(RoutesName.secondRoomUpdateFormScreen,
                arguments: roomData),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('FAQ And Rules'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () => Get.toNamed(RoutesName.fourthRoomUpdateFormScreen,
                arguments: roomData),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Map'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () => Get.toNamed(RoutesName.thirdRoomUpdateFormScreen,
                arguments: roomData),
          ),
        ],
      ),
    );
  }
}
