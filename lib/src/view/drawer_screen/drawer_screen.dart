import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';

import '../add_new_home/add_your_home.dart';
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
              decoration:
                  BoxDecoration(color: Colors.blueGrey.shade100, boxShadow: [
                const BoxShadow(
                  blurRadius: 3,
                  blurStyle: BlurStyle.outer,
                  offset: Offset.zero,
                )
              ]),
              child: ApisClass.user.uid == ""
                  ? Padding(
                      padding: const EdgeInsets.only(
                          top: 25, bottom: 25, left: 30, right: 30),
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text("Login")),
                    )
                  : Container(
                      padding: EdgeInsets.zero,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              (ApisClass.user.photoURL == "")
                                  //if user login using email id and password
                                  ? const CircleAvatar(
                                      maxRadius: 30,
                                      child: Icon(
                                        Icons.person,
                                        size: 35,
                                      ),
                                    )

                                  // if user login google email id
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            ApisClass.user.photoURL.toString(),
                                        errorWidget: (context, url, error) =>
                                            const CircleAvatar(
                                                child: Icon(
                                                    CupertinoIcons.person)),
                                      ),
                                    ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // in this condition
                                    (ApisClass.user.displayName == "")
                                        // if user is sign in Email id and password
                                        //than show show first condition
                                        ? Flexible(
                                            child: Text(
                                              "${ApisClass.userName}",
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              maxLines: 1,
                                            ),
                                          )
                                        //if user is sign google email
                                        // than  show second condition
                                        : Flexible(
                                            child: Text(
                                              "${ApisClass.user.displayName}",
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              maxLines: 1,
                                            ),
                                          ),
                                    // in  this email both are same
                                    Flexible(
                                      child: Text(
                                        "${ApisClass.user.email}",
                                        style: const TextStyle(fontSize: 12),
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
                        ],
                      )),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.login),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            title: const Text('Login'),
            onTap: () {
             Get.offAllNamed(RoutesName.loginScreen);

              // Update the state of the app.
              // Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Add Your Room'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddYourHome()));
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
