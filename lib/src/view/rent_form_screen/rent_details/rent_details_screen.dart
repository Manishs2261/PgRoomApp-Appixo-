
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:pgroom/src/uitels/text_field_validator/text_field_validator.dart';
import 'package:pgroom/src/view/rent_form_screen/rent_details/controller/controller.dart';
import 'package:pgroom/src/uitels/widgets/my_text_form_field.dart';

import '../../../res/route_name/routes_name.dart';
import '../hostel_and_room_type/hostel_and_room_type_screen.dart';

class RentDetailsScsreen extends StatelessWidget {
  RentDetailsScsreen({super.key});

  final _globlekey = GlobalKey<FormState>();

  final controller = Get.put(RentDetailsController());

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("build scren => rent Details 🔴");
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rent Details"),
      ),
      body: GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
            child: Form(
              key: _globlekey,
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
                    lableText: 'House addsress',
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
                    controller: controller.landdMarkController.value,
                    hintText: "Land Mark address",
                    lableText: 'Land Makr address',
                    icon: const Icon(Icons.home),
                    borderRadius: BorderRadius.circular(11),
                    contentPadding: const EdgeInsets.only(top: 5, left: 10),
                    validator: LandMarkValidator.validate,
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  //==========Contuct Number================
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
                        if (_globlekey.currentState!.validate()) {
                          //controller.onSubmitButton();
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
