import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/com_reuse_elevated_button.dart';
import '../../../../utils/Constants/colors.dart';
import '../../../../utils/validator/text_field_validator.dart';
import '../../../../utils/widgets/form_headline.dart';
import '../../../../utils/widgets/form_process_step.dart';
import '../../../../utils/widgets/my_text_form_field.dart';
import '../first_food_form/controller.dart';
import 'controller.dart';

class SecondFoodForm extends StatelessWidget {
  SecondFoodForm({super.key});

  final controller = Get.put(SecondFoodFormController());
  final firstFoodFormController = Get.put(FirstFoodFormController());

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FormHeadline(
                  title: 'Food type',
                ),
                Obx(
                  () => Wrap(
                    children: [
                      _buildRadioListTile('Veg', 'Veg'),
                      _buildRadioListTile('Nonveg', 'Non-Veg'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(() => (firstFoodFormController.foodShopType.value == 'Mess')
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FormHeadline(title: 'Monthly Subscription'),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextFormWidget(
                            textKeyBoard: TextInputType.number,
                            controller: controller.breakfastController,
                            labelText: 'Breakfast',
                            icon: const Icon(Icons.currency_rupee,
                                color: AppColors.primary),
                            borderRadius: BorderRadius.circular(11),
                            contentPadding:
                                const EdgeInsets.only(top: 5, left: 10),
                            validator: CommonUseValidator.validate,
                            maxLength: 100,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextFormWidget(
                            textKeyBoard: TextInputType.number,
                            controller: controller.lunchOrDinnerController,
                            labelText: 'Lunch Or Dinner (only One)',
                            icon: const Icon(Icons.currency_rupee,
                                color: AppColors.primary),
                            borderRadius: BorderRadius.circular(11),
                            contentPadding:
                                const EdgeInsets.only(top: 5, left: 10),
                            validator: CommonUseValidator .validate,
                            maxLength: 100,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextFormWidget(
                            textKeyBoard: TextInputType.number,
                             controller: controller.dinnerAndBreakfastController,

                            labelText: 'Lunch Or Dinner (Both)',
                            icon: const Icon(Icons.currency_rupee,
                                color: AppColors.primary),
                            borderRadius: BorderRadius.circular(11),
                            contentPadding:
                                const EdgeInsets.only(top: 5, left: 10),
                            validator: CommonUseValidator .validate,
                            maxLength: 100,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextFormWidget(
                            textKeyBoard: TextInputType.number,
                            controller: controller.breakfastAndLunchController,

                            labelText: 'Breakfast, Lunch & Dinner',
                            icon: const Icon(Icons.currency_rupee,
                                color: AppColors.primary),
                            borderRadius: BorderRadius.circular(11),
                            contentPadding:
                                const EdgeInsets.only(top: 5, left: 10),
                            validator: CommonUseValidator .validate,
                            maxLength: 100,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                            ],
                          ),
                          Obx(
                            () => controller.subscriptionItem.isEmpty
                                ? const Center(child: Text(''))
                                : Column(
                                    children: controller.subscriptionItem
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      int index = entry.key;
                                      return ListTile(
                                        title: Text(controller
                                            .subscriptionItem[index]['name']),
                                        subtitle: Text(
                                            'Cost: ₹ ${controller.subscriptionItem[index]['price']}'),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () => controller
                                              .removeSubscriptionItem(index),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed:
                                    controller.showAddSubscriptionItemDialog,
                                icon: const Icon(
                                  Icons.add_circle_outline_sharp,
                                  size: 40,
                                ),
                              )),
                          const SizedBox(
                            height: 16,
                          ),



                          const FormHeadline(
                            title: 'Daily meals cost',
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextFormWidget(
                            textKeyBoard: TextInputType.number,
                             controller: controller.thaliController,

                            labelText: 'Thali',
                            icon:
                            const Icon(Icons.currency_rupee, color: AppColors.primary),
                            borderRadius: BorderRadius.circular(11),
                            contentPadding: const EdgeInsets.only(top: 5, left: 10),
                            validator:  CommonUseValidator.validate,
                            maxLength: 100,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextFormWidget(
                            textKeyBoard: TextInputType.number,
                            controller: controller.cupOfRiceController,

                            labelText: 'a cup of rice',
                            icon:
                            const Icon(Icons.currency_rupee, color: AppColors.primary),
                            borderRadius: BorderRadius.circular(11),
                            contentPadding: const EdgeInsets.only(top: 5, left: 10),
                            validator:  CommonUseValidator.validate,
                            maxLength: 100,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextFormWidget(
                            textKeyBoard: TextInputType.number,
                             controller: controller.rotiController,

                            labelText: 'Roti per pieces',
                            icon:
                            const Icon(Icons.currency_rupee, color: AppColors.primary),
                            borderRadius: BorderRadius.circular(11),
                            contentPadding: const EdgeInsets.only(top: 5, left: 10),
                            validator: CommonUseValidator.validate,
                            maxLength: 100,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextFormWidget(
                            textKeyBoard: TextInputType.number,
                            controller: controller.sabjiController,

                            labelText: 'Sabaji',
                            icon:
                            const Icon(Icons.currency_rupee, color: AppColors.primary),
                            borderRadius: BorderRadius.circular(11),
                            contentPadding: const EdgeInsets.only(top: 5, left: 10),
                            validator: CommonUseValidator .validate,
                            maxLength: 100,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextFormWidget(
                            textKeyBoard: TextInputType.number,
                            controller: controller.dalController,

                            labelText: 'Dal',
                            icon:
                            const Icon(Icons.currency_rupee, color: AppColors.primary),
                            borderRadius: BorderRadius.circular(11),
                            contentPadding: const EdgeInsets.only(top: 5, left: 10),
                            validator: CommonUseValidator .validate,
                            maxLength: 100,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                            ],
                          ),
                          Obx(
                                () => controller.dailyItem.isEmpty
                                ? const Center(child: Text(''))
                                : Column(
                              children:
                              controller.dailyItem.asMap().entries.map((entry) {
                                int index = entry.key;
                                return ListTile(
                                  title: Text(controller.dailyItem[index]['name']),
                                  subtitle: Text(
                                      'Cost: ₹ ${controller.dailyItem[index]['price']}'),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () =>
                                        controller.removeDailyItem(index),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: controller.showAddDailyItemDialog,
                                icon: const Icon(
                                  Icons.add_circle_outline_sharp,
                                  size: 40,
                                ),
                              )),
                          const SizedBox(
                            height: 16,
                          )
                        ],
                      )
                    // ignore: prefer_const_constructors
                    : SizedBox()),

                Obx(
                        ()=>  firstFoodFormController.foodShopType.value != "Mess"
                            ?  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FormHeadline(
                              title: 'Add Food Menu',
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Obx(
                                  () => controller.restructureItem.isEmpty
                                  ? const Center(child: Text(''))
                                  : Column(
                                children: controller.restructureItem
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  int index = entry.key;
                                  return ListTile(
                                    title:
                                    Text(controller.restructureItem[index]['name']),
                                    subtitle: Text(
                                        'Cost: ₹ ${controller.restructureItem[index]['price']}'),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () =>
                                          controller.removeRestructureItem(index),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                  onPressed: controller.showAddRestructureItemDialog,
                                  icon: const Icon(
                                    Icons.add_circle_outline_sharp,
                                    size: 40,
                                  ),
                                )),],
                        )
                            : const SizedBox(),

                ),
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

  /// Radio List Tile for food type
  Widget _buildRadioListTile(String title, String value) {
    return SizedBox(
      width: 150,
      child: RadioListTile<String>(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        value: value,
        dense: false,
        contentPadding: EdgeInsets.zero,
        visualDensity: const VisualDensity(
          horizontal: -4,
        ),
        groupValue: controller.foodType.value,
        onChanged: (value) {
          controller.foodType.value = value!;
        },
      ),
    );
  }
}
