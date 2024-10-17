import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DetailsRoom extends StatefulWidget {
  const DetailsRoom({super.key});

  @override
  State<DetailsRoom> createState() => _DetailsRoomState();
}

class _DetailsRoomState extends State<DetailsRoom> {

  final List<String> roomImages = [
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D',
  ];


  final List<Map<String, dynamic>> roomData = [
    {'type': 'Private room', 'price': 5000},
    {'type': 'Single room', 'price': 1000},
    {'type': 'Double room', 'price': -500},
  ];

  int currentPage = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text('Room name',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,

        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.share,color: Colors.black,))
        ],
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              height: 200,
              width: 400,// Set a fixed height for the PageView
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
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: false ? Icon(Icons.favorite ,color: Colors.red,) :Icon(Icons.favorite_border_outlined,color: Colors.white,)
                    ),
                  ),
                ],
              ),
            ),


           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
             Text("₹ 15,000/-", maxLines: 1,
               overflow: TextOverflow.ellipsis,
               style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
             Container(
               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(4),
                 color: Colors.blueAccent,
               ),
               child: Text(
                 'BOYS',
                 style: TextStyle(color: Colors.white, fontSize: 12),
               ),
             ),
           ],),
            Text("Name of Room",maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
            SizedBox(height: 16,),

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
                    SizedBox(width: 8), // Add some spacing between the icon and text
                    Expanded( // Allow the column to take up the remaining space
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                        children: [
                          Text(
                            'Gour colony yadunandan nager tifra, Bilaspur, Chhattisgarh ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),

                          SizedBox(height: 4,),
                          Text(
                            'View On Map',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16,),

            Text(
              'Overview',
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
                border: Border.all()
              ),
              child: Column(
                children:  roomData.map((room){
                  return   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(room['type']),
                      Text('₹ ${room['price']}/-'),

                    ],
                  );
                }).toList(),
              ),
            )

          ],
        ),
      ),
    );
  }
}
