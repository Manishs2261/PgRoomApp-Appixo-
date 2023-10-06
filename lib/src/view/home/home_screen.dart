import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';
import 'package:pgroom/src/view/add_your_home/add_your_home.dart';
import 'package:pgroom/src/view/details_rent_screen/details_rent_screen.dart';
 import 'package:pgroom/src/view/search/search.dart';

import '../drawer_screen/drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //for like or unlike
  bool like = false;

  @override
  Widget build(BuildContext context) {

    print("home build : +===================");
    return Scaffold(

      //==preferrendSize provide a maximum appbar length
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(115),
          child: SafeArea(
            child: Column(
              children: [

                //=======App bar code ====================
                AppBar(
                  actions: [
                    //===post room free==================
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          width: 135,
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(5),
                              border: Border.all()),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Post Room", textAlign: TextAlign.center),

                              //===========free container =============
                              Container(
                                alignment: Alignment.center,
                                height: 15,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  "Free",
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          )),
                    )
                  ],
                ),

                //========search field code ==============
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()));
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.yellow[50],
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Enter Locality / Landmark / Colony",
                      prefixIcon: Icon(Icons.search_rounded),
                      suffixIcon: Icon(Icons.mic),
                      isDense: false,
                      contentPadding: EdgeInsets.only(
                        bottom: 5,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
      ),

      //======drawer code ===============
      drawer: DrawerScreen(),
      //=======list view builder code==============
      body: ListView.builder(

          padding: EdgeInsets.only(left: 5, right: 5),
          itemCount: 12,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsRentInfoScreen()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(3),
                    height: 200,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(
                             color: Color.fromRGBO(200, 200, 40, 0.01),
                            boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 3,
                      )
                    ]),
                    child: Row(
                      children: [
                        //====== front image========
                        Image(
                          image: AssetImage(roomImage),
                          height: 300,
                          width: 150,
                          fit: BoxFit.cover,
                        ),

                        SizedBox(
                          width: 10,
                        ),
                        // =====Details ============

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  "House Name ",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 17,
                                  ),
                                  Text("4.4"),
                                  Text(" (28 reviews)")
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Rent - ₹',
                                  style: DefaultTextStyle.of(context).style,
                                  children: const <TextSpan>[
                                    TextSpan(
                                        text: '2000',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' /- montly'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Flexible(
                                child: Text(
                                  "Gour colony yadunadan nager tifra, near popur popular shop , Bilaspur ",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text("city - Bilaspur"),
                              Text("Room Type - boys hostel")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //==========like or unlike button ==========

                like == false
                ?
                    Positioned(
                    top: 10,
                    left: 10,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          like = true;
                        });
                      },
                      child: Icon(
                      CupertinoIcons.heart,
                      color: Colors.white,
                      ),
                    ),
                    )
                    :
                      Positioned(
                        top: 10,
                        left: 10,
                        child: InkWell(
                          onTap: (){

                            setState(() {
                              like = false;
                            });
                          },
                          child: Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.white,
                          ),
                        ),
                      ),


              ],
            );
          }),
    );
  }
}
