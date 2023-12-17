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
              titel: "Boys Hostel",
              value: HostelTypeEnum.BoysH,
              hostelTypeEnum: hostelController.hostelTypeEnum.value,
              onChange: (value) {
                hostelController.boysHostelConditions(value);
              }),
        ),

        // ======Girls hostel =====
        Obx(
          () => MyHostelRadioButtonWidget(
              titel: "Girls Hostel",
              value: HostelTypeEnum.GirlsH,
              hostelTypeEnum: hostelController.hostelTypeEnum.value,
              onChange: (value) {
                hostelController.girlsHostelConditions(value);
              }),
        ),

        // ======Flat Room =====
        Obx(
          () => MyHostelRadioButtonWidget(
              titel: "Flat",
              value: HostelTypeEnum.Faimaly,
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
                        titel: "1BHK",
                        value: FaltTypeEnum.OneBhk,
                        flatTypeEnum: hostelController.flatTypeEnum.value,
                        onChange: (value) {
                          hostelController.oneBhkCondition(value);
                        }),
                  ),

                  Obx(
                    () => MyFlatRadioButtonWidget(
                        titel: "2BHK",
                        value: FaltTypeEnum.TwoBhk,
                        flatTypeEnum: hostelController.flatTypeEnum.value,
                        onChange: (value) {
                          hostelController.twoBhkCondition(value);
                        }),
                  ),

                  Obx(
                    () => MyFlatRadioButtonWidget(
                        titel: "3BHK",
                        value: FaltTypeEnum.ThreeBhk,
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
