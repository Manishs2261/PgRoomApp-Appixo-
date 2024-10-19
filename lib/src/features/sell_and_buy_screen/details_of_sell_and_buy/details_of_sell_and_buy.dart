import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

class DetailsOfSellAndBuy extends StatefulWidget {
  const DetailsOfSellAndBuy({super.key});

  @override
  State<DetailsOfSellAndBuy> createState() => _DetailsOfSellAndBuyState();
}

class _DetailsOfSellAndBuyState extends State<DetailsOfSellAndBuy> {
  final List<String> roomImages = [
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
  ];
  final List<String> items = [
    "AC",
    "COOLER",
    "FAN",
    "TABLE",
    "BED",
    "CHAIR",
    "FRIDGE",
    "LIGHT",
    "WASHING MACHINE",
    "BED SHEET",
    "GIGER",
    "ALMARI",
    "LOCKER"
  ];

  final List<String> billItem = ['ELECTRICITY BILL', 'WATER BILL'];

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

  final List<String> rules = [
    "Available for Students & Working Professionals Available for Students & Working Professionals",
    "Non veg food is allowed",
    "Smoking is allowed",
    "Drinking is allowed",
    "Guardian is allowed",
    "Visitors are allowed",
    "Guests of opposite gender are allowed"
  ];

  final List<Map<String, dynamic>> roomData = [
    {'type': 'Breakfast', 'price': 800},
    {'type': 'Lunch OR Dinner', 'price': 1300},
    {'type': 'Lunch AND Dinner', 'price': 2300},
    {
      'type': 'Breakfast,Lunch AND Dinner Breakfast,Lunch AND Dinner',
      'price': 3100
    },
  ];

  final List<Map<String, dynamic>> dailyFoods = [
    {'type': 'Rice', 'price': 30},
    {'type': 'Roti Per Pice', 'price': 7},
    {'type': 'Sabji', 'price': 40},
    {'type': 'dal', 'price': 30},
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'TAble name',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share,
                color: Colors.black,
              ))
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: Offset(0, 1),
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
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('Chat Now'),
            ),
            Container(
              alignment: Alignment.center,
              height: 40,
              width: AppHelperFunction.screenWidth() * 0.4,
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 204, 102, 1.0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
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
                      itemCount: roomImages.length,
                      onPageChanged: (int page) {
                        setState(() {
                          currentPage = page;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              imageUrl: roomImages[index],
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
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
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          '${currentPage + 1}/ ${roomImages.length}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: false
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.white,
                                  size: 20,
                                )),
                    ),
                  ],
                ),
              ),
              Text(
                "Joly mess where tapping on a question dfhd fdjkfksf sdfkj  ",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, height: 0),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "₹200/-",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
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
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/map_icon.png'),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      // Add some spacing between the icon and text
                      Expanded(
                        // Allow the column to take up the remaining space
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Align text to the start
                          children: [
                            Text(
                              'Gour colony yadunandan nager tifra, Bilaspur, Chhattisgarh ',
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
              SizedBox(
                height: 16,
              ),
              Text(
                'Discription',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all()),
                child: Column(
                  children: [
                    Text(
                      'about computer tter, TextFormField is a widget that allows users to input text in forms. It has several types of configurations to handle different types of input, including text, numbers, email, and passwords. You can control the type of input using the keyboardType and obscureText properties.',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
