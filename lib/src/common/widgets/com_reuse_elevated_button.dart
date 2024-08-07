import 'package:flutter/material.dart';

import 'package:pgroom/src/utils/Constants/colors.dart';

import '../../utils/helpers/helper_function.dart';

class ComReuseElevButton extends StatelessWidget {
  const ComReuseElevButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.loading = false,
      this.height = 40.0,
      this.width = 0.9});

  final bool loading;
  final Function()? onPressed;
  final String title;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: height,
          alignment: Alignment.center,
          width: AppHelperFunction.screenWidth() * width,
          decoration: BoxDecoration(
            color: AppColors.primary,
            boxShadow: [
              BoxShadow(
                  color: AppColors.primary.withOpacity(.9),
                  offset: const Offset(0, 5))
            ],
            borderRadius: BorderRadius.circular(24),
          ),
          child: (loading)
              ? const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    color: Colors.white,
                  ),
                )
              : Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
        ),
      ),
    );
  }
}
