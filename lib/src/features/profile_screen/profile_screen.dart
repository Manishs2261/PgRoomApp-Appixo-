import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pgroom/src/data/repository/apis/apis.dart';
import 'package:pgroom/src/features/profile_screen/contorller/profile_controller.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/Constants/image_string.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

import '../../model/user_model/user_model.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.put(ProfileController());
  List<UserPersonModel>userList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: CustomMaterialIndicator(
          onRefresh: () async {

            return await Future.delayed(Duration(seconds: 2));

          },
          indicatorBuilder: (BuildContext context, IndicatorController controller) {
            return Icon(
              Icons.refresh,
              color: Colors.blue,
              size: 30,
            );
          },

          child: StreamBuilder(
            stream: ApisClass.firebaseFirestore
                .collection("loginUser")
                .doc(ApisClass.user.uid)
                .collection(ApisClass.user.uid)
                .snapshots(includeMetadataChanges: true),
            builder: (BuildContext context,  snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Center(child: CircularProgressIndicator());

                case ConnectionState.active:
                case ConnectionState.done:
                  // TODO: Handle this case.

                final data = snapshot.data?.docs;

                userList = data?.map((e) => UserPersonModel.fromJson(e.data())).toList() ?? [];

                  return   ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {

                                  Get.toNamed(RoutesName.editPofileScreen);
                                },
                                child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(color: AppColors.primary, width: 2)),
                                    child: Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: AppColors.primary,
                                    )),
                              ),
                            ),
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(360),
                                    child: CachedNetworkImage(
                                        height: 200,
                                        width: 200,
                                        imageUrl: userList[0].userImage.toString(),
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) => Container(
                                          color: Colors.transparent,
                                          height: 200,
                                          width: 200,
                                          child: const SpinKitFadingCircle(
                                            color: AppColors.primary,
                                            size: 35,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => Container(
                                          width: 200,
                                          height: 200,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50), color: Colors.grey),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.person,
                                            size: 100,
                                          ),
                                        )),
                                  ),
                                ),
                                Positioned(
                                    bottom: 5,
                                    right: 100,
                                    child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (_) {
                                              return ListView(
                                                shrinkWrap: true,
                                                padding: EdgeInsets.only(bottom: Get.width * 0.1),
                                                children: [
                                                  //pick profile picture label
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      InkWell(
                                                        child: CircleAvatar(
                                                          child: Icon(
                                                            Icons.image,
                                                            size: 40,
                                                          ),
                                                          radius: 40,
                                                        ),
                                                        onTap: () {
                                                          controller.pickImageFromGallery(ImageSource.gallery);
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                      InkWell(
                                                        child: CircleAvatar(
                                                          child: Icon(
                                                            Icons.camera_alt,
                                                            size: 40,
                                                          ),
                                                          radius: 40,
                                                        ),
                                                        onTap: () {
                                                          controller.pickImageFromGallery(ImageSource.camera);
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(50),
                                              border: Border.all(color: AppColors.primary, width: 2)),
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: AppColors.primary,
                                          )),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            ProfileTextFormWidgets(
                              name: 'Name',
                              icon: Icons.person,
                              initialValue: userList[0].name,
                            ),
                            ProfileTextFormWidgets(
                              name: 'Email',
                              icon: Icons.email,
                              initialValue: userList[0].email,
                            ),
                            ProfileTextFormWidgets(
                              name: 'City',
                              icon: Icons.location_city,
                              initialValue: userList[0].city,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
              }
            },
          )),
    ));
  }
}

class ProfileTextFormWidgets extends StatelessWidget {
  ProfileTextFormWidgets({
    super.key,
    required this.name,
    required this.icon,
    this.initialValue,
  });

  String name;
  IconData icon;
  String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          TextFormField(
            initialValue: initialValue,
            readOnly: true,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              prefixIcon: Icon(icon),
            ),
          )
        ],
      ),
    );
  }
}
