import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../res/route_name/routes_name.dart';

class SecondRoomFormController extends GetxController{


  final formKey = GlobalKey<FormState>();

  // Meal availability
  RxString mealsAvailable = 'No'.obs;

  // Common facilities & house rules
  RxList<String> selectedCommonAreas = <String>[].obs;

  RxList<String> selectedBills = <String>[].obs;

  RxList availableBills = [
    "Electricity",
    "Water",
  ].obs;

  RxList availableCommonAreas = [
    "Kitchen",
    "Dining Hall",
    "Study Room",
    "Library",
  ].obs;

  // To store selected common areas
  RxList availableFacilities = [
    'Bed',
    'Chair',
    'Table',
    'Fan',
    'Light',
    'Cooler',
    'Washing Machine',
    'Bed Sheet',
    'Fridge',
    'Water Purifier',
    'TV',
    'Laundry',
    'Housekeeping',
    'Internet/Wifi Connectivity',
    'Gym',
    'Lift',
    'Parking',
    'Power Backup',
    'CCTV',
    'AC',
    'Attached Bathroom',
  ].obs;

  RxList<String> selectedFacilities = <String>[].obs;

  // To store selected facilities
  TextEditingController houseAddressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  TextEditingController numberOfRoomController = TextEditingController();
  TextEditingController oneTimeDepositController = TextEditingController();
  TextEditingController addNewFacilityController = TextEditingController();
  TextEditingController addCommonAreaController = TextEditingController();
  TextEditingController addBillsController = TextEditingController();

  // For adding new facilities
  void addNewFacility(String facility) {
    if (facility.isNotEmpty && !availableFacilities.contains(facility)) {
      availableFacilities.add(facility);
    }
    addNewFacilityController.clear();
  }


  void addNewBills(String facility) {
    if (facility.isNotEmpty && !availableBills.contains(facility)) {
      availableBills.add(facility);
    }
    addBillsController.clear();
  }


  void addNewCommonArea(String facility) {
    if (facility.isNotEmpty && !availableCommonAreas.contains(facility)) {
      availableCommonAreas.add(facility);
    }
    addCommonAreaController.clear();
  }


  onSaveAndNext() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    Get.toNamed(RoutesName.thirdRoomFormScreen);

  }


}