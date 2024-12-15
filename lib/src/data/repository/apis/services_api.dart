import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pgroom/src/features/services_screen/model/services_model.dart';

import '../../../utils/helpers/helper_function.dart';
import '../../../utils/logger/logger.dart';

class ServicesApis {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //to return current user info
  static User get user => auth.currentUser!;

  // for accessing cloud firestorm database
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // for storing Image  information
  static FirebaseStorage storage = FirebaseStorage.instance;

  //current date and time
  static final time = DateTime
      .now()
      .microsecondsSinceEpoch
      .toString();




  static Future<bool> addServicesData({
    required String servicesName,
    required String latitude,
    required String longitude,
    required String description,
    required String address,
    required String landmark,
    required String city,
    required String state,
    required List<File> imageFiles,
    required List<ServiceFAQ> serviceFAQ,// Pass a list of image files
  }) async {
    AppHelperFunction.showCenterCircularIndicator(true);

    try {

      List<String> imageUrls = [];

      // Step 2: Prepare the data to save in Firestore
      final item = ServicesModel(
       servicesName: servicesName,
        description: description,
        latitude: latitude,
        longitude:longitude ,
        serviceFAQ: serviceFAQ,
        sId: '',
        address: address,
        landmark: landmark,
        city: city,
        state: state,
        image: imageUrls, // Use the uploaded image URLs
        atCreate: DateTime.now().toString(),
        atUpdate: DateTime.now().toString(),
        isDelete: false,
        report: [],
        disable: false,
        uId: user.uid,
      );

      // Step 3: Add the data to Firestore
      try {
        DocumentReference docRef = await FirebaseFirestore.instance
            .collection("DevServicesCollection")
            .add(item.toJson())
            .timeout(const Duration(seconds: 2000), onTimeout: () {
          Navigator.pop(Get.context!);
          throw TimeoutException("The operation timed out after 2000 seconds");
        });

        for (File imageFile in imageFiles) {
          try {
            String imageUrl = await uploadImageToFirebase(imageFile,docRef.id);
            imageUrls.add(imageUrl);
          } catch (e) {
            AppLoggerHelper.error("Error uploading image: $e");
            Navigator.pop(Get.context!);
            return false; // If any image fails to upload, return false
          }
        }

        // Update the document with its ID
        await FirebaseFirestore.instance
            .collection("DevServicesCollection")
            .doc(docRef.id)
            .update({'s_id': docRef.id , 'image': imageUrls}).whenComplete(() {
          Navigator.pop(Get.context!);
          AppLoggerHelper.info("Document added successfully with ID: ${docRef.id}");
        });

        return true; // Successfully saved data
      } catch (e) {
        Navigator.pop(Get.context!);

        if (e is TimeoutException) {
          AppHelperFunction.showFlashbar('Timeout error: ${e.message}');
          AppLoggerHelper.info("Timeout error: ${e.message}");
        } else if (e is FirebaseException) {
          AppHelperFunction.showFlashbar('Firestore error: ${e.message}');
          AppLoggerHelper.info("Firestore error: ${e.message}");
        } else {
          AppHelperFunction.showFlashbar('General error: ${e}');
          AppLoggerHelper.info("General error: ${e}");
        }
        return false; // Return false on Firestore save failure
      }
    } catch (e) {
      Navigator.pop(Get.context!);
      AppLoggerHelper.error("Error adding document: $e");
      return false; // Return false for general errors
    }
  }

  static Future<String> uploadImageToFirebase(File imageFile , docId) async {
    try {
      final reference = FirebaseStorage.instance
          .ref()
          .child('servicesImages/${user.uid}/$docId/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      AppLoggerHelper.info("Image uploaded successfully: $downloadUrl");
      return downloadUrl;
    } catch (e) {
      AppLoggerHelper.error("Image upload failed: $e");
      throw Exception("Image upload failed");
    }
  }


}