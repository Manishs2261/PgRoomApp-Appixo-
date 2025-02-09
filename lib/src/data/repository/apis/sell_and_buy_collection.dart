import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../flavor_config.dart';
import '../../../features/Home_fitter_new/new_search_home/controller.dart';
import '../../../features/sell_and_buy_screen/model/buy_and_sell_model.dart';
import '../../../utils/logger/logger.dart';
import '../../data_constant.dart';

class SellAndBuyApis {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //to return current user info
  static User get user => auth.currentUser!;
  final userUid = user.uid;

  // for accessing cloud firestorm database
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // final userRef = FirebaseFirestore.instance
  //     .collection('DevUser')
  //     .doc(FirebaseAuth.instance.currentUser!.uid);

  // for storing Image  information
  static FirebaseStorage storage = FirebaseStorage.instance;

  //current date and time
  static final time = DateTime.now().microsecondsSinceEpoch.toString();

  static var id = '';
  static var imageUrl = '';
  static String coverImageFileName = '';

  //delete a data
  static Future<void> deleteOldGoodsData(
      String deleteId, coverImageUrl, menuImageUrl) async {
    try {
      //delete a Firestorm
      DocumentReference documentReference = firebaseFirestore
          .collection('userOldGoodsList')
          .doc(user.uid)
          .collection(user.uid)
          .doc(deleteId);

      DocumentReference documentReference1 =
          firebaseFirestore.collection('oldGoods').doc(deleteId);

      // Delete the document.
      await documentReference.delete();
      await documentReference1.delete();
      //
      //   // delete a firestorm image data
      final refCoverImage = storage.refFromURL(coverImageUrl);
      await refCoverImage.delete();
    } catch (e) {
      AppLoggerHelper.info("data in not delete $e");
    }
  }

  static final homeController = Get.put(HomeController());

  static Future<bool> addSellAndBuyData({
    required String itemName,
    required String price,
    required String description,
    required String address,
    required String landmark,
    required String city,
    required String state,
    required List<File> imageFiles, // Pass a list of image files
  }) async {
    AppHelperFunction.showCenterCircularIndicator(true);

    if (homeController.user.isNotEmpty) {
      try {
        List<String> imageUrls = [];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? userDocId = preferences.getString('userDocId');
        final item = BuyAndSellModel(
            itemName: itemName,
            price: price,
            description: description,
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
            sabId: user.uid,
            uId: user.uid,
            userDocId: userDocId,
            mobileNumber: homeController.user.first.phone,
            userName: homeController.user.first.name,
            userImage: homeController.user.first.image);

        // Step 3: Add the data to Firestore
        try {
          DocumentReference docRef = await FirebaseFirestore.instance
              .collection(
                  "${AppEnvironment.environmentName}_${CollectionName.sellAndBuy}")
              .add(item.toJson())
              .timeout(const Duration(seconds: 2000), onTimeout: () {
            Navigator.pop(Get.context!);
            throw TimeoutException(
                "The operation timed out after 2000 seconds");
          });

          for (File imageFile in imageFiles) {
            try {
              String imageUrl =
                  await uploadImageToFirebase(imageFile, docRef.id);
              imageUrls.add(imageUrl);
            } catch (e) {
              AppLoggerHelper.error("Error uploading image: $e");
              Navigator.pop(Get.context!);
              return false; // If any image fails to upload, return false
            }
          }

          // Update the document with its ID
          await FirebaseFirestore.instance
              .collection(
                  "${AppEnvironment.environmentName}_${CollectionName.sellAndBuy}")
              .doc(docRef.id)
              .update({'sab_id': docRef.id, 'image': imageUrls}).whenComplete(
                  () {
            Navigator.pop(Get.context!);
            AppLoggerHelper.info(
                "Document added successfully with ID: ${docRef.id}");
          });

          try {
            // Add the new room ID to the roomId list
            await FirebaseFirestore.instance
                .collection(
                    "${AppEnvironment.environmentName}_${CollectionName.user}")
                .doc(userDocId)
                .update({
              'roomId': FieldValue.arrayUnion([docRef.id]),
            });

            AppLoggerHelper.info(
                "Room ID ${docRef.id} successfully added to user's roomId list.");
          } catch (e) {
            Navigator.pop(Get.context!);
            AppLoggerHelper.error("Error updating user's roomId: $e");
            return false; // Handle errors gracefully
          }
          Navigator.pop(Get.context!);
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
    } else {
      Navigator.pop(Get.context!);
      AppHelperFunction.showFlashbar("Something went wrong. Please try again.");
      AppLoggerHelper.error("Something went wrong. Please try again.");
      return false;
    }
  }

  static Future<String> uploadImageToFirebase(File imageFile, docId) async {
    try {
      final reference = FirebaseStorage.instance.ref().child(
          '${AppEnvironment.environmentName}_${CollectionName.sellAndBuy}/${user.uid}/$docId/${DateTime.now().millisecondsSinceEpoch}.jpg');
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

  static Future<bool> updateSellAndBuyData({
    required String documentId,
    required String itemName,
    required String price,
    required String description,
    required List<File> imageFiles,
    required List<String> imageUrlsList,
    required String address,
    required String landmark,
    required String city,
    required String state,
  }) async {
    AppHelperFunction.showCenterCircularIndicator(true);

    try {
      List<String> imageUrls = List.from(imageUrlsList);

      final updatedItem = {
        'itemName': itemName,
        'price': price,
        'description': description,
        'address': address,
        'landmark': landmark,
        'city': city,
        'state': state,
        'atUpdate': DateTime.now().toString(),
      };

      await FirebaseFirestore.instance
          .collection(
              "${AppEnvironment.environmentName}_${CollectionName.sellAndBuy}")
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
            .collection(
                "${AppEnvironment.environmentName}_${CollectionName.sellAndBuy}")
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

  static Future<void> deleteImageFromFirebase(String imageUrl) async {
    try {
      final ref = storage.refFromURL(imageUrl);
      await ref.delete();
      AppLoggerHelper.info("Image deleted successfully");
    } catch (e) {
      AppLoggerHelper.info("data in not delete $e");
    }
  }

  static Future<bool> deleteSellAndBuyData(
      {required String documentId, required List<String> imageUrls}) async {
    AppHelperFunction.showCenterCircularIndicator(true);
    try {
      // Delete images from storage
      for (String imageUrl in imageUrls) {
        await deleteImageFromFirebase(imageUrl);
      }

      // Delete Firestore document
      await FirebaseFirestore.instance
          .collection(
              "${AppEnvironment.environmentName}_${CollectionName.sellAndBuy}")
          .doc(documentId)
          .delete();

      AppLoggerHelper.info("Document and images deleted successfully");
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      return true;
    } catch (e) {
      AppLoggerHelper.error("Error deleting document and images: $e");
      return false;
    }
  }
}
