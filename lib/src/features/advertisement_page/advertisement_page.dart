import 'package:flutter/material.dart';

class AdvertisementPageScreen extends StatelessWidget {
  const AdvertisementPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pg Room "),),
      body: Padding(
        padding: const EdgeInsets.only(left: 5,right: 5,top: 5),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(10)
              ),
            )
          ],
        ),
      ),
    );
  }
}
