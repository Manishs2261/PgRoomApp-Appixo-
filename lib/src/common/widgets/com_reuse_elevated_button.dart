import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../utils/helpers/helper_function.dart';

class ComReuseElevButton extends StatelessWidget {
  const ComReuseElevButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.loading = false,
  });

  final bool loading;
  final Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 40,
        width: AppHelperFunction.screenWidth() * 0.9,
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
