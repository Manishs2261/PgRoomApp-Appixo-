import 'package:flutter/material.dart';

import '../../../../uitels/Constants/image_string.dart';

class HederWidgets extends StatelessWidget {
  const HederWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Image(
          image: AssetImage(
            AppImage.loginImage,
          ),
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
        Text(
          "Login",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          "Welcome Back ",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
