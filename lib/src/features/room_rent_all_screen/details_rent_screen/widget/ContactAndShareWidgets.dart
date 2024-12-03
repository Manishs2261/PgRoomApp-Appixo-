import 'package:flutter/material.dart';

 import '../controller/details_screen_controller.dart';
import 'circle_Container_widgets.dart';

class ContactAndShareWidgets extends StatelessWidget {
  const ContactAndShareWidgets({
    super.key,
    required this.controller,
  });

  final DetailsScreenController controller;

  @override
  Widget build(BuildContext context) {


    final Uri url = Uri.parse("https://www.google.com/maps/search/?api=1&query=" + controller.data.latitude.toString() + "," +
        controller.data.longitude.toString());

    Future launchUrl(Uri url) async {
      if (await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return Column(
      children: [
        //===========================================
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //=========share =========
            // CircleContainerWidgets(
            //   title: 'Share',
            //   iconData: Icons.share_outlined,
            //   ontap: () {},
            // ),

            // ==========map view ===========
            CircleContainerWidgets(title: "Map view", iconData: Icons.location_on_outlined, ontap: () => launchUrl(url))
          ],
        ),
      ],
    );
  }
}
