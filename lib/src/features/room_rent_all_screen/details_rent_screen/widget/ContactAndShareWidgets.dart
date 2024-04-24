import 'package:flutter/material.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/data/repository/apis/apis.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/helpers/helper_function.dart';
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

    Future<void> _launchUrl() async {
      if (!await launchUrl(url)) {
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
            CircleContainerWidgets(title: "Map view", iconData: Icons.location_on_outlined, ontap: () => _launchUrl())
          ],
        ),
      ],
    );
  }
}
