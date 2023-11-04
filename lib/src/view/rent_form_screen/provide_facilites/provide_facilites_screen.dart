
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/view/rent_form_screen/provide_facilites/controller/controller.dart';
import 'package:pgroom/src/uitels/widgets/my_check_boxwidget.dart';


class ProvideFacilitesScreen extends StatelessWidget {
  ProvideFacilitesScreen({super.key});

  final controller = Get.put(ProvideFacilitesController());

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("builed => provider facilites screen 🍎");
    }
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 15, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Provide a Facilities :- ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              //======for Wi-fi==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Wi-Fi",
                    checkBool: controller.wifi.value,
                    onChanged: (value) {
                      controller.wifi.value = value!;
                    }),
              ),
              //======for Bed==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Bed",
                    checkBool: controller.bed.value,
                    onChanged: (value) {
                      controller.bed.value = value!;
                    }),
              ),

              //======for chairs==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Chair",
                    checkBool: controller.chari.value,
                    onChanged: (value) {
                      controller.chari.value = value!;
                    }),
              ),

              //======for Table ==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Table",
                    checkBool: controller.table.value,
                    onChanged: (value) {
                      controller.table.value = value!;
                    }),
              ),
              //======for Fan==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Fan",
                    checkBool: controller.fan.value,
                    onChanged: (value) {
                      controller.fan.value = value!;
                    }),
              ),
              //======for Gadda==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Gadda",
                    checkBool: controller.gadda.value,
                    onChanged: (value) {
                      controller.gadda.value = value!;
                    }),
              ),
              //======for Light==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Light",
                    checkBool: controller.light.value,
                    onChanged: (value) {
                      controller.light.value = value!;
                    }),
              ),
              //======for Locker==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Locker",
                    checkBool: controller.locker.value,
                    onChanged: (value) {
                      controller.locker.value = value!;
                    }),
              ),
              //======for Bedsheet==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Bed Sheet",
                    checkBool: controller.bedSheet.value,
                    onChanged: (value) {
                      controller.bedSheet.value = value!;
                    }),
              ),
              //======for washing machine==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Washing Machine",
                    checkBool: controller.washingMachin.value,
                    onChanged: (value) {
                      controller.washingMachin.value = value!;
                    }),
              ),
              //======for parking==========
              Obx(
                () => MYCheckBoxWidget(
                    title: "Parking",
                    checkBool: controller.parking.value,
                    onChanged: (value) {
                      controller.parking.value = value!;
                    }),
              ),

              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                     // controller.onsubmitButton();

                      // Navigator.push(context, MaterialPageRoute(builder: (context)
                      // =>ChargesAndDoorTime()));

                      Get.toNamed(RoutesName.chargeAndDoorTimingScreen);
                    },
                    child: Obx(
                      () => (controller.loading.value)
                          ? const CircularProgressIndicator(
                              color: Colors.blue,
                            )
                          : const Text("next"),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
