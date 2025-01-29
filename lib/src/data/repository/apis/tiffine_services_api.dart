import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/user_apis.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/Home_fitter_new/new_search_home/controller.dart';
import '../../../features/foods_screen_new/model/food_model.dart';
import '../../../model/tiffin_services_model/tiffen_services_model.dart';
import '../../../utils/helpers/helper_function.dart';
import '../../../utils/logger/logger.dart';

class TiffineServicesApis {
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

  static var tiffineServicesId = '';
  static var tiffineServicesCoverImageUrl = '';
  static var foodMenuImageUrl = '';
  static var tiffineReviewSubmitId = "";

  static var starOneTiffine;

  static var starTwoTiffine;

  static var starThreeTiffine;

  static var starFourTiffine;

  static var starFiveTiffine;

  static var averageRatingTiffine;
  static var totalNumberOfStarTiffine;

  static String coverImageFileName = '';
  static String menuImageFileName = '';

//==============Tiffine Services Apis =====================

  // create a tiffine services data base for main home collection
  static Future<void> addYourTiffineServices(coverImage, servicesName, address,
      price, menuImage, contactNumber, latu, lang) async {
    // model class
    final tiffineList = TiffineServicesModel(
        address: address,
        averageRating: 0.0,
        foodImage: coverImage,
        foodPrice: price,
        menuImage: menuImage,
        numberOfRating: 0,
        servicesName: servicesName,
        contactNumber: contactNumber,
        latitude: latu,
        longitude: lang,
        coverImageId: coverImageFileName,
        menuImageId: menuImageFileName);

    // store main list data
    return await firebaseFirestore
        .collection("tiffineServicesCollection")
        .doc(tiffineServicesId)
        .set(tiffineList.toJson());
  }

  // create a tiffine services data base for user data base
  static Future<void> addYourTiffineServicesUserAccount(
      coverImage,
      servicesName,
      address,
      price,
      menuImage,
      contactNumber,
      latu,
      lang) async {
    // model class
    final tiffineList = TiffineServicesModel(
        address: address,
        averageRating: 0.0,
        foodImage: coverImage,
        foodPrice: price,
        menuImage: menuImage,
        numberOfRating: 0,
        servicesName: servicesName,
        contactNumber: contactNumber,
        latitude: latu,
        longitude: lang,
        coverImageId: coverImageFileName,
        menuImageId: menuImageFileName);
    // user list collection
    return await firebaseFirestore
        .collection("userTiffineCollection")
        .doc(user.uid)
        .collection(user.uid)
        .add(tiffineList.toJson())
        .then((value) {
      AppLoggerHelper.info(value.id);
      // for store unique item id
      tiffineServicesId = value.id;
      return null;
    });
  }

  // upload Cover image data in firebase database
  static Future uploadTiffineServicesCoverImage(File imageFile) async {
    try {
      final reference = storage
          .ref()
          .child('tiffineServices/${user.uid}/${DateTime.now()}.jpg');

      String updatedPath = reference
          .toString()
          .substring(0, reference.toString().lastIndexOf(')'));
      List<String> pathSegments = updatedPath.split('/');
      coverImageFileName = pathSegments.last;

      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      tiffineServicesCoverImageUrl = await snapshot.ref.getDownloadURL();
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded : $e");
    }
  }

  // upload  Menu image data in firebase database
  static Future uploadMenuImage(File imageFile) async {
    try {
      final reference =
          storage.ref().child('foodMenu/${user.uid}/${DateTime.now()}.jpg');

      String updatedPath = reference
          .toString()
          .substring(0, reference.toString().lastIndexOf(')'));
      List<String> pathSegments = updatedPath.split('/');
      menuImageFileName = pathSegments.last;
      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      foodMenuImageUrl = await snapshot.ref.getDownloadURL();
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
  }

//=========================================================

//==============Edit  Tiffine Services Apis ===============

  //update tiffine service  data
  static Future<void> updateTiffineServicesData(servicesName, address, price,
      itemId, contactNumber, latitude, longitude) async {
    //home list collection data base
    await firebaseFirestore
        .collection("tiffineServicesCollection")
        .doc(itemId)
        .update({
      'foodPrice': price,
      'address': address,
      'servicesName': servicesName,
      'contactNumber': contactNumber,
      'longitude': longitude,
      'latitude': latitude
    });
//user personal collection data base
    await firebaseFirestore
        .collection("userTiffineCollection")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({
      'foodPrice': price,
      'address': address,
      'servicesName': servicesName,
      'contactNumber': contactNumber,
      'longitude': longitude,
      'latitude': latitude
    });
  }

  // update cover Image data
  static Future<void> updateTiffineCoverImage(
      File file, String itemId, String coverImageFileName) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    AppLoggerHelper.info('Extension :$ext');

    // storage file ref with path
    final ref =
        storage.ref().child('tiffineServices/${user.uid}/$coverImageFileName');

    // uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      AppLoggerHelper.info(
          'Data Transferred :${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firebase  database
    final tiffineUrl = await ref.getDownloadURL();

    //rent collection data base
    await firebaseFirestore
        .collection('tiffineServicesCollection')
        .doc(itemId)
        .update({
      'foodImage': tiffineUrl,
    });
//user personal collection data base
    await firebaseFirestore
        .collection("userTiffineCollection")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'foodImage': tiffineUrl});
  }

  // update cover Image data
  static Future<void> updateTiffineMenuImage(
      File file, String itemId, String menuImageFileName) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    AppLoggerHelper.info('Extension :$ext');

    // storage file ref with path
    final ref = storage.ref().child('foodMenu/${user.uid}/$menuImageFileName');

    // uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      AppLoggerHelper.info(
          'Data Transferred :${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firebase  database
    final tiffineMenuUrl = await ref.getDownloadURL();

    //rent collection data base
    await firebaseFirestore
        .collection('tiffineServicesCollection')
        .doc(itemId)
        .update({
      'menuImage': tiffineMenuUrl,
    });
//user personal collection data base
    await firebaseFirestore
        .collection("userTiffineCollection")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'menuImage': tiffineMenuUrl});
  }

//=========================================================

//============== Review Apis ==============================

  //get review id for check user a review submit or not
  static Future<String> getTiffineRatingSubmitIdData(itemId) async {
    var collection = firebaseFirestore
        .collection("loginUser")
        .doc(user.uid)
        .collection(auth.currentUser!.uid)
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId);
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    tiffineReviewSubmitId = data?['tiffineUserId'] ?? '';

    return tiffineReviewSubmitId;
  }

  // Rating and review create api
  static Future<void> createTiffineRatingAndReviewData(
      ratingStar, review, itemId) async {
    //This review data save in all viewer user
    await firebaseFirestore
        .collection("TiffineReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .add({
      'rating': ratingStar,
      'title': review,
      'currentDate': AppHelperFunction.getFormattedDate(DateTime.now()),
      'userName': UserApis.userName,
      'userImage': UserApis.userImage
    });

    // This review  data save in user account only
    await firebaseFirestore
        .collection("loginUser")
        .doc(user.uid)
        .collection(auth.currentUser!.uid)
        .doc(user.uid)
        .collection(auth.currentUser!.uid)
        .doc(itemId)
        .set({
      'tiffineUserId': itemId,
      'tiffineRating': ratingStar,
      'tiffineTitle': review,
      'currentDate': AppHelperFunction.getFormattedDate(DateTime.now()),
      'userName': UserApis.userName,
      'userImage': UserApis.userImage
    });
  }

  //add ratings in  user collection  and Tiffine list collection
  static Future<void> addRatingMainTiffineList(
      itemId, average, numberOfRating) async {
    //Tiffine collection data base
    await firebaseFirestore
        .collection("tiffineServicesCollection")
        .doc(itemId)
        .update({'averageRating': average, 'NumberOfRating': numberOfRating});
//user personal collection data base
    await firebaseFirestore
        .collection("userTiffineCollection")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'averageRating': average, 'NumberOfRating': numberOfRating});
  }

  //============= Rating bar Summary Apis===================

  //Get in user rating bar summary data
  static Future<void> getRatingBarSummaryTiffineData(itemId) async {
    var collection = firebaseFirestore
        .collection("TiffineReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .doc(itemId)
        .collection("reviewSummary")
        .doc(itemId);
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    starOneTiffine = data?['ratingStar01'] ?? 0;
    starTwoTiffine = data?['ratingStar02'] ?? 0;
    starThreeTiffine = data?['ratingStar03'] ?? 0;
    starFourTiffine = data?['ratingStar04'] ?? 0;
    starFiveTiffine = data?['ratingStar05'] ?? 0;
    totalNumberOfStarTiffine = data?['totalNumberOfStar'] ?? 0;
    averageRatingTiffine = data?['averageRating'] ?? 0.0;
  }

  //save Rating Summary data
  static Future<void> saveRatingBarSummaryTiffineData(
      itemId, one, two, three, four, five, avg, totalNumberOfStar) async {
    //Rating Summary data
    await firebaseFirestore
        .collection("TiffineReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .doc(itemId)
        .collection("reviewSummary")
        .doc(itemId)
        .set({
      'ratingStar01': one,
      'ratingStar02': two,
      'ratingStar03': three,
      'ratingStar04': four,
      'ratingStar05': five,
      'totalNumberOfStar': totalNumberOfStar,
      'averageRating': avg,
    });
  }

  //update Rating bar summary data
  static Future<void> updateRatingBarStarSummaryTiffineData(
      itemId, avg, totalNumberOfStar) async {
    //Rating Summary data
    await firebaseFirestore
        .collection("TiffineReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .doc(itemId)
        .collection("reviewSummary")
        .doc(itemId)
        .update({
      'totalNumberOfStar': totalNumberOfStar,
      'averageRating': avg,
    }).then((value) {
      AppLoggerHelper.info("Update Rating bar average successfully");
    }).onError((error, stackTrace) {
      AppLoggerHelper.error("Update Rating bar average successfully");
    });
  }

  //delete a data

  static Future<void> deleteTiffineServicesData(
      String deleteId, coverImageUrl, menuImageUrl) async {
    try {
      //delete a Firestorm
      DocumentReference documentReference = firebaseFirestore
          .collection('userTiffineCollection')
          .doc(user.uid)
          .collection(user.uid)
          .doc(deleteId);

      DocumentReference documentReference1 = firebaseFirestore
          .collection('tiffineServicesCollection')
          .doc(deleteId);

      //Rating Summary data
      await firebaseFirestore
          .collection("TiffineReview")
          .doc("reviewCollection")
          .collection(deleteId)
          .doc(deleteId)
          .collection("reviewSummary")
          .doc(deleteId)
          .delete();

      //   // This review  data save in user account only
      // This review  data save in user account only
      await firebaseFirestore
          .collection("loginUser")
          .doc(user.uid)
          .collection(auth.currentUser!.uid)
          .doc(deleteId)
          .delete();
      //
      //   //delete a review collection data
      //
      final batch = firebaseFirestore.batch();
      var collection = firebaseFirestore
          .collection("TiffineReview")
          .doc("reviewCollection")
          .collection(deleteId);
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      //
      //   // Delete the document.
      await documentReference.delete();
      await documentReference1.delete();
      //
      //   // delete a firestorm image data
      final refCoverImage = storage.refFromURL(coverImageUrl);
      await refCoverImage.delete();

      final refMenuImage = storage.refFromURL(menuImageUrl);
      await refMenuImage.delete();
    } catch (e) {
      AppLoggerHelper.info("data in not delete $e");
    }
  }

  static Future<String> uploadImageToFirebase(File imageFile, docId) async {
    try {
      final reference = FirebaseStorage.instance.ref().child(
          'DevFoodCollection/${user.uid}/$docId/${DateTime.now().millisecondsSinceEpoch}.jpg');
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

  static final homeController = Get.put(HomeController());

  static Future<bool> addFoodData(
      {
        required String foodShopName,
      required String typeOfShop,
      required String description,
      required String address,
      required String landmark,
      required String city,
      required List<File> imageFiles,
      required String state,
      required String latitude,
      required String longitude,
      required String breakfastCost,
      required String lunchOrDinnerCost,
      required String lunchAndDinnerCost,
      required String breakfastAndLunchOrDinnerCost,
      required List<SubscriptionList> subscriptionList,
      required String thaliCost,
      required String aCupOfRice,
      required String roti,
      required String sabji,
      required String dal,
      required List<DailyItemList> dailyItemList,
      required List<RestructureMenuList> restructureItemList,
      required List<FoodFAQ> foodFAQ,
      required List<String> mealRule,
      required String typeFood

      }) async {
    AppHelperFunction.showCenterCircularIndicator(true);

    if (homeController.user.isNotEmpty) {
      try {
        List<String> imageUrls = [];
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? userDocId = preferences.getString('userDocId');

        final item = FoodModel(
            breakfastCost: breakfastCost,
            dailyItemList: dailyItemList,
            dal: dal,
            description: description,
            fAQ: foodFAQ,
            fId: '',
            lunchAndDinnerCost: lunchOrDinnerCost,
            lunchOrDinnerCost: lunchAndDinnerCost,
            messRules: mealRule,
            roti: roti,
            sabji: sabji,
            shopName: foodShopName,
            thaliCost: thaliCost,
            typeOfShop: typeOfShop,
            imageList: imageUrls,
            aCupOfRice: aCupOfRice,
            address: address,
            breakfastAndLunchOrDinnerCost: breakfastAndLunchOrDinnerCost,
            longitude: longitude,
            latitude: latitude,
            landmark: landmark,
            city: city,
            state: state,
            atCreate: DateTime.now().toString(),
            atUpdate: DateTime.now().toString(),
            isDelete: false,
            report: [],
            disable: false,
            uId: user.uid,
            restructureMenuList: restructureItemList,
            subscriptionList: subscriptionList,
            foodCategory: typeFood,
            userDocId: userDocId,
            mobileNumber: homeController.user.first.phone,
            userName: homeController.user.first.name,
            userImage: homeController.user.first.image);

        // Step 3: Add the data to Firestore
        try {
          DocumentReference docRef = await FirebaseFirestore.instance
              .collection("DevFoodCollection")
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
              .collection("DevFoodCollection")
              .doc(docRef.id)
              .update({'f_id': docRef.id, 'imageList': imageUrls}).whenComplete(
                  () {
            AppLoggerHelper.info(
                "Document added successfully with ID: ${docRef.id}");
          });

          try {
            // Add the new room ID to the roomId list
            await FirebaseFirestore.instance
                .collection("DevUser")
                .doc(userDocId)
                .update({
              'foodId': FieldValue.arrayUnion([docRef.id]),
            });

            AppLoggerHelper.info(
                "Food ID ${docRef.id} successfully added to user's roomId list.");
          } catch (e) {
            Navigator.pop(Get.context!);
            AppLoggerHelper.error("Error updating user's foodId: $e");
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
            AppLoggerHelper.info("General error: $e");
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


  static Future<void> submitFoodReport(
      {required String reportReason, required String docId}) async {
    try {
      await FirebaseFirestore.instance
          .collection("DevFoodCollection")
          .doc(docId)
          .update({
        'report': FieldValue.arrayUnion([
          {
            'date': DateTime.now().toString(),
            'description': reportReason,
            'userRef': FirebaseFirestore.instance
                .collection('DevUser')
                .doc(FirebaseAuth.instance.currentUser!.uid)
          }
        ])
      }).then((value) {
        Navigator.pop(Get.context!);
        AppLoggerHelper.info("Document updated successfully");
      }).catchError((error) {
        AppLoggerHelper.error("Failed to update document: $error");
      });
    } catch (e) {
      AppHelperFunction.showFlashbar(e.toString());
      AppLoggerHelper.error("Error adding document: $e");
    }
  }


  static Future<bool> submitFoodReviewData({
    required String rating,
    required String userReview,
    required String fId,
  }) async {
    // Get a reference to Firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Fetch the user document ID
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? userDocId =   preferences.getString('userDocId');

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
      await firestore.collection('DevFoodReview').doc(fId).set({
        "reviews": FieldValue.arrayUnion([reviewData]),
        // Add to an array of reviews
      }, SetOptions(merge: true)); // Avoid overwriting the document
      AppLoggerHelper.info("Document updated successfully");
      return true;
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


  static Future<bool> updateFoodData({
    required String documentId,
    required String foodShopName,
    required String typeOfShop,
    required String description,
    required String address,
    required String landmark,
    required String city,
    required List<File> imageFiles,
    required String state,
    required String latitude,
    required String longitude,
    required String breakfastCost,
    required String lunchOrDinnerCost,
    required String lunchAndDinnerCost,
    required String breakfastAndLunchOrDinnerCost,
    required List<SubscriptionList> subscriptionList,
    required String thaliCost,
    required String aCupOfRice,
    required String roti,
    required String sabji,
    required String dal,
    required List<DailyItemList> dailyItemList,
    required List<RestructureMenuList> restructureItemList,
    required List<FoodFAQ> foodFAQ,
    required List<String> mealRule,
    required String foodCategory,
    required List<String> imageUrlsList,
  }) async {
    AppHelperFunction.showCenterCircularIndicator(false);

    try {
      List<String> imageUrls = List.from(imageUrlsList);

      final updatedItem = {
         'shopName': foodShopName,
         'typeOfShop': typeOfShop,
         'description': description,
         'address': address,
         'landmark': landmark,
        'city': city,
         'state': state,
         'foodCategory': foodCategory,
         'breakfastCost': breakfastCost,
         'breakfastAndLunchOrDinnerCost': breakfastAndLunchOrDinnerCost,
         'lunchOrDinnerCost': lunchOrDinnerCost,
         'lunchAndDinnerCost': lunchAndDinnerCost,
        'SubscriptionList': subscriptionList.map((item) => item.toJson()).toList(),
         'DailyItemList': dailyItemList.map((item) => item.toJson()).toList(),
        'RestructureMenuList': restructureItemList.map((item) => item.toJson()).toList(),
         'messRules': mealRule,
         'FAQ': foodFAQ.map((item) => item.toJson()).toList(),
        'latitude': latitude,
        'longitude': longitude,
        'aCupOfRice': aCupOfRice,
        'thaliCost': thaliCost,
        'sabji': sabji,
        'dal': dal,
        'roti': roti,
        'atUpdate': DateTime.now().toIso8601String(),
      };

      await FirebaseFirestore.instance
          .collection("DevFoodCollection")
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
            .collection("DevFoodCollection")
            .doc(documentId)
            .update({'imageList': imageUrls}).whenComplete(() {
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

  static Future<bool> deleteRoomData(
      {required String documentId, required List<String> imageUrls}) async {
    try {
      // Delete images from storage
      for (String imageUrl in imageUrls) {
        await deleteImageFromFirebase(imageUrl);
      }

      // Delete Firestore document
      await FirebaseFirestore.instance
          .collection("DevFoodCollection")
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



