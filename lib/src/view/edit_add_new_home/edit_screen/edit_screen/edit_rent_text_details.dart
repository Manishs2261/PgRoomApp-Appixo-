import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../model/user_rent_model/user_rent_model.dart';
 import '../../../../uitels/validator/text_field_validator.dart';
import '../../../../uitels/widgets/my_text_form_field.dart';
import '../controller/controller.dart';

class EditRentTextDetailsScreen extends StatelessWidget {
  EditRentTextDetailsScreen({super.key});

  final itemId = Get.arguments["id"];
  final UserRentModel data = Get.arguments['list'];

  final controller = Get.put(
      EditFormScreenController(Get.arguments['list'], Get.arguments["id"]));

  final _globlekey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rent Details")),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Column(
              children: [
                Form(
                  key: _globlekey,
                  child: Column(
                    children: [
                      // =================Home Name================
                      MyTextFormWedgit(
                        textKeyBoard: TextInputType.text,
                        controller: controller.houseNameController.value,
                        hintText: "Enter Home / House Name",
                        lableText: 'House Name',
                        icon: const Icon(Icons.home),
                        borderRadius: BorderRadius.circular(11),
                        contentPadding: const EdgeInsets.only(top: 5, left: 10),
                        validator: EmailValidator.validate,
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
                        maxLength: 10,
                        textKeyBoard: TextInputType.phone,
                        controller: controller.contactNumberController.value,
                        hintText: "Contact Number",
                        lableText: 'Contact Number',
                        icon: const Icon(Icons.phone),
                        borderRadius: BorderRadius.circular(11),
                        contentPadding: const EdgeInsets.only(top: 5, left: 10),
                        validator: ContactNumberValidator.validate,
                      ),

                      const SizedBox(
                        height: 50,
                      ),

                      SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              controller.EditRentDetailsData().then((value) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }).onError((error, stackTrace) {
                                Get.snackbar("error", "error");
                              });
                            },
                            child: Text("Update")),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
