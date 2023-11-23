import 'package:flutter/material.dart';

import '../../../uitels/helpers/heiper_function.dart';
import 'circle_Container_widgets.dart';

class ContactAndShareWidgets extends StatelessWidget {
  const ContactAndShareWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SizedBox(
            height: 40,
            width: AppHelperFunction.screenWidth() * 0.9,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("contact now"),
            ),
          ),
        ),

        const SizedBox(
          height: 50,
        ),

        //===========================================
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //=========share =========
            CircleContainerWidgets(
              title: 'Share',
              iconData: Icons.share_outlined,
              ontap: () {},
            ),

            // ==========map view ===========
            CircleContainerWidgets(title: "Map view", iconData: Icons.location_on_outlined, ontap: () {})
          ],
        ),
      ],
    );
  }
}