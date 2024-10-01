import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../../utils/Constants/colors.dart';

class NewSearchHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.white,
      Colors.white,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
        fontSize: 14.0, fontFamily: 'Horizon', fontWeight: FontWeight.w500);

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 500,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF133157),
                      // Dark blue base color
                      Color(0xFF1A426D),
                      // Slightly lighter blue
                      Color(0xFF2A5C99),
                      // Lighter blue
                      Colors.white.withOpacity(0.4),
                      // Highlight for reflective effect
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Opacity(
                opacity: 0.2,
                // Set the desired opacity level (e.g., 0.6 for 60% opacity)
                child: Image(
                  image: AssetImage('assets/images/building.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, right: 16, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/icon_luncher.png"),
                        ),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/icon_luncher.png"),
                        )
                      ],
                    ),
                    Text(
                      'Hello, Searching in!',
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Bilaspur",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white.withOpacity(0.6),
                          size: 18,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: AnimatedTextKit(
                              repeatForever: true,
                              animatedTexts: [
                                ColorizeAnimatedText(
                                  '+ Post Room',
                                  textStyle: colorizeTextStyle,
                                  colors: colorizeColors,
                                ),
                                ColorizeAnimatedText(
                                  '+ Share Food',
                                  textStyle: colorizeTextStyle,
                                  colors: colorizeColors,
                                ),
                                ColorizeAnimatedText(
                                  '+ List Goods',
                                  textStyle: colorizeTextStyle,
                                  colors: colorizeColors,
                                ),
                                ColorizeAnimatedText(
                                  '+ List Services',
                                  textStyle: colorizeTextStyle,
                                  colors: colorizeColors,
                                ),
                              ],
                              isRepeatingAnimation: true,
                              onTap: () {
                                print("Tap Event");
                              },
                            ),
                          ),
                          // Place the FREE label half inside the container and half outside
                          Positioned(
                            top: -10,
                            // Move it slightly upwards to overlap with the container
                            right: 0,
                            // Align to the right
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.red,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(0, 2),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Text(
                                "FREE",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      onTap: () {},
                      autofocus: false,
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        hintText: "Find what you need—just search here",
                        hintStyle: const TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.w400),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppColors.primary,
                          size: 24,
                        ),
                        // suffixIcon: const Icon(Icons.mic),
                        isDense: true,
                        contentPadding: const EdgeInsets.only(bottom: 5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
