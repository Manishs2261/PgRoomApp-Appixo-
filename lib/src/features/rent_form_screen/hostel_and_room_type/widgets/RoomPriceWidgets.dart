import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../utils/widgets/my_check_box_widget.dart';
import '../../../../utils/widgets/my_text_form_field.dart';
import '../controller/controller.dart';

class RoomPriceWidgets extends StatelessWidget {
  const RoomPriceWidgets({
    super.key,
    required this.hostelController,
  });

  final HostelAndRoomController hostelController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Room Type & Monthly Price :- ",
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        //========for Single Person ============
        Obx(
          () => Row(
            children: [
              MYCheckBoxWidget(
                  title: "Single Person",
                  checkBool: hostelController.checkboxSingle1.value,
                  onChanged: (value) {
                    hostelController.checkboxSingle1.value = value!;
                  }),
              Obx(
                () => Visibility(
                  visible: (hostelController.checkboxSingle1.value),
                  child: Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MyTextFormWedgit(
                      textKeyBoard: TextInputType.number,
                      controller: hostelController.singlePersonController.value,
                      hintText: "Price",
                      lableText: "Price",
                      isCollapsed: true,
                      isDense: true,
                      borderRadius: BorderRadius.circular(11),
                      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    ),
                  )),
                ),
              )
            ],
          ),
        ),

        //====== double person===========
        Obx(
          () => Row(
            children: [
              MYCheckBoxWidget(
                  title: "Double Person",
                  checkBool: hostelController.checkboxDouble2.value,
                  onChanged: (value) {
                    hostelController.checkboxDouble2.value = value!;
                  }),
              Obx(
                () => Visibility(
                  visible: (hostelController.checkboxDouble2.value),
                  child: Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MyTextFormWedgit(
                      textKeyBoard: TextInputType.number,
                      controller: hostelController.doublePersonController.value,
                      hintText: "Price",
                      lableText: "Price",
                      isCollapsed: true,
                      isDense: true,
                      borderRadius: BorderRadius.circular(11),
                      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    ),
                  )),
                ),
              )
            ],
          ),
        ),
        //==========for Triple person ==========
        Obx(
          () => Row(
            children: [
              MYCheckBoxWidget(
                  title: "Triple Person",
                  checkBool: hostelController.checkboxTriple3.value,
                  onChanged: (value) {
                    hostelController.checkboxTriple3.value = value!;
                  }),
              Obx(
                () => Visibility(
                  visible: (hostelController.checkboxTriple3.value),
                  child: Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MyTextFormWedgit(
                      textKeyBoard: TextInputType.number,
                      controller: hostelController.triplePersonController.value,
                      hintText: "Price",
                      lableText: "Price",
                      isCollapsed: true,
                      isDense: true,
                      borderRadius: BorderRadius.circular(11),
                      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    ),
                  )),
                ),
              )
            ],
          ),
        ),
        //======four person room type =========
        Obx(
          () => Row(
            children: [
              MYCheckBoxWidget(
                  title: "Four Person +",
                  checkBool: hostelController.checkboxFour4.value,
                  onChanged: (value) {
                    hostelController.checkboxFour4.value = value!;
                  }),
              Obx(
                () => Visibility(
                  visible: (hostelController.checkboxFour4.value),
                  child: Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MyTextFormWedgit(
                      textKeyBoard: TextInputType.number,
                      controller: hostelController.fourPersonController.value,
                      hintText: "Price",
                      lableText: "Price",
                      isCollapsed: true,
                      isDense: true,
                      borderRadius: BorderRadius.circular(11),
                      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    ),
                  )),
                ),
              )
            ],
          ),
        ),

        //==========family Room ===========
        Obx(
          () => Row(
            children: [
              MYCheckBoxWidget(
                  title: "Family Room / Flat",
                  checkBool: hostelController.checkboxFamilyRoom.value,
                  onChanged: (value) {
                    hostelController.checkboxFamilyRoom.value = value!;
                  }),
              Obx(
                () => Visibility(
                  visible: (hostelController.checkboxFamilyRoom.value),
                  child: Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MyTextFormWedgit(
                        textKeyBoard: TextInputType.number,
                        controller: hostelController.familyPersonController.value,
                        hintText: "Price",
                        lableText: "Price",
                        isCollapsed: true,
                        isDense: true,
                        borderRadius: BorderRadius.circular(11),
                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
