

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';
import 'package:pgroom/src/view/home/home_screen.dart';
import 'package:pgroom/src/view/on_boarding_screen/controller/on_boarding_controller.dart';
import 'package:pgroom/src/view/on_boarding_screen/widget/on_boarding_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingOneScreen extends StatelessWidget {
  const OnBoardingOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("onBoaurding screen +> build");

    // on boarding controller ==========
    final _onBoaeding = onBoardingConlroller();
    //===============

    return Scaffold(
      body: Stack(
        children: [
          //=======Page view======
          PageView(
            controller: _onBoaeding.pageController,
            onPageChanged: (value) => _onBoaeding.onChange(value),
            children: [
              //========screen one ===============
              onBoardingWidget(
                image: onBoardingOneImage,
                title: 'Welcome',
                color: Colors.blue.shade100,
              ),

              //=============screen two===============
              onBoardingWidget(
                image: onBoardingTwoImage,
                title: 'Hello',
                color: Colors.blueGrey.shade100,
              )
            ],
          ),
          //=============================

          // ========controlller a screen ==========
          Obx(
            () => _onBoaeding.onPageChange.value
            //========start button ========
                ? Container(
                    padding: EdgeInsets.only(bottom: 15),
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          },
                          child: Text(
                            "Start",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  )

            //=========smooth indecater===============
                : Container(
                    padding: EdgeInsets.only(bottom: 15),
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ======for skip the page========
                        //== Empety for maintain center ========
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "",
                          ),
                        ),

                        // =======for smooth indicater use=====

                        SmoothPageIndicator(
                            controller: _onBoaeding.pageController,
                            count: 2),

                        //========== for Next page===========
                        TextButton(
                            onPressed: () => _onBoaeding.Next(),
                            child: Icon(
                              Icons.arrow_forward,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}


