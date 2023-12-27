import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/repository/apis/apis.dart';
import '../../data/repository/apis/user_apis.dart';
import '../../data/repository/auth_apis/auth_apis.dart';
import '../../model/user_model/user_model.dart';
import '../../res/route_name/routes_name.dart';
import '../../utils/Constants/colors.dart';
import '../../utils/helpers/helper_function.dart';
import '../../utils/logger/logger.dart';
import '../splash/controller/splash_controller.dart';
import '../tiffinServicesScreen/add_your_tiffine_services_screen/add_your_tiffine_services_screen.dart';

class ProfileDetailsScreen extends StatelessWidget {
  ProfileDetailsScreen({super.key});

  List<UserPersonModel> userList = [];

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - ProfileDetailsScreen");
    UserApis.getUserData();
    return Scaffold(
      body: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 150,
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.white30,
                  blurStyle: BlurStyle.outer,
                  offset: Offset.zero,
                )
              ]),
              child: ApisClass.auth.currentUser?.uid != finalUserUidGlobal
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
                      child: StreamBuilder(
                        stream: ApisClass.firebaseFirestore
                            .collection("loginUser")
                            .doc(ApisClass.user.uid)
                            .collection(ApisClass.user.uid)
                            .snapshots(includeMetadataChanges: true),
                        builder: (BuildContext context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return const Center(child: CircularProgressIndicator());

                            case ConnectionState.active:
                            case ConnectionState.done:
                              // TODO: Handle this case.

                              final data = snapshot.data?.docs;

                              userList = data?.map((e) => UserPersonModel.fromJson(e.data())).toList() ?? [];

                              return Stack(
                                children: [
                                  Row(
                                    children: [
                                      (UserApis.userImage == "")
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
                                                imageUrl: userList[0].userImage.toString(),
                                                placeholder: (context, _) => const SpinKitFadingCircle(
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
                                                 "${userList[0].name}",
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                maxLines: 1,
                                                style: const TextStyle(fontSize: 18),
                                              ),
                                            ),

                                            // in  this email both are same
                                            Flexible(
                                              child: Text(
                                                "${ApisClass.auth.currentUser?.email}",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
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
                              );
                          }
                        },
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
            leading: const Icon(Icons.food_bank),
            title: const Text('Add Your Tiffine Services'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () {
              (ApisClass.auth.currentUser?.uid == finalUserUidGlobal)
                  ? Get.to(() => AddYourTiffineServicesScreen())
                  : Get.snackbar("Login", "Your not login ");
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              onTap: () {
                AuthApisClass.checkUserLogin().then((value) {
                  if (value) {
                    Get.toNamed(RoutesName.profileSCreen);
                  }
                });
              }),
          Visibility(
            visible: (ApisClass.auth.currentUser?.uid == finalUserUidGlobal),
            child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onTap: () {
                  AppHelperFunction.showAlert("Logout", "Are you confirming logout?.", () {
                    UserApis.removeUser().then((value) {
                      if (value) {
                        Get.offAllNamed(RoutesName.loginScreen);
                      }
                    });
                  });
                }),
          ),
          Visibility(
            visible: (ApisClass.auth.currentUser?.uid == finalUserUidGlobal),
            child: ListTile(
                leading: const Icon(Icons.delete_outline_sharp),
                title: const Text("Delete Account"),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onTap: () {
                  AppHelperFunction.showAlert("Delete", "Are you confirming the deletion of your account?", () {
                    Navigator.pop(context);
                    UserApis.deleteUserAccount();
                  });
                }),
          ),
        ],
      ),
    );
  }
}
