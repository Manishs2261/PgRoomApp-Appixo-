import 'package:flutter/cupertino.dart';

import '../../../../uitels/Constants/image_string.dart';
import '../../../../uitels/Constants/sizes.dart';

class HeaderWidgets extends StatelessWidget {
  const HeaderWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(AppImage.loginImage),
          height: 150,
          width: 150,
          fit: BoxFit.cover,
        ),
        Text(
          "Sing-in",
          style: TextStyle(fontSize: AppSizes.fontSizeMd * 2, fontWeight: FontWeight.w400, letterSpacing: 1),
        ),
      ],
    );
  }
}