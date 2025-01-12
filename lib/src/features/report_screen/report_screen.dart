import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/apis.dart';

import '../../utils/widgets/com_reuse_elevated_button.dart';

class ReportController extends GetxController {
  final options = ["Copy Right", "False Information", "Other"];
  var selectedOptions = <String, bool>{
    "Copy Right": false,
    "False Information": false,
    "Other": false,
  }.obs;
  var otherReason = "".obs;

  void toggleOption(String option, bool value) {
    selectedOptions[option] = value;
    update();
  }

  void updateOtherReason(String value) {
    otherReason.value = value;
  }

  String get reportReason {
    return selectedOptions.entries
        .where((entry) => entry.value)
        .map((entry) =>
            entry.key == "Other" ? "Other: ${otherReason.value}" : entry.key)
        .join(", ");
  }
}

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});

  final data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select a reason for reporting:",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Obx(() {
              return Column(
                children: controller.options.map((option) {
                  return CheckboxListTile(
                    dense: true,
                    title: Text(
                      option,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    value: controller.selectedOptions[option],
                    onChanged: (bool? value) {
                      controller.toggleOption(option, value ?? false);
                    },
                  );
                }).toList(),
              );
            }),
            Obx(() {
              if (controller.selectedOptions["Other"] == true) {
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    TextField(
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                        labelText: "Please specify the reason",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      maxLength: 200,
                      onChanged: controller.updateOtherReason,
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
            const SizedBox(height: 64),
            ReuseElevButton(
              onPressed: () async {
                final reportReason = controller.reportReason;
                if (reportReason.isNotEmpty) {
                  ApisClass.submitReport(
                      reportReason: reportReason,
                      docId: data[0],
                      roomCollection: data[1]);
                }
              },
              title: 'Submit Report',
            ),
          ],
        ),
      ),
    );
  }
}
