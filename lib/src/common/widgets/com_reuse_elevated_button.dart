import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../utils/helpers/helper_function.dart';

class ComReuseElevButton extends StatelessWidget {
   ComReuseElevButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.loading = false,
    this.height = 40.0,
    this.width = 0.9
  });

  final bool loading;
  final Function()? onPressed;
  final String title;
   double width;
   double height;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: AppHelperFunction.screenWidth() * width,
        child: ElevatedButton(

          onPressed: onPressed,
          child:  (loading)
                ? const CircularProgressIndicator(
              strokeWidth: 3.0,
            )
                : Text(title),

        ),
      ),
    );
  }
}
