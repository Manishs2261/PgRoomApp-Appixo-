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
              //Edit button
              ComReuseElevButton(
                  onPressed: () => Get.toNamed(RoutesName.editFormScreen, arguments: {
                        'list': data,
                        'id': itemId,
                      }),
                  title: "Edit"),
              const SizedBox(
                height: AppSizes.spaceBtwItems,
              ),

              //Delete data button
              ComReuseElevButton(
                  onPressed: () {
                    AppHelperFunction.showAlert("Delete", "Aru you sure delete this room.", () {
                      AppHelperFunction.showDialogCenter(false);

                      ApisClass.deleteCoverImageData(itemId, imageUrl).then((value) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    });
                  },
                  title: "Delete"),

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
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // House Address
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // house Address=====
                        Text(
                          "Address :- ",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Expanded(
                          child: Text(
                            "${data.address}",
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppSizes.sizeBoxSpace * 2,
                    ),

                    // Contact number
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // house Address=====
                        Text(
                          "Contact number :- ",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Expanded(
                          child: Text(
                            "${data.contactNumber}",
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppSizes.sizeBoxSpace * 2,
                    ),


                    //  Rental Room Type
                    Row(
                      children: [
                        Text(
                          "Rental Room Type :-",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        (data.bhkType!.isEmpty)
                        ?   Text("  ${data.roomType}")
                         : Text("  ${data.roomType} -  ${data.bhkType}")
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //Price
                    Text(
                      "Price :-",
                      style: Theme.of(context).textTheme.headlineSmall,
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
                          if (data.doublePersonPrice != "")
                            IconWriteAndWrongWidgets(
                              title: "double Person :-  ",
                              price: '${data.doublePersonPrice}/- '
                                  'month',
                              isIcon: true,
                            ),
                          if (data.triplePersonPrice != "")
                            IconWriteAndWrongWidgets(
                              title: "triple Person :-  ",
                              price: '${data.triplePersonPrice}/- '
                                  'month',
                              isIcon: true,
                            ),
                          if (data.fourPersonPrice != "")
                            IconWriteAndWrongWidgets(
                              title: "four Plus Person :-  ",
                              price: '${data.fourPersonPrice}/- '
                                  'month',
                              isIcon: true,
                            ),
                          if (data.familyPrice != "")
                            IconWriteAndWrongWidgets(
                              title: "Family  :-  ",
                              price: '${data.familyPrice}/- '
                                  'month',
                              isIcon: true,
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    // Room services
                    Text(
                      "Services :-",
                      style: Theme.of(context).textTheme.headlineSmall,
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
                          title: "Attach \n Bathroom",
                          isIcon: data.attachBathRoom!,
                        ),
                        IconWriteAndWrongWidgets(
                          title: "Shareable \n Bathroom",
                          isIcon: data.shareAbleBathRoom!,
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Bills & charges:-",
                      style: Theme.of(context).textTheme.headlineSmall,
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

                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Time :-  ",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        (data.restrictedTime != '')
                            ? Text(" Restricted - ${data.restrictedTime}")
                            : const Text("Flexible"),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Permission:-",
                      style: Theme.of(context).textTheme.headlineSmall,
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
                          if (data.familyMember!)
                            IconWriteAndWrongWidgets(
                              title: "family member Allow",
                              isIcon: data.familyMember!,
                            ),
                          if (data.cooking!)
                            IconWriteAndWrongWidgets(
                              title: "cooking Allow :-${data.cookingType}",
                              isIcon: data.cooking!,
                            ),
                        ],
                      ),
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
