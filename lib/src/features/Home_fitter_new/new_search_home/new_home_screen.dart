import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/Home_fitter_new/new_search_home/widgets/category_card_one.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../data/repository/apis/user_apis.dart';
import '../../../res/route_name/routes_name.dart';
import '../../../utils/Constants/image_string.dart';
import '../../../utils/logger/logger.dart';
import '../../../utils/widgets/shimmer_effect.dart';
import '../../auth_screen/Model/user_model.dart';
import 'controller.dart';

class HomeNew extends StatefulWidget {
  const HomeNew({super.key});

  @override
  State<HomeNew> createState() => _HomeNewState();
}

class _HomeNewState extends State<HomeNew> with TickerProviderStateMixin {

  final homeController = Get.put(HomeController());

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
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _searchSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _searchAnimationController, curve: Curves.easeIn));

    _searchOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _searchAnimationController, curve: Curves.easeIn));

    _postAnimationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));

    _postSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _postAnimationController, curve: Curves.easeIn));

    _postOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _postAnimationController, curve: Curves.easeIn));

    _searchTextFieldAnimationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

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

    Future.delayed(Duration.zero, () {
      _autoSlide();
      _autoSlideOne();
    });
  }






  final PageController _controller = PageController();
  final PageController _controllerOne = PageController();

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1470813740244-df37b8c1edcb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fG5hdHVyZXxlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1458668383970-8ddd3927deed?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fG5hdHVyZXxlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fG5hdHVyZXxlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fG5hdHVyZXxlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fG5hdHVyZXxlbnwwfHwwfHx8MA%3D%3D',
  ];

  void _autoSlide() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_controller.hasClients) {
        int nextPage = _controller.page!.round() + 1;
        _controller.animateToPage(
          nextPage % imgList.length,
          // Loop back to the first image after the last one
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _autoSlide(); // Call the function again to continue the auto-slide
      }
    });
  }

  void _autoSlideOne() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_controllerOne.hasClients) {
        int nextPage = _controllerOne.page!.round() + 1;
        _controllerOne.animateToPage(
          nextPage % imgList.length,
          // Loop back to the first image after the last one
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _autoSlideOne(); // Call the function again to continue the auto-slide
      }
    });
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
    AppLoggerHelper.debug("Build - HomeNew...................");
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
                        const Color(0xFF133157),
                        const Color(0xFF1A426D),
                        const Color(0xFF2A5C99),
                        Colors.white.withOpacity(0.4),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                const Opacity(
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
                              const CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/images/icon_luncher.png"),
                              ),

                    Obx(() {
                      if (homeController.user.isEmpty) {
                        return const ShimmerEffect(height: 40, width: 40, borderRadius: 24); // Show a default image or placeholder.
                      }
                      return InkWell(
                        onTap: () => Get.toNamed(RoutesName.profileDetailsScreen),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: CachedNetworkImage(
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                            imageUrl: homeController.user.first.image ?? '',
                            progressIndicatorBuilder: (context, url, progress) =>
                                const ShimmerEffect(height: 40, width: 40, borderRadius: 24),
                            errorWidget: (context, url, error) => const Icon(Icons.person,color: Colors.white,),
                          ),
                        ),
                      );
                    }),

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
                          child: InkWell(
                            onTap: () => Get.toNamed(RoutesName.citySearch),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                              
                                Obx(
                                (){
                                  if(homeController.user.isEmpty){
                                    return  ShimmerEffect(width: 64, height: 20,borderRadius: 4,);
                                  }
                                  return Text(
                                    '${homeController.user.first.city}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  );

                                }
                                ),
                                const SizedBox(width: 2),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white.withOpacity(0.6),
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
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
                                  padding: const EdgeInsets.symmetric(
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
                                    onTap: () =>
                                        Get.toNamed(RoutesName.listOfPost),
                                  ),
                                ),
                                Positioned(
                                  top: -10,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.red,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black54,
                                          offset: Offset(0, 2),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: const Text(
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
                      const SizedBox(height: 24),
                      SlideTransition(
                        position: _searchTextFieldSlideAnimation,
                        child: FadeTransition(
                          opacity: _searchTextFieldOpacityAnimation,
                          child: TextFormField(
                            onTap: () => Get.toNamed(RoutesName.locationSearch),
                            readOnly: true,
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
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: const BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Are you an owner?",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9)),
                            ),
                            InkWell(
                              onTap: () => Get.toNamed(RoutesName.listOfPost),
                              child: const Text(
                                " Post for free.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const Icon(
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
            ImageSlider(controllerOne: _controllerOne, imgList: imgList),
            SizedBox(
              height: 450,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  // 2 Columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    // Room Card
                    CategoryCard(
                      imagePath: AppImage.roomOne,
                      title: 'Rooms',
                      onTap: () => Get.toNamed(RoutesName.listOfRooms),
                    ),
                    // Food Card
                    CategoryCard(
                      imagePath: AppImage.foodOne,
                      title: 'Foods',
                      onTap: () => Get.toNamed(RoutesName.listOfFoods),
                    ),
                    // Services Card
                    CategoryCard(
                      imagePath: AppImage.servicesOne,
                      title: 'Services',
                      onTap: ()=> Get.toNamed(RoutesName.listOfServices),
                    ),
                    // Old Items Card
                    CategoryCard(
                      imagePath: AppImage.sellAndBuyOne,
                      title: 'Old Items',
                      onTap: ()=> Get.toNamed(RoutesName.listOfSellAndBuy),
                    ),
                  ],
                ),
              ),
            ),
            ImageSlider(controllerOne: _controller, imgList: imgList),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'ROOM CATEGORY',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black26,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 450,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  // 2 Columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    // Room Card
                    CategoryCard(
                      imagePath: 'assets/images/boy.png',
                      title: 'Boys',
                      fit:  BoxFit.contain,
                      onTap: () =>Get.toNamed(RoutesName.listOfRooms),
                    ),
                    // Food Card
                    CategoryCard(
                      imagePath: 'assets/images/girl.png',
                      title: 'Girls',
                      fit:  BoxFit.contain,
                      onTap: ()=>Get.toNamed(RoutesName.listOfRooms),
                    ),
                    // Services Card
                    CategoryCard(
                      imagePath: 'assets/images/boyandgirl.png',
                      title: 'Co-Living',
                      fit:  BoxFit.contain,
                      onTap: () =>Get.toNamed(RoutesName.listOfRooms),
                    ),
                    // Old Items Card
                    CategoryCard(
                      imagePath: 'assets/images/flatFamily.png',
                      title: 'Flats',
                      fit:  BoxFit.contain,
                      onTap: () =>Get.toNamed(RoutesName.listOfRooms),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 200,
              width: 100,
              decoration: const BoxDecoration(
                color: Colors.yellow
              ),
            ),
            const GradientCardWidgets(),
          ],
        ),
      ),
    );
  }
}








class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required PageController controllerOne,
    required this.imgList,
  }) : _controllerOne = controllerOne;

  final PageController _controllerOne;
  final List<String> imgList;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: 250,
            child: PageView.builder(
              controller: _controllerOne,
              itemCount: imgList.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imgList[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SmoothPageIndicator(
              controller: _controllerOne,
              count: imgList.length,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.blueAccent,
                dotHeight: 8,
                dotWidth: 8,
                spacing: 8,
              ), // Custom dot effect
            ),
          ),
          // Space between image and dots

          // Bottom space under the dots
        ],
      ),
    );
  }
}

class GradientCardWidgets extends StatelessWidget {
  const GradientCardWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.black, Colors.blueAccent],
          // Unique gradient background
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        // Same as the card for rounded effect
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:[
            const Row(
              children: [
                Image(
                    image: AssetImage('assets/images/sharenow.png'),
                    height: 100),
                SizedBox(width: 15),
                Flexible(
                  // Use Flexible or Expanded to prevent overflow
                  child: Text(
                    'Your friends will love this too—share it now!',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black54,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.visible,
                    // Text will wrap automatically to next line
                    softWrap: true, // Allow wrapping of text
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: ()=>Share.share(UserApis.appShareUrl ?? 'ok'),
              borderRadius: BorderRadius.circular(20),
              splashColor: Colors.white.withOpacity(0.3),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    // Button background
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Share Now',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}




