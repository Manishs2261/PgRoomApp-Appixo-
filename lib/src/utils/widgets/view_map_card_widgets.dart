import 'package:flutter/material.dart';

import '../../features/Rooms_screen_new/details_rooms/controller/details_room_controller.dart';
import '../Constants/image_string.dart';
import '../helpers/helper_function.dart';

class ViewMapCardWidgets extends StatelessWidget {
  const ViewMapCardWidgets({
    super.key,
    required this.controller,
  });

  final DetailsRoomController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.black, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImage.mapIcon),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Add some spacing between the icon and text
            Expanded(
              // Allow the column to take up the remaining space
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Align text to the start
                children: [
                  Text(
                    '${controller.data.landmark}, ${controller.data.homeAddress}, ${controller.data.city}, ${controller.data.state}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  InkWell(
                    onTap: () => AppHelperFunction.launchMap(
                        double.parse(controller.data.latitude!),
                        double.parse(controller.data.longitude!)),
                    child: const Text(
                      'View On Map',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
