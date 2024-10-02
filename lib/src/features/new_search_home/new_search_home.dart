import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class NewSearchHome extends StatefulWidget {
  @override
  State<NewSearchHome> createState() => _NewSearchHomeState();
}

class _NewSearchHomeState extends State<NewSearchHome>
    with TickerProviderStateMixin {
  late AnimationController _topRowAnimationController;
  late Animation<Offset> _topRowSlideAnimation;
  late Animation<double> _topRowOpacityAnimation;

  late AnimationController _searchAnimationController;
  late Animation<Offset> _searchSlideAnimation;
  late Animation<double> _searchOpacityAnimation;

  late AnimationController _postAnimationController;
  late Animation<Offset> _postSlideAnimation;
  late Animation<double> _postOpacityAnimation;

  late AnimationController _searchTextFieldAnimationController;
  late Animation<Offset> _searchTextFieldSlideAnimation;
  late Animation<double> _searchTextFieldOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _topRowAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    _topRowSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _topRowAnimationController, curve: Curves.easeOut));

    _topRowOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: _topRowAnimationController, curve: Curves.easeIn));

    _searchAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));

    _searchSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _searchAnimationController, curve: Curves.easeIn));

    _searchOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _searchAnimationController, curve: Curves.easeIn));

    _postAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _postSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _postAnimationController, curve: Curves.easeIn));

    _postOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _postAnimationController, curve: Curves.easeIn));

    _searchTextFieldAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _searchTextFieldSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _searchTextFieldAnimationController, curve: Curves.easeIn));

    _searchTextFieldOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(
            parent: _searchTextFieldAnimationController, curve: Curves.easeIn));

    // Start the animation
    _topRowAnimationController.forward();
    _searchAnimationController.forward();
    _postAnimationController.forward();
    _searchTextFieldAnimationController.forward();
  }

  @override
  void dispose() {
    _topRowAnimationController.dispose();
    _searchAnimationController.dispose();
    _postAnimationController.dispose();
    _searchTextFieldAnimationController.dispose();

    super.dispose();
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF133157),
                        Color(0xFF1A426D),
                        Color(0xFF2A5C99),
                        Colors.white.withOpacity(0.4),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.2,
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
                      SlideTransition(
                        position: _topRowSlideAnimation,
                        child: FadeTransition(
                          opacity: _topRowOpacityAnimation,
                          child: Row(
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
                        ),
                      ),
                      SlideTransition(
                        position: _searchSlideAnimation,
                        child: FadeTransition(
                          opacity: _searchOpacityAnimation,
                          child: Text(
                            'Hello, Searching in!',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.7)),
                          ),
                        ),
                      ),
                      SlideTransition(
                        position: _searchSlideAnimation,
                        child: FadeTransition(
                          opacity: _searchOpacityAnimation,
                          child: Row(
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
                              SizedBox(width: 2),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white.withOpacity(0.6),
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      SlideTransition(
                        position: _postSlideAnimation,
                        child: FadeTransition(
                          opacity: _postOpacityAnimation,
                          child: Align(
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
                                Positioned(
                                  top: -10,
                                  right: 0,
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
                                          color: Colors.white, fontSize: 8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      SlideTransition(
                        position: _searchTextFieldSlideAnimation,
                        child: FadeTransition(
                          opacity: _searchTextFieldOpacityAnimation,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Find what you need—just search here",
                              hintStyle: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: const Icon(
                                Icons.search_rounded,
                                color: Colors.blue,
                                size: 24,
                              ),
                              isDense: true,
                              contentPadding: const EdgeInsets.only(bottom: 5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 1,
                  right: 1,
                  left: 1,
                  child: SlideTransition(
                    position: _searchTextFieldSlideAnimation,
                    child: FadeTransition(
                      opacity: _searchTextFieldOpacityAnimation,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Are you an owner?",
                              style:
                                  TextStyle(color: Colors.white.withOpacity(0.9)),
                            ),
                            Text(
                              " Post for free.",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
