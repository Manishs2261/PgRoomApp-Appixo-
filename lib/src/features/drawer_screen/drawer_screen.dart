import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pgroom/src/features/profile_screen/profile_screen.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../data/repository/apis/apis.dart';
import '../splash/controller/splash_controller.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build -DrawerScreen ");
    ApisClass.getUserData();

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
                  color: AppHelperFunction.isDarkMode(context) ? null : AppColors.primary,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.white30,
                      blurStyle: BlurStyle.outer,
                      offset: Offset.zero,
                    )
                  ]),
              child: ApisClass.auth.currentUser?.uid == null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 25, left: 30, right: 30),
                      child: ElevatedButton(
                          onPressed: () {
                            Get.offAllNamed(RoutesName.loginScreen);
                          },
                          child: const Text("Login")),
                    )
                  : Container(
                      padding: EdgeInsets.zero,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              (ApisClass.userImage == "")
                                  ? const CircleAvatar(
                                      maxRadius: 30,
                                      child: Icon(
                                        Icons.person,
                                        size: 35,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                        imageUrl: ApisClass.userImage,
                                        placeholder: (context,_)=>SpinKitFadingCircle(
                                          color: AppColors.primary,
                                          size: 35,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const CircleAvatar(child: Icon(CupertinoIcons.person)),
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
                                    Flexible(
                                      child: Text(
                                        "${ApisClass.userName}",
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        maxLines: 1,
                                        style: TextStyle(color: Colors.white, fontSize: 18),
                                      ),
                                    ),

                                    // in  this email both are same
                                    Flexible(
                                      child: Text(
                                        "${ApisClass.auth.currentUser?.email}",
                                        style: const TextStyle(fontSize: 14, color: Colors.white),
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
            leading: const Icon(Icons.home),
            title: const Text('Add Your Room'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () {
              (ApisClass.auth.currentUser?.uid == finalUserUidGlobal)
                  ? Get.toNamed(RoutesName.addYourHomeScreen)
                  : Get.snackbar("Login", "Your not login ");
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text("Profile"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          )
        ],
      ),
    );
  }
}
