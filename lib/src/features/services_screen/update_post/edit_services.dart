import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pgroom/src/features/Home_fitter_new/new_search_home/controller.dart';

import '../../../res/route_name/routes_name.dart';
import '../../../utils/logger/logger.dart';

class EditServicesPostList extends StatefulWidget {
  const EditServicesPostList({super.key});

  @override
  State<EditServicesPostList> createState() => _EditPostListState();
}

class _EditPostListState extends State<EditServicesPostList> {
  final homeController = Get.put(HomeController());
  final servicesData = Get.arguments;


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
            title: const Text('Details '),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () => Get.toNamed(RoutesName.firstUpdateServicesForm,
                arguments: servicesData
            ),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Map'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () => Get.toNamed(RoutesName.secondUpdateServicesForm,arguments: servicesData),
          ),



        ],
      ),
    );
  }
}
