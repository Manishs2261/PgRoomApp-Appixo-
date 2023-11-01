import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pgroom/src/repositiry/apis/apis.dart';
import 'package:pgroom/src/view/edit_add_new_home/edit_screen/controller/controller.dart';
import 'package:pgroom/src/view/rent_form_screen/add_image_/add_image_screen.dart';
import 'package:pgroom/src/view/rent_form_screen/provide_facilites/provide_facilites_screen.dart';

import '../../../model/user_rent_model/user_rent_model.dart';
import '../../../uitels/text_field_validator/text_field_validator.dart';
import '../../rent_form_screen/hostel_and_room_type/controller/controller.dart';
import '../../rent_form_screen/hostel_and_room_type/hostel_and_room_type_screen.dart';
import '../../rent_form_screen/rent_details/controller/controller.dart';
import '../../rent_form_screen/rent_details/rent_details_screen.dart';
import '../../../uitels/my_text_form_widgets/my_text_form_field.dart';

class EditFormScreen extends StatelessWidget {
  EditFormScreen({super.key});

  final itemId = Get.arguments["id"];

 final UserRentModel data = Get.arguments['list'];
 final houseNameController = TextEditingController(text : Get.arguments['list']
     .houseName);
  final houseAddressController = TextEditingController(text: Get
      .arguments['list'].addres);
  final cityNameController = TextEditingController();
  final landdMarkController = TextEditingController();
  final contactNumberController = TextEditingController();

  final _globlekey = GlobalKey<FormState>();






  @override
  Widget build(BuildContext context) {
    print("Build Screen => Edit_Form_Screen ❤");
    print(data.addres);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
          child: Column(
            children: [
            Form(
                key: _globlekey,
                child: Column(
                  children: [

                    // =================Home Name================
                    MyTextFormWedgit(
                      controller: houseNameController,
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
                      controller: houseAddressController,
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
                      controller: cityNameController,
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
                      controller: landdMarkController,
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
                      controller: contactNumberController,
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



                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
