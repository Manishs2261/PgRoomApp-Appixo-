import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../utils/Constants/colors.dart';

class DetailsRoom extends StatefulWidget {
  const DetailsRoom({super.key});

  @override
  State<DetailsRoom> createState() => _DetailsRoomState();
}

class _DetailsRoomState extends State<DetailsRoom> {
  late ScrollController _scrollController;
  double _buttonOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Add scroll listener to update button opacity
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        // User is scrolling down, reduce the button's opacity
        setState(() {
          _buttonOpacity = 0.0;
        });
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        // User is scrolling up, increase the button's opacity
        setState(() {
          _buttonOpacity = 1.0;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 4,
                          offset: Offset(1, 2))
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        Icon(
                          Icons.search_rounded,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text.rich(
                      style: TextStyle(fontSize: 12),
                      TextSpan(
                        text: 'Awesome! ',
                        children: <TextSpan>[
                          TextSpan(
                            text: '8',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ' results found for '),
                          TextSpan(
                            text: 'pg!',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12, bottom: 12),
                      padding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.blue,
                          ),
                          Text(
                            'Add Location',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Row(
                              children: [
                                Text(
                                  'Bilaspur',
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 0,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                CircleAvatar(
                                    backgroundColor:
                                    Colors.blueAccent.withOpacity(0.1),
                                    radius: 8,
                                    child: Icon(
                                      Icons.close,
                                      color: AppColors.primary,
                                      size: 14,
                                    ))
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),

          // Floating button at the bottom center
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: _buttonOpacity,
                child: FloatingActionButton.extended(
                  elevation: 2,
                  backgroundColor: AppColors.primary,
                  onPressed: () {
                    // Add action for the button
                  },
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Column(
                      children: [
                        Icon(Icons.filter_list,color: Colors.white,),
                        Text("Sort",style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    SizedBox(width: 16,),
                    Column(
                      children: [
                        Icon(Icons.filter_alt_outlined,color: Colors.white,),
                        Text("Filter",style: TextStyle(color: Colors.white),)
                      ],
                    )
                  ],)
                
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
