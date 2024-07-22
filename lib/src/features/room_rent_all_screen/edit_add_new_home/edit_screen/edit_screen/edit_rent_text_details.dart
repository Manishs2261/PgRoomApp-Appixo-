import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/common/widgets/com_reuse_elevated_button.dart';
import 'package:pgroom/src/utils/Constants/sizes.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import '../../../../../model/user_rent_model/user_rent_model.dart';
import '../../../../../utils/validator/text_field_validator.dart';
import '../../../../../utils/widgets/my_text_form_field.dart';
import '../controller/controller.dart';

class EditRentTextDetailsScreen extends StatelessWidget {
  EditRentTextDetailsScreen({super.key});

  final itemId = Get.arguments["id"];
  final UserRentModel data = Get.arguments['list'];

  final controller = Get.put(EditFormScreenController(Get.arguments['list'], Get.arguments["id"]));

  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.debug("Build - EditRentTextDetailsScreen");

    return Scaffold(
      appBar: AppBar(title: const Text("Rent Details")),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Column(
              children: [
                Form(
                  key: _globalKey,
                  child: Column(
                    children: [
                      // =================Home Name================
                      MyTextFormWidget(
                        textKeyBoard: TextInputType.text,
                        controller: controller.houseNameController.value,
                        hintText: "Enter Home / House Name",
                        labelText: 'House Name',
                        icon: const Icon(Icons.home),
                        borderRadius: BorderRadius.circular(11),
                        contentPadding: const EdgeInsets.only(top: 5, left: 10),
                        validator: EmailValidator.validate,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                        ],
                      ),

                      const SizedBox(
                        height: AppSizes.defaultSpace,
                      ),

                      //==========House Address================
                      MyTextFormWidget(
                        textKeyBoard: TextInputType.text,
                        controller: controller.houseAddressController.value,
                        hintText: "House Address",
                        labelText: 'House address',
                        icon: const Icon(Icons.location_city_outlined),
                        borderRadius: BorderRadius.circular(11),
                        contentPadding: const EdgeInsets.only(top: 5, left: 10),
                        validator: AddressValidator.validate,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                        ],
                      ),
                      const SizedBox(
                        height: AppSizes.defaultSpace,
                      ),
                      //===========City Name================
                      MyTextFormWidget(
                        textKeyBoard: TextInputType.text,
                        controller: controller.cityNameController.value,
                        hintText: "City Name",
                        labelText: 'City Name',
                        icon: const Icon(Icons.location_city_rounded),
                        borderRadius: BorderRadius.circular(11),
                        contentPadding: const EdgeInsets.only(top: 5, left: 10),
                        validator: CityValidator.validate,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                        ],
                      ),
                      const SizedBox(
                        height: AppSizes.defaultSpace,
                      ),
                      //============Land Mark address=================
                      MyTextFormWidget(
                        textKeyBoard: TextInputType.text,
                        controller: controller.landMarkController.value,
                        hintText: "Land Mark address",
                        labelText: 'Land Mark address',
                        icon: const Icon(Icons.home),
                        borderRadius: BorderRadius.circular(11),
                        contentPadding: const EdgeInsets.only(top: 5, left: 10),
                        validator: LandMarkValidator.validate,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]")),
                        ],
                      ),
                      const SizedBox(
                        height: AppSizes.defaultSpace,
                      ),

                      //==========Contact Number================
                      MyTextFormWidget(
                        maxLength: 10,
                        textKeyBoard: TextInputType.phone,
                        controller: controller.contactNumberController.value,
                        hintText: "Contact Number",
                        labelText: 'Contact Number',
                        icon: const Icon(Icons.phone),
                        borderRadius: BorderRadius.circular(11),
                        contentPadding: const EdgeInsets.only(top: 5, left: 10),
                        validator: ContactNumberValidator.validate,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                        ],
                      ),

                      const SizedBox(
                        height: AppSizes.defaultSpace,
                      ),

                      MyTextFormWidget(
                        textKeyBoard: TextInputType.number,
                        maxLength: 2,
                        controller: controller.numberOfRoomsController.value,
                        hintText: "Number of Rooms",
                        labelText: 'Number of Rooms',
                        icon: const Icon(Icons.home_work_rounded),
                        borderRadius: BorderRadius.circular(11),
                        contentPadding: const EdgeInsets.only(top: 5, left: 10),
                        validator: CommonUseValidator.validate,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
                        ],
                      ),

                      const SizedBox(
                        height: 50,
                      ),

                      ComReuseElevButton(
                          onPressed: () {
                            if (_globalKey.currentState!.validate()) {
                              controller.onEditRentDetailsData();
                            }
                          },
                          title: "Update")
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
