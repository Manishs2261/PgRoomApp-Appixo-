import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pgroom/src/features/sell_and_buy_screen/model/buy_and_sell_model.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

class DetailsOfSellAndBuy extends StatefulWidget {
   DetailsOfSellAndBuy(  {super.key});

  @override
  State<DetailsOfSellAndBuy> createState() => _DetailsOfSellAndBuyState();
}

class _DetailsOfSellAndBuyState extends State<DetailsOfSellAndBuy> {
   final BuyAndSellModel  data = Get.arguments;

  // List of FAQ questions and answers
  final List<Map<String, String>> faqs = [
    {
      'question': 'What is Flutter?',
      'answer':
          'Flutter is an open-source UI software development kit created by Google.',
    },
    {
      'question': 'How to use Flutter?',
      'answer':
          'Flutter can be used to develop applications for Android, iOS, Linux, Mac, Windows, Google Fuchsia, and the web from a single codebase.',
    },
    {
      'question': 'Is Flutter free?',
      'answer': 'Yes, Flutter is free and open source.',
    },
  ];


  RxInt currentPage = 0.obs;

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.info('Build --- DetailsOfSellAndBuy');
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title:  Text(
          '${data.itemName?.capitalizeFirst}',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: Colors.black,
              ))
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 1,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.center,
              width: AppHelperFunction.screenWidth() * 0.4,
              height: 40,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('Chat Now'),
            ),
            Container(
              alignment: Alignment.center,
              height: 40,
              width: AppHelperFunction.screenWidth() * 0.4,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 204, 102, 1.0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Call Now',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 16, top: 16, left: 16, bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: 400, // Set a fixed height for the PageView
                child: Stack(
                  children: [
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.image?.length ?? 0,
                      onPageChanged: (int page) {

                          currentPage.value = page;

                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              imageUrl: data.image![index],
                              placeholder: (context, url) =>
                                  const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 16,
                      right: 4,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child:  Obx(
                          ()=> Text(
                            '${currentPage.value + 1}/ ${data.image?.length}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: false
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.white,
                                  size: 20,
                                )),
                    ),
                  ],
                ),
              ),
              const Text(
                "Joly mess where tapping on a question dfhd fdjkfksf sdfkj  ",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, height: 0),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                "₹200/-",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(
                height: 4,
              ),
               Text(
                " Post Date- ${AppHelperFunction.printFormattedDate(data.atCreate!)}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.black, Colors.blueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/map_icon.png'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Add some spacing between the icon and text
                       Expanded(
                        // Allow the column to take up the remaining space
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Align text to the start
                          children: [
                            Text(
                              '${data.landmark} ${data.address}, ${data.city}, ${data.state}}',
                               style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all()),
                child:  Column(
                  children: [
                    Text(
                      '${data.description}',
                       style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 16,),
              ReportAboutWidgets(),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportAboutWidgets extends StatelessWidget {
  const ReportAboutWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width:double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8)
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Report About Mess',style: TextStyle(color: Colors.white),),
          Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,)
        ],
      ),
    );
  }
}

class FAQTile extends StatelessWidget {
  final String question;
  final String answer;

  const FAQTile({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        color: Colors.grey.withOpacity(0.15),
        elevation: 0,
        child: ExpansionTile(
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.transparent),
          ),
          collapsedShape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.transparent),
          ),
          title: Text(
            question,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                answer,
                style: const TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
