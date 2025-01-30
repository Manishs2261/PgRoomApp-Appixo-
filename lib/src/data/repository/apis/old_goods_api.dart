import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/features/foods_screen_new/model/food_model.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/Home_fitter_new/new_search_home/controller.dart';
import '../../../features/sell_and_buy_screen/model/buy_and_sell_model.dart';
import '../../../model/old_goods_model/old_goods_model.dart';
import '../../../utils/logger/logger.dart';

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

//==============Tiffine Services Apis =====================

  // create a tiffine services data base for main home collection
  static Future<void> addYourOldGoods(
      image, name, address, price, postdate, contactNumber) async {
    // model class
    final oldGoodsList = OldGoodsModel(
      address: address,
      image: image,
      name: name,
      contactNumber: contactNumber,
      postDate: postdate,
      price: price,
      coverImageId: coverImageFileName,
    );

    // store main list data
    return await firebaseFirestore
        .collection("oldGoods")
        .doc(id)
        .set(oldGoodsList.toJson());
  }

  // create a tiffine services data base for user data base
  static Future<void> addYourOldGoodsUserAccount(
      image, name, address, price, postdate, contactNumber) async {
    // model class
    final oldGoodsList = OldGoodsModel(
        address: address,
        image: image,
        name: name,
        contactNumber: contactNumber,
        postDate: postdate,
        price: price,
        coverImageId: coverImageFileName);

    // user list collection
    return await firebaseFirestore
        .collection("userOldGoodsList")
        .doc(user.uid)
        .collection(user.uid)
        .add(oldGoodsList.toJson())
        .then((value) {
      AppLoggerHelper.info(value.id);
      // for store unique item id
      id = value.id;
      return null;
    });
  }

  // upload Cover image data in firebase database
  static Future uploadOldGoodsImage(File imageFile) async {
    try {
      final reference = storage
          .ref()
          .child('oldGoodsImage/${user.uid}/${DateTime.now()}.jpg');

      String updatedPath = reference
          .toString()
          .substring(0, reference.toString().lastIndexOf(')'));
      List<String> pathSegments = updatedPath.split('/');
      coverImageFileName = pathSegments.last;

      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      imageUrl = await snapshot.ref.getDownloadURL();
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
  }

//=========================================================

//==============Edit  Tiffine Services Apis ===============

  //update tiffine service  data
  static Future<void> updateOldGoodsData(
      name, address, price, itemId, contactNumber) async {
    //home list collection data base
    await firebaseFirestore.collection("oldGoods").doc(itemId).update({
      'price': price,
      'address': address,
      'name': name,
      'contactNumber': contactNumber
    });
//user personal collection data base
    await firebaseFirestore
        .collection("userOldGoodsList")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({
      'price': price,
      'address': address,
      'name': name,
      'contactNumber': contactNumber
    });
  }

  // update cover Image data
  static Future<void> updateOldGoodsImage(
      File file, String itemId, String coverImageFileName) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    AppLoggerHelper.info('Extension :$ext');

    // storage file ref with path
    final ref =
        storage.ref().child('oldGoodsImage/${user.uid}/$coverImageFileName');

    // uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      AppLoggerHelper.info(
          'Data Transferred :${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firebase  database
    final imageUrl = await ref.getDownloadURL();

    //rent collection data base
    await firebaseFirestore.collection('oldGoods').doc(itemId).update({
      'image': imageUrl,
    });
//user personal collection data base
    await firebaseFirestore
        .collection("userOldGoodsList")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'image': imageUrl});
  }

//=========================================================

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
              .collection("DevBuyAndSellCollection")
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
              .collection("DevBuyAndSellCollection")
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
                .collection("DevUser")
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
          'buyAndSellImages/${user.uid}/$docId/${DateTime.now().millisecondsSinceEpoch}.jpg');
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
          .collection("DevBuyAndSellCollection")
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
            .collection("DevBuyAndSellCollection")
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
          .collection("DevBuyAndSellCollection")
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
