import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';
import 'package:pgroom/src/utils/widgets/form_headline.dart';

import '../../../../data/repository/apis/tiffine_services_api.dart';
import '../../../../utils/logger/logger.dart';
import '../../../../utils/widgets/form_process_step.dart';
import '../data_save_controller.dart';
import '../first_food_form/controller.dart';
import 'controller.dart';

class FourthFoodForm extends StatelessWidget {
  FourthFoodForm({super.key});

  final controller = Get.put(FourFoodFormController());
  final firstFoodFormController = Get.put(FirstFoodFormController());
  final dataSaveController = Get.put(FoodDataSaveController());


  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - _FourthRoomFormScreenState......................................");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // Increase the height to accommodate the progress indicator
        title: const FormProcessStep(
          isFormOne: true,
          isFormTwo: true,
          isFormThree: true,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 64),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => firstFoodFormController.foodShopType.value == 'Mess'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FormHeadline(title: 'Mess rule'),
                          const SizedBox(
                            height: 16,
                          ),
                          Column(
                            children: [
                              // Wrap for FilterChips
                              Obx(
                                () => Wrap(
                                  runSpacing: 8,
                                  spacing: 8,
                                  children: controller.availableHouseRules
                                      .map((facility) {
                                    final isSelected = controller
                                        .selectedHouseRules
                                        .contains(facility);
                                    return FilterChip(
                                      backgroundColor: Colors.white,
                                      selectedColor: AppColors.primary,
                                      label: Text(
                                        facility,

                                        overflow: TextOverflow.ellipsis,
                                        // Optionally add an ellipsis for long text
                                        maxLines: 5,
                                        // Set the maximum number of lines
                                        softWrap: true,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors
                                                  .black, // Selected text color
                                        ),
                                      ),
                                      selected: controller.selectedHouseRules
                                          .contains(facility),
                                      onSelected: (selected) {
                                        if (selected) {
                                          controller.selectedHouseRules
                                              .add(facility);
                                        } else {
                                          controller.selectedHouseRules
                                              .remove(facility);
                                        }
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),

                              // TextField for adding new facilities
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        onTapOutside: (event) =>
                                            FocusScope.of(context).unfocus(),
                                        controller:
                                            controller.newHouseRulesController,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp("[a-zA-Z ]")),
                                        ],
                                        decoration: InputDecoration(
                                          labelText: 'Add a new facility',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add_circle_outline_sharp,
                                        color: AppColors.primary,
                                        size: 35,
                                      ),
                                      onPressed: () {
                                        controller.addNewFacility(controller
                                            .newHouseRulesController.text);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox()),

                const SizedBox(
                  height: 16,
                ),

                const FormHeadline(title: 'FAQ'),
                const SizedBox(
                  height: 5,
                ),

                Obx(
                  () => controller.foodFAQ.isEmpty
                      ? const Center(child: Text(''))
                      : Column(
                          children:
                              controller.foodFAQ.asMap().entries.map((entry) {
                            int index = entry.key;

                            return ListTile(
                              title: Text(
                                  'Q${index + 1} :-  ${controller.foodFAQ[index].question}'),
                              subtitle: Text(
                                  'Answer :-  ${controller.foodFAQ[index].answer}'),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () =>
                                    controller.removeFoodFAQ(index),
                              ),
                            );
                          }).toList(),
                        ),
                ),

                Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: controller.showAddFoodFAQDialog,
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
                  onPressed: () {
                  dataSaveController.onDataSave();
                  },
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
      ),
    );
  }
}
