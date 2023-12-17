import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import 'package:pgroom/src/utils/widgets/my_text_form_field.dart';

 import '../../../../utils/validator/text_field_validator.dart';
import 'controller/controller.dart';

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
                    height: 15,
                  ),

                  MyTextFormWedgit(
                    textKeyBoard: TextInputType.number,
                    maxLength: 2,
                    controller: controller.numberOfRoomsController.value,
                    hintText: "Number of Rooms",
                    lableText: 'Number of Rooms',
                    icon: const Icon(Icons.home_work_rounded),
                    borderRadius: BorderRadius.circular(11),
                    contentPadding: const EdgeInsets.only(top: 5, left: 10),
                    validator: CommonUseValidator.validate,
                  ),

                  const SizedBox(
                    height: 80,
                  ),


                  ComReuseElevButton(onPressed: (){
                    if (_globalKey.currentState!.validate()) {
                      controller.onSubmitButton();
                    }
                  }, title: "Next",loading: controller.loading.value,)


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
