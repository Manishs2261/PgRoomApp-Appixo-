import 'package:flutter/material.dart';
import '../../common/widgets/reuseable_container.dart';
import '../../common/widgets/reuseable_icon.dart';

class FormProcessStep extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final isFormOne, isFormTwo, isFormThree, isFormFour;

  const FormProcessStep({
    super.key,
    this.isFormOne = false,
    this.isFormTwo = false,
    this.isFormThree = false,
    this.isFormFour = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ReusableIcon(
          icon: Icons.check_circle,
          color: isFormOne ? Colors.green : Colors.grey,
        ),
        Expanded(
          child: ReusableContainer(
            color: isFormOne ? Colors.green : Colors.grey,
            height: 2,
            width: double.infinity,
          ),
        ),
        ReusableIcon(
          icon: Icons.check_circle,
          color: isFormTwo ? Colors.green : Colors.grey,
        ),
        Expanded(
          child: ReusableContainer(
            color: isFormTwo ? Colors.green : Colors.grey,
            height: 2,
            width: double.infinity,
          ),
        ),
        ReusableIcon(
          icon: Icons.check_circle,
          color: isFormThree ? Colors.green : Colors.grey,
        ),
        Expanded(
          child: ReusableContainer(
            color: isFormThree ? Colors.green : Colors.grey,
            height: 2,
            width: double.infinity,
          ),
        ),
        ReusableIcon(
          icon: Icons.check_circle,
          color: isFormFour ? Colors.green : Colors.grey,
        ),
      ],
    );
  }
}
