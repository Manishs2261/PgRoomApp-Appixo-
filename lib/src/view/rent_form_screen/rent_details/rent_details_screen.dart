
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:pgroom/src/uitels/text_field_validator/text_field_validator.dart';
import 'package:pgroom/src/view/rent_form_screen/rent_details/controller/controller.dart';
import 'package:pgroom/src/view/rent_form_screen/widget/my_text_form_field.dart';

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
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //==========House Address================
                  MyTextFormWedgit(
                    controller: controller.houseAddressController.value,
                    hintText: "House Address",
                    lableText: 'House addsress',
                    icon: const Icon(Icons.location_city_outlined),
                    borderRadius: BorderRadius.circular(11),
                    contentPadding: const EdgeInsets.only(top: 5, left: 10),
                    validator: AddressValidator.validate,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //===========City Name================
                  MyTextFormWedgit(
                    controller: controller.cityNameController.value,
                    hintText: "City Name",
                    lableText: 'City Name',
                    icon: const Icon(Icons.location_city_rounded),
                    borderRadius: BorderRadius.circular(11),
                    contentPadding: const EdgeInsets.only(top: 5, left: 10),
                    validator: CityValidator.validate,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //============Land Mark address=================
                  MyTextFormWedgit(
                    controller: controller.landdMarkController.value,
                    hintText: "Land Mark address",
                    lableText: 'Land Makr address',
                    icon: const Icon(Icons.home),
                    borderRadius: BorderRadius.circular(11),
                    contentPadding: const EdgeInsets.only(top: 5, left: 10),
                    validator: LandMarkValidator.validate,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //==========Contuct Number================
                  MyTextFormWedgit(
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
                          controller.onSubmitButton();
                        }

                        // Navigator.push(context, MaterialPageRoute(builder:
                        //   (context)=> HostelAndRoomTypeScreen()));
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
