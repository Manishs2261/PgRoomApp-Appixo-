import 'package:flutter/material.dart';

import '../../utils/helpers/helper_function.dart';

class ComReuseElevButton extends StatelessWidget {
  const ComReuseElevButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

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
          child: Text(title),
        ),
      ),
    );
  }
}
