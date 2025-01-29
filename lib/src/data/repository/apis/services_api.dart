import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/services_screen/model/services_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  static final time = DateTime.now().microsecondsSinceEpoch.toString();

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
    required List<ServiceFAQ> serviceFAQ, // Pass a list of image files
  }) async {
    AppHelperFunction.showCenterCircularIndicator(true);

    try {
      List<String> imageUrls = [];

      // Step 2: Prepare the data to save in Firestore
      final item = ServicesModel(
        servicesName: servicesName,
        description: description,
        latitude: latitude,
        longitude: longitude,
        serviceFAQ: serviceFAQ,
        sId: '',
        address: address,
        landmark: landmark,
        city: city,
        state: state,
        image: imageUrls,
        // Use the uploaded image URLs
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
            String imageUrl = await uploadImageToFirebase(imageFile, docRef.id);
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
            .update({'s_id': docRef.id, 'image': imageUrls}).whenComplete(() {
          Navigator.pop(Get.context!);
          AppLoggerHelper.info(
              "Document added successfully with ID: ${docRef.id}");
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

  static Future<String> uploadImageToFirebase(File imageFile, docId) async {
    try {
      final reference = FirebaseStorage.instance.ref().child(
          'DevServicesImages/${user.uid}/$docId/${DateTime.now().millisecondsSinceEpoch}.jpg');
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

  static Future<bool> submitServicesReviewData({
    required String rating,
    required String userReview,
    required String rId,
  }) async {
    // Get a reference to Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Fetch the user document ID
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? userDocId = preferences.getString('userDocId');

      //  Create the review data map
      final reviewData = {
        "date": DateTime.now().toIso8601String(),
        "rating": rating,
        "review": userReview,
        "user": firestore
            .collection('DevUser')
            .doc(userDocId)
            .path, // Correct user reference
      };

      // // Update the 'reviews' field in the RoomReview collection
      await firestore.collection('DevServicesReview').doc(rId).set({
        "reviews": FieldValue.arrayUnion([reviewData]),
        // Add to an array of reviews
      }, SetOptions(merge: true)); // Avoid overwriting the document
      AppLoggerHelper.info("Document updated successfully");
      return true; // Return true when successful
    } catch (e) {
      // Catch any errors and handle them appropriately
      if (e is FirebaseException) {
        // Firestore-specific exception
        AppLoggerHelper.error("Firestore error: $e");
      } else {
        // Generic error
        AppLoggerHelper.error("General error: $e");
      }
      AppLoggerHelper.error("Error adding document: $e");
      return false; // Return false if an error occurs
    }
  }

  static Future<bool> updateServicesDetailsData({
    required String documentId,
    required String servicesName,
    required String description,
    required String address,
    required String landmark,
    required String city,
    required String state,
    required List<File> imageFiles,
    required List<ServiceFAQ> serviceFAQ,
    required List<String> imageUrlsList,
  }) async {
    AppHelperFunction.showCenterCircularIndicator(true);

    try {
      List<String> imageUrls = List.from(imageUrlsList);

      final updatedItem = {
        'servicesName': servicesName,
        'description': description,
        'serviceFAQ': serviceFAQ.map((faq) => faq.toJson()).toList(),
        'address': address,
        'landmark': landmark,
        'city': city,
        'state': state,
        'atUpdate': DateTime.now().toString(),
      };

      await FirebaseFirestore.instance
          .collection("DevServicesCollection")
          .doc(documentId)
          .update(updatedItem)
          .timeout(const Duration(seconds: 20), onTimeout: () {
        Navigator.pop(Get.context!);
        throw TimeoutException("The operation timed out");
      });

      if (imageFiles.isNotEmpty) {
        // Deleting old images
        for (String imageUrl in imageUrlsList) {
          await deleteImageFromFirebase(imageUrl);
        }

        imageUrls.clear();

        // Uploading new images
        for (File imageFile in imageFiles) {
          try {
            String imageUrl =
                await uploadImageToFirebase(imageFile, documentId);
            imageUrls.add(imageUrl);
          } catch (e) {
            AppLoggerHelper.error("Error uploading image: \$e");
            Navigator.pop(Get.context!);
            return false;
          }
        }

        await FirebaseFirestore.instance
            .collection("DevServicesCollection")
            .doc(documentId)
            .update({'image': imageUrls}).whenComplete(() {
          Navigator.pop(Get.context!);
          AppLoggerHelper.info("Document updated successfully");
        });
      } else {
        Navigator.pop(Get.context!);
        AppLoggerHelper.info('No images to update');
      }
      return true;
    } catch (e) {
      Navigator.pop(Get.context!);
      AppLoggerHelper.error("Error updating document: \$e");
      return false;
    }
  }

  static Future<bool> updateServicesMapData({
    required String latitude,
    required String longitude,
    required String documentId,
  }) async {
    AppHelperFunction.showCenterCircularIndicator(true);

    try {
      final updatedItem = {
        'latitude': latitude,
        'longitude': longitude,
        'atUpdate': DateTime.now().toString(),
      };

      await FirebaseFirestore.instance
          .collection("DevServicesCollection")
          .doc(documentId)
          .update(updatedItem)
          .timeout(const Duration(seconds: 2000), onTimeout: () {
        Navigator.pop(Get.context!);
        throw TimeoutException("The operation timed out");
      });

      AppLoggerHelper.info("Document updated successfully");
      return true;
    } catch (e) {
      Navigator.pop(Get.context!);
      AppLoggerHelper.error("Error updating document: $e");
      return false;
    }
  }

  static Future<void> deleteImageFromFirebase(String imageUrl) async {
    try {
      final ref = storage.refFromURL(imageUrl);
      await ref.delete();
      AppLoggerHelper.info("Image deleted successfully");
    } catch (e) {
      AppLoggerHelper.info("data in not delete $e");
    }
  }

  static Future<bool> deleteServiceData(
      {required String documentId, required List<String> imageUrls}) async {
    try {
      // Delete images from storage
      for (String imageUrl in imageUrls) {
        await deleteImageFromFirebase(imageUrl);
      }

      // Delete Firestore document
      await FirebaseFirestore.instance
          .collection("DevServicesCollection")
          .doc(documentId)
          .delete();

      AppLoggerHelper.info("Document and images deleted successfully");
      return true;
    } catch (e) {
      AppLoggerHelper.error("Error deleting document and images: $e");
      return false;
    }
  }
}
