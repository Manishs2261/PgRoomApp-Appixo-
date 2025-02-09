import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pgroom/src/data/repository/apis/services_collection.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';

import '../../../../../res/route_name/routes_name.dart';
import '../../../../Home_fitter_new/view_your_post/view_screen/services_update/controller/controller.dart';
import '../../../model/services_model.dart';

class FirstUpdateServicesFormController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final listOfServicesController = Get.put(ListOfServicesUpdateController());

  final ServicesModel servicesData = Get.arguments;
  RxList<ServiceFAQ> servicesFAQ = <ServiceFAQ>[].obs;
  late final TextEditingController nameController;

  late final TextEditingController descriptionController;

  late final TextEditingController addressController;

  late final TextEditingController landmarkController;

  late final TextEditingController cityController;

  late final TextEditingController stateController;

  late final List imageList = [];

  @override
  void onInit() {
    nameController = TextEditingController(text: servicesData.servicesName);
    descriptionController =
        TextEditingController(text: servicesData.description);
    addressController = TextEditingController(text: servicesData.address);
    landmarkController = TextEditingController(text: servicesData.landmark);
    cityController = TextEditingController(text: servicesData.city);
    stateController = TextEditingController(text: servicesData.state);
    servicesFAQ.addAll(servicesData.serviceFAQ ?? []);
    super.onInit();
  }

  final RxList<File> imageFiles = <File>[].obs; // Store File objects

  final ImagePicker picker = ImagePicker();

  Future<void> pickImages() async {
    final List<XFile> selectedImages = await picker.pickMultiImage();

    if (selectedImages.length > 10) {
      // Show a message or alert if more than 10 images are selected
      AppHelperFunction.showSnackBar('You can only select up to 10 images!');
      // Limit the list to 10 images and convert XFile to File
      imageFiles.value = selectedImages
          .sublist(0, 10)
          .map((xfile) => File(xfile.path))
          .toList();
    } else {
      // Convert XFile to File and update the list
      imageFiles.value =
          selectedImages.map((xfile) => File(xfile.path)).toList();
    }
  }

  onSaveAndNext() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    bool value = await ServicesApis.updateServicesDetailsData(
        documentId: servicesData.sId.toString(),
        servicesName: nameController.text,
        description: descriptionController.text,
        address: addressController.text,
        landmark: landmarkController.text,
        city: cityController.text,
        state: stateController.text,
        imageFiles: imageFiles,
        serviceFAQ: servicesFAQ,
      imageUrlsList: servicesData.image!
    );

    if (value) {
      Get.close(2);
      listOfServicesController.servicesListData.clear();
      listOfServicesController.lastDocument = null;
      listOfServicesController.hasMoreData.value = true;
      await listOfServicesController.fetchData();
    } else {
      Navigator.pop(Get.context!);
    }
  }

  // Function to add a new item
  void addServicesFAQ(String question, String answer) {
    servicesFAQ.add(ServiceFAQ(question: question, answer: answer));
  }

  // Function to show dialog for adding new item
  void showAddServicesFAQDialog() {
    String itemQuestion = '';
    String itemAnswer = '';

    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Add New FAQ"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Enter Questions'),
                maxLines: 2,
                minLines: 1,
                onChanged: (value) {
                  itemQuestion = value;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'Enter Answer'),
                keyboardType: TextInputType.text,
                maxLines: 5,
                minLines: 1,
                onChanged: (value) {
                  itemAnswer = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                "Cancel",
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                if (itemQuestion.isNotEmpty && itemAnswer.isNotEmpty) {
                  addServicesFAQ(itemQuestion, itemAnswer);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Function to remove an item
  void removeServicesFAQ(int index) {
    servicesFAQ.removeAt(index);
  }


}
