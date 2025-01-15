
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/widgets/shimmer_effect.dart';

import '../helpers/helper_function.dart';
import 'gradient_button.dart';

class UserContactListCardWidgets extends StatelessWidget {
  const UserContactListCardWidgets({
    super.key,
    required this.name,
    required this.contactNumber,
    required this.atUpdate,
    required this.image,
  });

  final String name;
  final String contactNumber;
  final String atUpdate;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: CachedNetworkImage(
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                        imageUrl: image,
                        progressIndicatorBuilder: (context, url, progress) =>
                        const ShimmerEffect(
                            height: 40, width: 40, borderRadius: 24),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${name.capitalizeFirst}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Updated',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      AppHelperFunction.printFormattedDate(atUpdate),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            // Buttons for "Chat Now" and "Call Now"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Chat Now Button with Gradient
                GradientButton(
                  icon: Icons.chat,
                  label: 'Chat Now',
                  colors: [Colors.orange, Colors.red],
                  onPressed: () {
                    // Handle chat action
                  },
                ),
                // Call Now Button with Gradient
                GradientButton(
                  icon: Icons.phone,
                  label: 'Call Now',
                  colors: [Colors.green, Colors.teal],
                  onPressed: () {
                    // Handle call action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}