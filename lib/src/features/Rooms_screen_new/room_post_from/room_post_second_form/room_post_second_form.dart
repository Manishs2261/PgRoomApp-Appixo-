import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/utils/Constants/colors.dart';

import '../../../../res/route_name/routes_name.dart';
import '../../../../utils/logger/logger.dart';
import '../../../../utils/validator/text_field_validator.dart';
import '../../../../utils/widgets/form_headline.dart';
import '../../../../utils/widgets/form_process_step.dart';
import '../../../../utils/widgets/my_text_form_field.dart';
import 'controller.dart';

class SecondRoomFormScreen extends StatelessWidget {
  SecondRoomFormScreen({super.key});

  final controller = Get.put(SecondRoomFormController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug(
        "Build - SecondRoomFormScreen......................................");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // Increase the height to accommodate the progress indicator
        title: const FormProcessStep(
          isFormOne: true,
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
                //==========House Address================
                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  controller: controller.houseAddressController,
                  labelText: 'House address',
                  icon: const Icon(Icons.home, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  maxLength: 100,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                //===========City Name================
                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  controller: controller.landmarkController,
                  labelText: 'Enter landmark',
                  icon: const Icon(Icons.location_on, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  maxLength: 50,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                //============Land Mark address=================
                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  controller: controller.cityController,
                  labelText: 'Enter City',
                  icon: const Icon(Icons.location_city_outlined,
                      color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  maxLength: 50,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),

                MyTextFormWidget(
                  textKeyBoard: TextInputType.text,
                  controller: controller.stateController,
                  labelText: 'Enter State',
                  icon: const Icon(Icons.map, color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  maxLength: 50,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),

                MyTextFormWidget(
                  textKeyBoard: TextInputType.number,
                  maxLength: 2,
                  controller: controller.numberOfRoomController,
                  labelText: 'Total number of rooms',
                  icon: const Icon(Icons.home_work_rounded,
                      color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  validator: CommonUseValidator.validate,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),

                // 15. Meals availability
                const FormHeadline(
                  title: 'Meals Available',
                ),
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Yes'),
                          value: 'Yes',
                          dense: true,
                          groupValue: controller.mealsAvailable.value,
                          onChanged: (value) {
                            controller.mealsAvailable.value = value!;
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('No'),
                          value: 'No',
                          dense: true,
                          groupValue: controller.mealsAvailable.value,
                          onChanged: (value) {
                            controller.mealsAvailable.value = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(16),

                MyTextFormWidget(
                  textKeyBoard: TextInputType.number,
                  maxLength: 6,
                  controller: controller.oneTimeDepositController,
                  labelText: 'One time security deposit',
                  icon: const Icon(Icons.currency_rupee,
                      color: AppColors.primary),
                  borderRadius: BorderRadius.circular(11),
                  contentPadding: const EdgeInsets.only(top: 5, left: 10),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),
                // 12. Room facilities (Multiple choice)
                const FormHeadline(
                  title: 'Room Facilities',
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(
                  () => Column(
                    children: [
                      // Wrap for FilterChips
                      Wrap(
                        runSpacing: 8,
                        spacing: 8,
                        children:
                            controller.availableFacilities.map((facility) {
                          final isSelected =
                              controller.selectedFacilities.contains(facility);
                          return FilterChip(
                            backgroundColor: Colors.white,
                            selectedColor: AppColors.primary,
                            label: Text(
                              facility,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black, // Selected text color
                              ),
                            ),
                            selected: controller.selectedFacilities
                                .contains(facility),
                            onSelected: (selected) {
                              if (selected) {
                                controller.selectedFacilities.add(facility);
                              } else {
                                controller.selectedFacilities.remove(facility);
                              }
                            },
                          );
                        }).toList(),
                      ),

                      // TextField for adding new facilities
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller.addNewFacilityController,
                                maxLength: 20,
                                keyboardType: TextInputType.text,
                                onTapOutside: (vale) => FocusManager
                                    .instance.primaryFocus
                                    ?.unfocus(),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z0-9 ]")),
                                ],
                                decoration: InputDecoration(
                                  counterText: '',
                                  labelText: 'Add a new facility',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  isDense: true,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () => controller.addNewFacility(
                                  controller.addNewFacilityController.text),
                              child: const Icon(
                                Icons.add_circle_outline_sharp,
                                color: AppColors.primary,
                                size: 35,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                // 16. Common areas
                const FormHeadline(
                  title: "Common Areas",
                ),
                const SizedBox(
                  height: 16,
                ),

                Obx(
                  () => Column(
                    children: [
                      Wrap(
                          runSpacing: 8,
                          spacing: 8,
                          children: controller.availableCommonAreas.map((area) {
                            final isSelected =
                                controller.selectedCommonAreas.contains(area);
                            return FilterChip(
                              label: Text(
                                area,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black, // Selected text color
                                ),
                              ),
                              selectedColor: AppColors.primary,
                              backgroundColor: Colors.white,
                              selected:
                                  controller.selectedCommonAreas.contains(area),
                              onSelected: (selected) {
                                if (selected) {
                                  controller.selectedCommonAreas.add(area);
                                } else {
                                  controller.selectedCommonAreas.remove(area);
                                }
                              },
                            );
                          }).toList()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.addCommonAreaController,
                          maxLength: 20,
                          keyboardType: TextInputType.text,
                          onTapOutside: (vale) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z0-9 ]")),
                          ],
                          decoration: InputDecoration(
                            counterText: '',
                            labelText: 'Add a new common area',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () => controller.addNewCommonArea(
                            controller.addCommonAreaController.text),
                        child: const Icon(
                          Icons.add_circle_outline_sharp,
                          color: AppColors.primary,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                // 17. Bill responsibilities
                const FormHeadline(
                  title: 'Bills',
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(
                  () => Wrap(
                    runSpacing: 8,
                    spacing: 8,
                    children: controller.availableBills.map((bill) {
                      final isSelected =
                          controller.selectedCommonAreas.contains(bill);

                      return FilterChip(
                        label: Text(
                          bill,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.black, // Selected text color
                          ),
                        ),
                        selectedColor: AppColors.primary,
                        backgroundColor: Colors.white,
                        selected: controller.selectedCommonAreas.contains(bill),
                        onSelected: (selected) {
                          if (selected) {
                            controller.selectedCommonAreas.add(bill);
                          } else {
                            controller.selectedCommonAreas.remove(bill);
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.addBillsController,
                          maxLength: 20,
                          keyboardType: TextInputType.text,
                          onTapOutside: (vale) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z0-9 ]")),
                          ],
                          decoration: InputDecoration(
                            counterText: '',
                            labelText: 'Add a new Bill',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () => controller.addNewBills(
                            controller.addBillsController.text),
                        child: const Icon(
                          Icons.add_circle_outline_sharp,
                          color: AppColors.primary,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                ),

                // Save button
                const SizedBox(height: 20),
                ReuseElevButton(
                  onPressed: () => controller.onSaveAndNext(),
                  title: "Save & Next",
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
