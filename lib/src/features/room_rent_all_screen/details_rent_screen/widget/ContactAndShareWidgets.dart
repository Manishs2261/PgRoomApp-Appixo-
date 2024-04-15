import 'package:flutter/material.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/data/repository/apis/apis.dart';

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
    return Column(
      children: [

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
