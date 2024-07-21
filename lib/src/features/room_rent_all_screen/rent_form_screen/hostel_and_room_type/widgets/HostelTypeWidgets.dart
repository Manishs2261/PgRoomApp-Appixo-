import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

 import '../../../../../utils/widgets/flat_radio_button_wedget.dart';
import '../../../../../utils/widgets/hostel_radio_button_widget.dart';
import '../controller/controller.dart';

class HostelTypeWidgets extends StatelessWidget {
  const HostelTypeWidgets({
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
          "Hostel Type :- ",
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        // ======boys hostel =====
        Obx(
          () => MyHostelRadioButtonWidget(
              title: "Boys Hostel",
              value: HostelTypeEnum.boysH,
              hostelTypeEnum: hostelController.hostelTypeEnum.value,
              onChange: (value) {
                hostelController.boysHostelConditions(value);
              }),
        ),

        // ======Girls hostel =====
        Obx(
          () => MyHostelRadioButtonWidget(
              title: "Girls Hostel",
              value: HostelTypeEnum.girlsH,
              hostelTypeEnum: hostelController.hostelTypeEnum.value,
              onChange: (value) {
                hostelController.girlsHostelConditions(value);
              }),
        ),

        // ======Flat Room =====
        Obx(
          () => MyHostelRadioButtonWidget(
              title: "Flat",
              value: HostelTypeEnum.family,
              hostelTypeEnum: hostelController.hostelTypeEnum.value,
              onChange: (value) {
                hostelController.flatTypeConditions(value);
              }),
        ),

        Obx(
          () => Visibility(
            visible: (hostelController.isBool.value),
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Column(
                children: [
                  // ==========check a flat  condition==========

                  Obx(
                    () => MyFlatRadioButtonWidget(
                        title: "1BHK",
                        value: FlatTypeEnum.oneBhk,
                        flatTypeEnum: hostelController.flatTypeEnum.value,
                        onChange: (value) {
                          hostelController.oneBhkCondition(value);
                        }),
                  ),

                  Obx(
                    () => MyFlatRadioButtonWidget(
                        title: "2BHK",
                        value: FlatTypeEnum.twoBhk,
                        flatTypeEnum: hostelController.flatTypeEnum.value,
                        onChange: (value) {
                          hostelController.twoBhkCondition(value);
                        }),
                  ),

                  Obx(
                    () => MyFlatRadioButtonWidget(
                        title: "3BHK",
                        value: FlatTypeEnum.threeBhk,
                        flatTypeEnum: hostelController.flatTypeEnum.value,
                        onChange: (value) {
                          hostelController.threeBhkCondition(value);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
