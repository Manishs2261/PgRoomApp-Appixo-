

import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';
import 'package:pgroom/src/view/add_your_home/add_your_home.dart';
import 'package:pgroom/src/view/auth_screen/login_screen/login_screen.dart';
import 'package:pgroom/src/view/details_rent_screen/details_rent_screen.dart';
 import 'package:pgroom/src/view/search/search.dart';

import '../../model/user_rent_model/user_rent_model.dart';
import '../drawer_screen/drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List< UserRentModel>rentList = [];


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

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
        print("user : ${ApisClass.user}");

          await FirebaseAuth.instance.signOut();
          await GoogleSignIn().signOut();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
        },
      ),

      //======drawer code ===============
      drawer: DrawerScreen(),
      //=======list view builder code==============
      body: StreamBuilder(

        stream: ApisClass.firestore.collection('rentCollection').snapshots(),
        // stream: ApisClass.firestore.collection('rentUser').doc
        //   ("s30wXWQIDuPPzjrNmf7Q").collection('permission').snapshots(),

        builder: (context, snapshot) {

          switch(snapshot.connectionState){

            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator(),);
            case ConnectionState.active:
            case ConnectionState.done:

              final data = snapshot.data?.docs;

              // for(var i in data!)
              //   {
              //     log("Data : ${jsonEncode(i.data())}");
              //   }

              rentList = data?.map((e) => UserRentModel.fromJson(e.data())).toList()
          ?? [];



            return ListView.builder(

                padding: EdgeInsets.only(left: 5, right: 5),
                itemCount: rentList.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: (){
                        print(snapshot.data?.docs[index].id);

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
                              CachedNetworkImage(
                                width: 150,
                                height: 300,

                                imageUrl: '${rentList[index].coverImage}',
                                fit: BoxFit.fill,
                                // placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => CircleAvatar(
                                  child: Icon(Icons.image_outlined),
                                ),
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
                                        "${rentList[index].houseName} ",
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
                                        Text("${rentList[index].review}"),
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
                                        children:  <TextSpan>[
                                          TextSpan(
                                              text: '${rentList[index].singlePersonPrice}',
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
                                        "${rentList[index].addres} ",
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text("city - ${rentList[index].city}"),
                                    Text("Room Type - ${rentList[index].roomType}")
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
                });

          }


        }
      ),
    );
  }
}
