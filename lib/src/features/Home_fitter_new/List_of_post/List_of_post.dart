import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../res/route_name/routes_name.dart';

class ListOfPost extends StatefulWidget {
  const ListOfPost({super.key});

  @override
  State<ListOfPost> createState() => _ListOfPostState();
}

class _ListOfPostState extends State<ListOfPost> {
  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - ListOfPost......................................");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            PostCard(
              title: "Room for sharing freely",
              onTap: ()=> Get.toNamed(RoutesName.firstRoomFormScreen),
            ),
            PostCard(
              title: "Post your food here",
              onTap: ()=> Get.toNamed(RoutesName.firstFoodFormScreen),
            ),
            const PostCard(
              title: "Feel free to post items for sale",
            ),
            PostCard(
              title: "Free to advertise local services",
              onTap: ()=> Get.toNamed(RoutesName.firstServiceFormScreen),
            ),
          ],
        ),
      ),
    );
  }
}



class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    this.title, this.onTap,
  });

  final title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      elevation: 2, // High shadow elevation
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(8), // More exaggerated rounded corners
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.black, Colors.blueAccent],
                // Unique gradient background
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
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
              // Padding inside the card
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // Shrinks card to fit content
                children: <Widget>[
                  Row(
                    children: [
                      const Image(
                          image: AssetImage('assets/images/sharenow.png'),
                          height: 80),
                      const SizedBox(width: 16),
                      Flexible(
                        // Use Flexible or Expanded to prevent overflow
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 24,
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
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        onTap: onTap,
                        borderRadius: BorderRadius.circular(20),
                        splashColor: Colors.white.withOpacity(0.3),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            // Button background
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Post Now',
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
