import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pgroom/src/features/Home_fitter_new/new_search_home/controller.dart';
import 'package:pgroom/src/features/auth_screen/Model/user_model.dart';
 import 'package:pgroom/src/utils/widgets/shimmer_effect.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/repository/apis/room_collection.dart';
import '../../data/repository/apis/user_collection.dart';
import '../../data/repository/auth_apis/auth_apis.dart';
import '../../model/user_model/user_model.dart';
import '../../res/route_name/routes_name.dart';
import '../../utils/Constants/colors.dart';
import '../../utils/helpers/helper_function.dart';
import '../../utils/logger/logger.dart';
import '../splash/controller/splash_controller.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {

  final homeController = Get.put(HomeController());

  String appVersion = "";

  Future<void> _initPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  final Uri urlFrom = Uri.parse('https://docs.google'
      '.com/forms/d/e/1FAIpQLSfrObbLmPcyPTqE5Ku_Ae2SZneeM7CqWkR0mREaeb24cYNH-Q/viewform?usp=sf_link');

  final Uri urlTermsAndCondition = Uri.parse('https://docs.google'
      '.com/document/d/1saDug8Y6GXYsvlXzFkPlSvBPZ6RTX-iZAPZ5wyYPvEo/edit?usp=sharing');

  final Uri urlPrivacyPolicy =
      Uri.parse('https://docs.google.com/document/d/1NUfUoQwe4rkntC8cg-w0yjlg-Lk39cLMF6KZaCMTLok/edit?usp=sharing');

  Future<void> _launchUrlFrom() async {
    if (!await launchUrl(urlFrom)) {
      throw Exception('Could not launch $urlFrom');
    }
  }

  Future<void> _launchUrlTermsAndCondition() async {
    if (!await launchUrl(urlTermsAndCondition)) {
      throw Exception('Could not launch $urlTermsAndCondition');
    }
  }

  Future<void> _launchUrlPrivacyPolicy() async {
    if (!await launchUrl(urlPrivacyPolicy)) {
      throw Exception('Could not launch $urlPrivacyPolicy');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _initPackageInfo();
    super.initState();
//UserApis.getUserDataNew();
   // UserApis.appShareLink();
  }

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - ProfileDetailsScreen");
    
    return Scaffold(

      body: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.only(top: 16),
        children: [
          SizedBox(
            height: 150,
            width: double.infinity,
            child: DrawerHeader(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.white30,
                  blurStyle: BlurStyle.outer,
                  offset: Offset.zero,
                )
              ]),
              child:Stack(
                children: [
                  Obx(
                  () {
                    if(homeController.user.isEmpty){
                      return  ShimmerEffect(width: Get.width, height: 120);
                    }
                    return Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                imageUrl: homeController.user.first.image ?? '',
                                placeholder: (context, _) =>
                                const SpinKitFadingCircle(
                                  color: AppColors.primary,
                                  size: 35,
                                ),
                                errorWidget: (context, url, error) =>
                                const CircleAvatar(
                                    child: Icon(CupertinoIcons.person)),
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
                                      "${homeController.user.first.name?.capitalizeFirst}",
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      maxLines: 1,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),

                                  // in  this email both are same
                                  Flexible(
                                    child: Text(
                                      "${homeController.user.first.email}",
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
                        );

                      }
                  ),
                ],
              )
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add Your Post'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () {
              (ApisClass.auth.currentUser?.uid == finalUserUidGlobal)
                  ? Get.toNamed(RoutesName.listOfPost)
                  : Get.snackbar("Login", "Your are not login ");
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.remove_red_eye),
            title: const Text('View all post'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: () {
              (ApisClass.auth.currentUser?.uid == finalUserUidGlobal)
                  ? Get.toNamed(RoutesName.editPostList)
                  : Get.snackbar("Login", "Your are not login ");
              // Update the state of the app.
              // ...
            },
          ),
          Divider(
            color: Colors.grey.withOpacity(.3),
          ),
          ListTile(
              leading: const Icon(Icons.person_outline_outlined),
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
          // ListTile(
          //     leading: const Icon(Icons.home_work),
          //     title: const Text("View to Cart Room"),
          //     trailing: const Icon(
          //       Icons.arrow_forward_ios,
          //       size: 16,
          //     ),
          //     onTap: () {
          //       AuthApisClass.checkUserLogin().then((value) {
          //         if (value) {
          //           Get.toNamed(RoutesName.addToCardRoomScreen);
          //         }
          //       });
          //     }),
          // ListTile(
          //     leading: const Icon(Icons.food_bank),
          //     title: const Text("View to Cart Food"),
          //     trailing: const Icon(
          //       Icons.arrow_forward_ios,
          //       size: 16,
          //     ),
          //     onTap: () {
          //       AuthApisClass.checkUserLogin().then((value) {
          //         if (value) {
          //           Get.toNamed(RoutesName.addToCartTiffineScreen);
          //         }
          //       });
          //     }),
          // ListTile(
          //     leading: const Icon(Icons.handshake),
          //     title: const Text("View to Cart Deal"),
          //     trailing: const Icon(
          //       Icons.arrow_forward_ios,
          //       size: 16,
          //     ),
          //     onTap: () {
          //       AuthApisClass.checkUserLogin().then((value) {
          //         if (value) {
          //           Get.toNamed(RoutesName.addToCartGoodsScreen);
          //         }
          //       });
          //     }),
          Divider(
            color: Colors.grey.withOpacity(.3),
          ),
          ListTile(
              leading: const Icon(Icons.share_outlined),
              title: const Text("Share App"),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              onTap: () => Share.share(UserApis.appShareUrl)),
          ListTile(
              leading: const Icon(Icons.help_center_outlined),
              title: const Text("Help"),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              onTap: () => Get.toNamed(RoutesName.helpScreen)),
          ListTile(
              leading: const Icon(Icons.contact_page_outlined),
              title: const Text("Contact Us"),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              onTap: () => Get.toNamed(RoutesName.contactsUs)),
          ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("Privacy And Policy"),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              onTap: () => _launchUrlPrivacyPolicy()),
          ListTile(
              leading: const Icon(Icons.policy_outlined),
              title: const Text("Terms And Condition"),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              onTap: () => _launchUrlTermsAndCondition()),
          Divider(
            color: Colors.grey.withOpacity(.3),
          ),
          ListTile(
              leading: const Icon(
                Icons.report_gmailerrorred,
                color: Colors.red,
              ),
              title: const Text("Report App"),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              onTap: () => _launchUrlFrom()),
          Divider(
            color: Colors.grey.withOpacity(.3),
          ),
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
                  AppHelperFunction.showAlert("Logout", "Are you sure you want to log out?.", () {
                    UserApis.removeUser().then((value) {
                      if (value) {
                        Get.offAllNamed(RoutesName.loginScreen);
                      }
                    });
                  });
                }),
          ),

          const SizedBox(
            height: 40,
          ),
          Center(
              child: Text(
            "version - $appVersion ",
            style: const TextStyle(fontSize: 16),
          )),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
