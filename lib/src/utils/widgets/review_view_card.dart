import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Constants/colors.dart';
import '../helpers/helper_function.dart';
import 'com_ratingbar_widgets.dart';

class ReviewViewCardWidgets extends StatelessWidget {
  const ReviewViewCardWidgets({
    super.key,
    required this.imageUrl,
    required this.userName,
    required this.date,
    required this.rating,
    required this.review,
  });

  final String imageUrl;
  final String userName;
  final String date;
  final String rating;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      height: 25,
                      width: 25,
                      fit: BoxFit.cover,
                      imageUrl: "",
                      placeholder: (context, _) => const Center(
                        child: SpinKitFadingCircle(
                          color: AppColors.primary,
                          size: 30,
                        ),
                      ),
                      errorWidget: (context, url, error) => const CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            CupertinoIcons.person,
                            size: 18,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  userName,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Text(
              date,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            ComRatingBarWidgets(
              initialRating: double.parse(rating),
              itemSize: 10.0,
              ignoreGestures: true,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              rating.toString(),
              style: const TextStyle(fontSize: 12, color: Colors.black),
            )
          ],
        ),
        Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            padding: const EdgeInsets.all(10.0),
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppHelperFunction.isDarkMode(context)
                    ? Colors.blueGrey.shade900
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8)),
            child: Text(review)),
      ],
    );
  }
}
