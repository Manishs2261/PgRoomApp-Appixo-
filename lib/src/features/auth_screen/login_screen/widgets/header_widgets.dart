import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../utils/Constants/image_string.dart';

class HederWidgets extends StatelessWidget {
  const HederWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 100,
          width: 220,
          child: Image(
            image: AssetImage(
              AppImage.loginImage,
            ),
          ),
        ),
        const Gap(40),
        Text(
          "Login",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }
}
