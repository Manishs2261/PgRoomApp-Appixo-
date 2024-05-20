import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
          Text(
            "${controller.data.houseName}",
            style: Theme.of(context).textTheme.titleLarge,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            softWrap: false,
          ),
          const Gap(10),

          (controller.data.roomAvailable!)
              ? Text(
                  "Available :- ${controller.data.numberOfRooms} Rooms",
                  style: const TextStyle(color: Colors.green),
                )
              : const Text(
                  "Not Available",
                  style: TextStyle(color: Colors.red),
                ),
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
                  ? Text("  ${controller.data.roomType}")
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
                        'Month',
                    isIcon: true,
                  ),
                if (controller.data.doublePersonPrice != "")
                  IconWriteAndWrongWidgets(
                    title: "Double Person :-  ",
                    price: '${controller.data.doublePersonPrice}/- '
                        'Month',
                    isIcon: true,
                  ),
                if (controller.data.triplePersonPrice != "")
                  IconWriteAndWrongWidgets(
                    title: "Triple Person :-  ",
                    price: '${controller.data.triplePersonPrice}/- '
                        'Month',
                    isIcon: true,
                  ),
                if (controller.data.fourPersonPrice != "")
                  IconWriteAndWrongWidgets(
                    title: "Four Plus Person :-  ",
                    price: '${controller.data.fourPersonPrice}/- '
                        'Month',
                    isIcon: true,
                  ),
                if (controller.data.familyPrice != "")
                  IconWriteAndWrongWidgets(
                    title: "Family  :-  ",
                    price: '${controller.data.familyPrice}/- '
                        'Month',
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              IconWriteAndWrongWidgets(
                title: "Wi-Fi",
                isIcon: controller.data.wifi!,
              ),
              const SizedBox(
                width: 30,
              ),
              IconWriteAndWrongWidgets(
                title: "Fan",
                isIcon: controller.data.fan!,
              ),
              const SizedBox(
                width: 45,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              IconWriteAndWrongWidgets(
                title: "Table",
                isIcon: controller.data.table!,
              ),
              const SizedBox(
                width: 30,
              ),
              IconWriteAndWrongWidgets(
                title: "Chair",
                isIcon: controller.data.chair!,
              ),
              const SizedBox(
                width: 38,
              ),
              IconWriteAndWrongWidgets(
                title: "Locker",
                isIcon: controller.data.locker!,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              IconWriteAndWrongWidgets(
                title: "Bed",
                isIcon: controller.data.bed!,
              ),
              const SizedBox(
                width: 37,
              ),
              IconWriteAndWrongWidgets(
                title: "gadda",
                isIcon: controller.data.gadda!,
              ),
              const SizedBox(
                width: 32,
              ),
              IconWriteAndWrongWidgets(
                title: "Bed sheet",
                isIcon: controller.data.bedSheet!,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              IconWriteAndWrongWidgets(
                title: "Parking",
                isIcon: controller.data.parking!,
              ),
              const SizedBox(
                width: 17,
              ),
              IconWriteAndWrongWidgets(
                title: "Attach \n Bathroom",
                isIcon: controller.data.attachBathRoom!,
              ),
              const SizedBox(
                width: 5,
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
                title: "Water bill",
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
                    title: "Family member Allow",
                    isIcon: controller.data.familyMember!,
                  ),
                if (controller.data.cooking!)
                  IconWriteAndWrongWidgets(
                    title: "Cooking Allow :-${controller.data.cookingType}",
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
