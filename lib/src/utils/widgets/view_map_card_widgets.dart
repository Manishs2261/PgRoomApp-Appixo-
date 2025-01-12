import 'package:flutter/material.dart';

import '../Constants/image_string.dart';
import '../helpers/helper_function.dart';

class ViewMapCardWidgets extends StatelessWidget {
  const ViewMapCardWidgets({
    super.key,
    required this.landmark,
    required this.homeAddress,
    required this.city,
    required this.state,
    this.latitude = '',
    this.longitude = '',
  });

  final String landmark;
  final String homeAddress;
  final String city;
  final String state;
  final String latitude;
  final String longitude;

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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$landmark, $homeAddress, $city, $state',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  if(longitude.isNotEmpty)
                  InkWell(
                    onTap: () => AppHelperFunction.launchMap(
                        double.parse(latitude), double.parse(longitude)),
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
