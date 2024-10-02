import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/new_search_home/new_search_home.dart';
import 'package:pgroom/src/features/room_rent_all_screen/home/Controller/home_page_controller.dart';
import 'package:pgroom/src/features/room_rent_all_screen/home/widgets/ItemListView.dart';
import 'package:pgroom/src/features/room_rent_all_screen/home/widgets/appbar_widgets.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/Constants/image_string.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import '../../../data/repository/apis/apis.dart';
import '../../../model/user_rent_model/user_rent_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UserRentModel> rentList = [];

  var snapData;
  final homeController = Get.put(HomeScreenController());

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("home build : Home Screen");
    return Scaffold(
      //==PreferredSize provide a maximum appbar length
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(155),
        child: Column(
          children: [
            //=======App bar code ====================
            const AppBarWidgets(),
            //========search field code ==============
            Container(
              color: AppColors.primary,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 5,
                ),
                child: TextFormField(
                  onTap: () {
                    // Get.toNamed(RoutesName.searchScreen, arguments: {
                    //   'list': rentList,
                    //   'id': snapData,
                    // });

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NewSearchHome(),
                      ),
                    );
                  },
                  autofocus: false,
                  keyboardType: TextInputType.none,
                  decoration: InputDecoration(
                    fillColor: Colors.yellow[50],
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Enter Locality / Landmark / Colony",
                    hintStyle: const TextStyle(color: Colors.black54),
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: const Icon(Icons.mic),
                    isDense: true,
                    contentPadding: const EdgeInsets.only(bottom: 5),
                  ),
                ),
              ),
            ),
            const Gap(4),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SizedBox(
                height: 42,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(24),
                      splashColor: Colors.grey,
                      onTap: () {
                        setState(() {});
                        homeController.roomsType.value = '';
                      },
                      child: Container(
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: homeController.roomsType.value == ''
                              ? AppColors.primary.withOpacity(.8)
                              : Colors.white,
                          border: Border.all(
                            color: homeController.roomsType.value == ''
                                ? Colors.transparent
                                : AppColors.primary,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Text(
                          "All",
                          style: TextStyle(
                              color: homeController.roomsType.value == ''
                                  ? Colors.white
                                  : AppColors.primary,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    const Gap(12),
                    InkWell(
                      borderRadius: BorderRadius.circular(24),
                      splashColor: Colors.grey,
                      onTap: () {
                        setState(() {});
                        homeController.roomsType.value = 'Girls';
                      },
                      child: Container(
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: homeController.roomsType.value == 'Girls'
                              ? AppColors.primary.withOpacity(.8)
                              : null,
                          border: Border.all(
                              color: homeController.roomsType.value == 'Girls'
                                  ? Colors.transparent
                                  : AppColors.primary),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image: const AssetImage(AppImage.girlsIcon),
                                width: 25,
                                color: homeController.roomsType.value == 'Girls'
                                    ? Colors.white
                                    : AppColors.primary),
                            const Gap(5),
                            Text(
                              "Girls",
                              style: TextStyle(
                                  color:
                                      homeController.roomsType.value == 'Girls'
                                          ? Colors.white
                                          : AppColors.primary,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(12),
                    InkWell(
                      borderRadius: BorderRadius.circular(24),
                      splashColor: Colors.grey,
                      onTap: () {
                        setState(() {});
                        homeController.roomsType.value = 'Boys';
                      },
                      child: Container(
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: homeController.roomsType.value == 'Boys'
                              ? AppColors.primary.withOpacity(.8)
                              : null,
                          border: Border.all(
                            color: homeController.roomsType.value == 'Boys'
                                ? Colors.transparent
                                : AppColors.primary,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image: const AssetImage(AppImage.boysIcon),
                                width: 25,
                                height: 25,
                                color: homeController.roomsType.value == 'Boys'
                                    ? Colors.white
                                    : AppColors.primary),
                            const Gap(5),
                            Text(
                              "Boys",
                              style: TextStyle(
                                  color:
                                      homeController.roomsType.value == 'Boys'
                                          ? Colors.white
                                          : AppColors.primary,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(12),
                    InkWell(
                      borderRadius: BorderRadius.circular(24),
                      splashColor: Colors.grey,
                      onTap: () {
                        setState(() {});
                        homeController.roomsType.value = 'Family';
                      },
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          color: homeController.roomsType.value == 'Family'
                              ? AppColors.primary.withOpacity(.8)
                              : null,
                          border: Border.all(
                            color: homeController.roomsType.value == 'Family'
                                ? Colors.transparent
                                : AppColors.primary,
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.apartment_rounded,
                                color:
                                    homeController.roomsType.value == 'Family'
                                        ? Colors.white
                                        : AppColors.primary),
                            const Gap(4),
                            Text(
                              "Flat/BHK",
                              style: TextStyle(
                                  color:
                                      homeController.roomsType.value == 'Family'
                                          ? Colors.white
                                          : AppColors.primary,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      //======drawer code ===============
      // drawer:  DrawerScreen(),
      //=======list view builder code==============
      body: CustomMaterialIndicator(
        onRefresh: () async {
          return await Future.delayed(const Duration(seconds: 2));
        },
        indicatorBuilder:
            (BuildContext context, IndicatorController controller) {
          return const Icon(
            Icons.refresh,
            color: Colors.blue,
            size: 30,
          );
        },
        child: StreamBuilder(
            stream: ApisClass.firebaseFirestore
                .collection('rentCollection')
                .snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.signal_wifi_connected_no_internet_4),
                        Text("No Internet Connection"),
                        SizedBox(
                          height: 10,
                        ),
                        CircularProgressIndicator(
                          color: Colors.blue,
                        )
                      ],
                    ),
                  );
                case ConnectionState.none:
                  return const Center(
                    child: Row(
                      children: [
                        Icon(Icons.signal_wifi_connected_no_internet_4),
                        Text("No Internet Connection"),
                        CircularProgressIndicator(
                          color: Colors.blue,
                        )
                      ],
                    ),
                  );

                case ConnectionState.active:
                case ConnectionState.done:
                  final data = snapshot.data?.docs;

                  // for creating json model

                  // for(var i in data!)
                  //   {
                  //     log("Data : ${jsonEncode(i.data())}");
                  //   }

                  snapData = snapshot;
                  if (homeController.roomsType.value.isNotEmpty) {
                    rentList = data
                            ?.map((e) => UserRentModel.fromJson(e.data()))
                            .where((element) =>
                                element.roomType ==
                                homeController.roomsType.value)
                            .toList() ??
                        [];
                  } else {
                    rentList = data
                            ?.map((e) => UserRentModel.fromJson(e.data()))
                            .toList() ??
                        [];
                  }

                  return ItemListView(
                    rentList: rentList,
                    snapshot: snapshot,
                  );
              }
            }),
      ),
    );
  }
}
