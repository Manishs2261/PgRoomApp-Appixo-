import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/colors.dart';
import 'controller/controller.dart';
// Import the controller

class TopSearchFilter extends StatelessWidget {
  final searchController = Get.put(TopSearchBarController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      height: Get.height,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey.shade200, boxShadow: [
        BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 4,
            offset: const Offset(1, 2))
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => searchController.isExpanded.value
                  ? const SizedBox()
                  : InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                      ),
                    )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    if (searchController.isExpanded.value) {
                      return AnimatedBuilder(
                        animation: searchController.animation,
                        builder: (context, child) {
                          return Container(
                            width: searchController.animation.value,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextField(
                              maxLines: 1,
                              autofocus: true,
                              minLines: 1,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value) {},
                              smartDashesType: SmartDashesType.enabled,
                              onTapOutside: (_) =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              style: const TextStyle(color: Colors.black87),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Search Here...",
                                hintStyle:
                                    const TextStyle(color: Colors.black54),
                                prefixIcon: const Icon(
                                  Icons.search_rounded,
                                  size: 25,
                                ),
                                suffixIcon: const Icon(
                                  Icons.mic,
                                  size: 25,
                                ),
                                isDense: true,
                                contentPadding: const EdgeInsets.only(
                                  bottom: 5,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                  IconButton(
                    icon: Obx(() => Icon(
                          searchController.isExpanded.value
                              ? Icons.close
                              : Icons.search,
                          color: AppColors.primary,
                        )),
                    onPressed: searchController.toggleSearch,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          const Text.rich(
            style: TextStyle(fontSize: 12),
            TextSpan(
              text: 'Awesome! ',
              children: <TextSpan>[
                TextSpan(
                  text: '8',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: ' results found.'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: Row(
              children: [
                const Text(
                  'Bilaspur',
                  style: TextStyle(
                    fontSize: 14,
                    height: 0,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                    backgroundColor: Colors.blueAccent.withOpacity(0.1),
                    radius: 10,
                    child: Icon(
                      Icons.close,
                      color: AppColors.primary,
                      size: 14,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
