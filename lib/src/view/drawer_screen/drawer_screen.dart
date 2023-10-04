import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../add_your_home/add_your_home.dart';
import '../auth_screen/login_screen/login_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 150,
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  boxShadow: [BoxShadow(
                    blurRadius: 3,
                    blurStyle: BlurStyle.outer,
                    offset: Offset.zero,

                  )]
              ),
              child: Container(
                  padding: EdgeInsets.zero,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(maxRadius: 30,child: Icon(Icons.person,size: 35,),),
                          SizedBox(width: 15,),

                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text("Manish sahu ",
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                  ),
                                ),
                                Flexible(
                                  child: Text("sahusanhu138@gmail.com ",
                                    style: TextStyle(fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,

                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 13,
                            child: Icon(Icons.edit,size: 18,color: Colors.white,),
                          )
                      )
                    ],
                  )
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.login),
            trailing: Icon(Icons.arrow_forward_ios,size: 16,),
            title: const Text('Login'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
              print("login");
              // Update the state of the app.
              // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text('Profile'),
            trailing: Icon(Icons.arrow_forward_ios,size: 16,),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: const Text('Add Your Room'),
            trailing: Icon(Icons.arrow_forward_ios,size: 16,),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddYourHome()));
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}