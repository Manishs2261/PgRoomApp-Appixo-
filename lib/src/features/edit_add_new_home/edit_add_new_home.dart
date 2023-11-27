import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';

import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/Constants/sizes.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import '../../data/repository/apis/apis.dart';
import '../../model/user_rent_model/user_rent_model.dart';
import '../../utils/Constants/colors.dart';
import '../../utils/helpers/helper_function.dart';
import '../../utils/icon_and_name_widgets/Icon_Write_And_Wrong_Widgets.dart';

class EditAddNewHomeScreen extends StatelessWidget {
  EditAddNewHomeScreen({super.key});

  final itemId = Get.arguments["id"];

  UserRentModel data = Get.arguments['list'];

  final imageUrl = Get.arguments['url'];

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build -EditAddNewHomeScreen ");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details info"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Button
              ComReuseElevButton(
                  onPressed: () => Get.toNamed(RoutesName.editFormScreen, arguments: {
                        'list': data,
                        'id': itemId,
                      }),
                  title: "Edit"),
              const SizedBox(
                height: AppSizes.spaceBtwItems,
              ),

              Center(
                child: SizedBox(
                  height: 40,
                  width: AppHelperFunction.screenWidth() * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      ApisClass.deleteCoverImageData(itemId, imageUrl).then((value) {

                        Navigator.pop(context);
                      });
                    },
                    child: const Text("Delete"),
                  ),
                ),
              ),

              const SizedBox(
                height: 50,
              ),

              Center(
                child: Text(
                  "${data.houseName}",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Image(image: AssetImage(roomImage)),

              //=======Image view======
              SizedBox(
                height: 250,
                width: double.infinity,
                child: CachedNetworkImage(
                    imageUrl: data.coverImage.toString(),
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Container(
                          color: Colors.transparent,
                          height: 100,
                          width: 100,
                          child: const SpinKitFadingCircle(
                            color: AppColors.primary,
                            size: 35,
                          ),
                        ),
                    errorWidget: (context, url, error) => Container(
                          width: 150,
                          height: 280,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.image_outlined,
                            size: 50,
                          ),
                        )),
              ),
              const SizedBox(
                height: 5,
              ),

              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 15)),
                  const Text(
                    "Address :- ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Text(
                      "${data.addres}",
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Padding(padding: EdgeInsets.only(left: 15)),
                  const Text(
                    "Rental Room Type :-",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Text("  ${data.roomType}")
                ],
              ),

              const Padding(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  "Price :-",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Column(
                  children: [
                    if (data.singlePersonPrice != "")
                      IconWriteAndWrongWidgets(
                        title: "Single Person :-  ",
                        price: '${data.singlePersonPrice}/- '
                            'month',
                        isIcon: true,
                      ),
                    if (data.doublePersionPrice != "")
                      IconWriteAndWrongWidgets(
                        title: "double Person :-  ",
                        price: '${data.doublePersionPrice}/- '
                            'month',
                        isIcon: true,
                      ),
                    if (data.triplePersionPrice != "")
                      IconWriteAndWrongWidgets(
                        title: "triple Person :-  ",
                        price: '${data.triplePersionPrice}/- '
                            'month',
                        isIcon: true,
                      ),
                    if (data.fourPersionPrice != "")
                      IconWriteAndWrongWidgets(
                        title: "four Plus Person :-  ",
                        price: '${data.fourPersionPrice}/- '
                            'month',
                        isIcon: true,
                      ),
                    if (data.faimlyPrice != "")
                      IconWriteAndWrongWidgets(
                        title: "family  :-  ",
                        price: '${data.faimlyPrice}/- '
                            'month',
                        isIcon: true,
                      ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  "Services :-",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconWriteAndWrongWidgets(
                    title: "Wi-Fi",
                    isIcon: data.wifi!,
                  ),
                  IconWriteAndWrongWidgets(
                    title: "Fan",
                    isIcon: data.fan!,
                  ),
                  IconWriteAndWrongWidgets(
                    title: "Light",
                    isIcon: data.light!,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconWriteAndWrongWidgets(
                    title: "table",
                    isIcon: data.table!,
                  ),
                  IconWriteAndWrongWidgets(
                    title: "chair",
                    isIcon: data.chair!,
                  ),
                  IconWriteAndWrongWidgets(
                    title: "locker",
                    isIcon: data.locker!,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconWriteAndWrongWidgets(
                    title: "Bed",
                    isIcon: data.bed!,
                  ),
                  IconWriteAndWrongWidgets(
                    title: "gadda",
                    isIcon: data.gadda!,
                  ),
                  IconWriteAndWrongWidgets(
                    title: "bed sheet",
                    isIcon: data.bedSheet!,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconWriteAndWrongWidgets(
                    title: "parking",
                    isIcon: data.parking!,
                  ),
                  IconWriteAndWrongWidgets(
                    title: "bathroom \n attach",
                    isIcon: false,
                  ),
                  IconWriteAndWrongWidgets(
                    title: "bathroom \n shareable",
                    isIcon: false,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  "Bills & charges:-",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconWriteAndWrongWidgets(
                    title: "Electricity bill",
                    isIcon: data.electricityBill!,
                  ),
                  IconWriteAndWrongWidgets(
                    title: "water bill",
                    isIcon: data.waterBill!,
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Row(
                  children: [
                    const Text(
                      "Time :-  ",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    (data.restrictedTime != '') ? Text(" Restricted - ${data.restrictedTime}") : const Text("flexible"),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  "Permission:-",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, top: 15),
                child: Column(
                  children: [
                    if (data.girls!)
                      IconWriteAndWrongWidgets(
                        title: "Girl Allow",
                        isIcon: data.girls!,
                      ),
                    if (data.boy!)
                      IconWriteAndWrongWidgets(
                        title: "Boy Allow",
                        isIcon: data.boy!,
                      ),
                    if (data.faimlyMember!)
                      IconWriteAndWrongWidgets(
                        title: "family member Allow",
                        isIcon: data.faimlyMember!,
                      ),
                    if (data.cooking!)
                      IconWriteAndWrongWidgets(
                        title: "cooking Allow :-  ${data.cookingType}",
                        isIcon: data.cooking!,
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
