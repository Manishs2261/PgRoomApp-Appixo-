import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'package:pgroom/src/view/rent_form_screen/rent_details/controller'
    '/controller.dart';
import 'package:pgroom/src/utils/widgets/my_text_form_field.dart';

import '../../../utils/validator/text_field_validator.dart';

class RentDetailsScsreen extends StatelessWidget {
  RentDetailsScsreen({super.key});

  final _globalKey = GlobalKey<FormState>();

  final controller = Get.put(RentDetailsController());

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - RentDetailScreen");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rent Details"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  // =================Home Name================
                  MyTextFormWedgit(
                    controller: controller.houseNameController.value,
                    hintText: "Enter Home / House Name",
                    lableText: 'House Name',
                    icon: const Icon(Icons.home),
                    borderRadius: BorderRadius.circular(11),
                    contentPadding: const EdgeInsets.only(top: 5, left: 10),
                    validator: EmailValidator.validate,
                    textKeyBoard: TextInputType.text,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  //==========House Address================
                  MyTextFormWedgit(
                    textKeyBoard: TextInputType.text,
                    controller: controller.houseAddressController.value,
                    hintText: "House Address",
                    lableText: 'House address',
                    icon: const Icon(Icons.location_city_outlined),
                    borderRadius: BorderRadius.circular(11),
                    contentPadding: const EdgeInsets.only(top: 5, left: 10),
                    validator: AddressValidator.validate,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //===========City Name================
                  MyTextFormWedgit(
                    textKeyBoard: TextInputType.text,
                    controller: controller.cityNameController.value,
                    hintText: "City Name",
                    lableText: 'City Name',
                    icon: const Icon(Icons.location_city_rounded),
                    borderRadius: BorderRadius.circular(11),
                    contentPadding: const EdgeInsets.only(top: 5, left: 10),
                    validator: CityValidator.validate,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //============Land Mark address=================
                  MyTextFormWedgit(
                    textKeyBoard: TextInputType.text,
                    controller: controller.landMarkController.value,
                    hintText: "Land Mark address",
                    lableText: 'Land Mark address',
                    icon: const Icon(Icons.home),
                    borderRadius: BorderRadius.circular(11),
                    contentPadding: const EdgeInsets.only(top: 5, left: 10),
                    validator: LandMarkValidator.validate,
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  //==========Contact Number================
                  MyTextFormWedgit(
                    textKeyBoard: TextInputType.phone,
                    maxLength: 10,
                    controller: controller.contactNumberController.value,
                    hintText: "Contact Number",
                    lableText: 'Contact Number',
                    icon: const Icon(Icons.phone),
                    borderRadius: BorderRadius.circular(11),
                    contentPadding: const EdgeInsets.only(top: 5, left: 10),
                    validator: ContactNumberValidator.validate,
                  ),

                  const SizedBox(
                    height: 80,
                  ),

                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          controller.onSubmitButton();
                        }
                      },
                      child: Obx(
                        () => (controller.loading.value)
                            ? const CircularProgressIndicator(
                                color: Colors.blue,
                              )
                            : const Text("Save & Next"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
