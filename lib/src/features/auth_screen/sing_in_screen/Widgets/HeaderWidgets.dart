// ignore: file_names
// ignore: file_names
// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

import '../../../../utils/Constants/image_string.dart';
import '../../../../utils/Constants/sizes.dart';

class HeaderWidgets extends StatelessWidget {
  const HeaderWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 100,
          width: 220,
          child: Image(
            image: AssetImage(
              AppImage.loginImage,
            ),
          ),
        ),
        Gap(60),
        Text(
          "Sign-up",
          style: TextStyle(fontSize: AppSizes.fontSizeMd * 2, fontWeight: FontWeight.w400, letterSpacing: 1),
        ),
      ],
    );
  }
}
