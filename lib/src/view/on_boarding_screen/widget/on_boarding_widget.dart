import 'package:flutter/cupertino.dart';

class onBoardingWidget extends StatelessWidget {
  onBoardingWidget({
    super.key,
    required this.image,
    required this.title,
    required this.color,
  });

  final String image;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(image),
            height: 300,
            width: 300,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}