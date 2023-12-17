import 'package:flutter/material.dart';

 import '../../../../utils/Constants/sizes.dart';
import '../../../../utils/icon_and_name_widgets/Icon_Write_And_Wrong_Widgets.dart';
import '../controller/details_screen_controller.dart';

class AllDetailsWidgets extends StatelessWidget {
  const AllDetailsWidgets({
    super.key,
    required this.controller,
  });

  final DetailsScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              (controller.data.roomAvailable!)
                ?  Text("Available :- ${controller.data.numberOfRooms} Rooms",style: TextStyle(color: Colors.green),)
                : Text("Not Available",style: TextStyle(color: Colors.red),),
          const SizedBox(
            height: AppSizes.sizeBoxSpace * 2,
          ),
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
                  "${controller.data.address}",
                  softWrap: true,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppSizes.sizeBoxSpace * 2,
          ),

          //Rental Room Type
          Row(
            children: [
              Text(
                "Rental Room Type :-",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              (controller.data.bhkType!.isEmpty)
                  ?   Text("  ${controller.data.roomType}")
                  : Text("  ${controller.data.roomType} -  ${controller.data.bhkType}")
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
                if (controller.data.singlePersonPrice != "")
                  IconWriteAndWrongWidgets(
                    title: "Single Person :-  ",
                    price: '${controller.data.singlePersonPrice}/- '
                        'month',
                    isIcon: true,
                  ),
                if (controller.data.doublePersonPrice != "")
                  IconWriteAndWrongWidgets(
                    title: "double Person :-  ",
                    price: '${controller.data.doublePersonPrice}/- '
                        'month',
                    isIcon: true,
                  ),
                if (controller.data.triplePersonPrice != "")
                  IconWriteAndWrongWidgets(
                    title: "triple Person :-  ",
                    price: '${controller.data.triplePersonPrice}/- '
                        'month',
                    isIcon: true,
                  ),
                if (controller.data.fourPersonPrice != "")
                  IconWriteAndWrongWidgets(
                    title: "four Plus Person :-  ",
                    price: '${controller.data.fourPersonPrice}/- '
                        'month',
                    isIcon: true,
                  ),
                if (controller.data.familyPrice != "")
                  IconWriteAndWrongWidgets(
                    title: "Family  :-  ",
                    price: '${controller.data.familyPrice}/- '
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
                isIcon: controller.data.wifi!,
              ),
              IconWriteAndWrongWidgets(
                title: "Fan",
                isIcon: controller.data.fan!,
              ),
              IconWriteAndWrongWidgets(
                title: "Light",
                isIcon: controller.data.light!,
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
                isIcon: controller.data.table!,
              ),
              IconWriteAndWrongWidgets(
                title: "chair",
                isIcon: controller.data.chair!,
              ),
              IconWriteAndWrongWidgets(
                title: "locker",
                isIcon: controller.data.locker!,
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
                isIcon: controller.data.bed!,
              ),
              IconWriteAndWrongWidgets(
                title: "gadda",
                isIcon: controller.data.gadda!,
              ),
              IconWriteAndWrongWidgets(
                title: "bed sheet",
                isIcon: controller.data.bedSheet!,
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
                isIcon: controller.data.parking!,
              ),
              IconWriteAndWrongWidgets(
                title: "Attach \n Bathroom",
                isIcon: controller.data.attachBathRoom!,
              ),
              IconWriteAndWrongWidgets(
                title: "Shareable \n Bathroom",
                isIcon: controller.data.shareAbleBathRoom!,
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
                isIcon: controller.data.electricityBill!,
              ),
              IconWriteAndWrongWidgets(
                title: "water bill",
                isIcon: controller.data.waterBill!,
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
              (controller.data.restrictedTime != '')
                  ? Text(" Restricted - ${controller.data.restrictedTime}")
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
                if (controller.data.girls!)
                  IconWriteAndWrongWidgets(
                    title: "Girl Allow",
                    isIcon: controller.data.girls!,
                  ),
                if (controller.data.boy!)
                  IconWriteAndWrongWidgets(
                    title: "Boy Allow",
                    isIcon: controller.data.boy!,
                  ),
                if (controller.data.familyMember!)
                  IconWriteAndWrongWidgets(
                    title: "family member Allow",
                    isIcon: controller.data.familyMember!,
                  ),
                if (controller.data.cooking!)
                  IconWriteAndWrongWidgets(
                    title: "cooking Allow :-${controller.data.cookingType}",
                    isIcon: controller.data.cooking!,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
