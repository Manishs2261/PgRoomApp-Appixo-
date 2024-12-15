import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/data/repository/apis/services_api.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/widgets/form_headline.dart';
import '../../../../utils/logger/logger.dart';
import '../../../../utils/widgets/form_process_step.dart';
import '../save_data_controller.dart';
import 'controller.dart';


class ThirdServicesForm extends StatelessWidget {
  ThirdServicesForm({super.key});

  final controller = Get.put(ThirdServicesFormController());
  final dataSaveController = Get.put(SaveDataServiceController());
  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - _ThirdServicesScreenState......................................");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // Increase the height to accommodate the progress indicator
        title: const FormProcessStep(
          isFormOne: true,
          isFormTwo: true,
          isFormThree: true,
          isShow: false,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),

              const FormHeadline(title: 'FAQ'),
              const SizedBox(
                height: 5,
              ),

              Obx(
                    () => controller.servicesFAQ.isEmpty
                    ? const Center(child: Text(''))
                    : Column(
                  children:
                  controller.servicesFAQ.asMap().entries.map((entry) {
                    int index = entry.key;

                    return ListTile(
                      title: Text(
                        'Q${index + 1} :-  ${controller.servicesFAQ[index].question}',
                      ),
                      subtitle: Text(
                        'Answer :-  ${controller.servicesFAQ[index].answer}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => controller.removeServicesFAQ(index),
                      ),
                    );

                  }).toList(),
                ),
              ),

              Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: controller.showAddServicesFAQDialog,
                    icon: const Icon(
                      Icons.add_circle_outline_sharp,
                      size: 40,
                    ),
                  )),

              const SizedBox(
                height: 16,
              ),

              // Save button
              const SizedBox(height: 20),
              ReuseElevButton(
                onPressed: () => dataSaveController.onSaveData(),
                title: "Done",
              ),
              const SizedBox(height: 20),
              ReuseElevButton(
                color: Colors.orange,
                onPressed: () => Get.back(),
                title: "Back",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
