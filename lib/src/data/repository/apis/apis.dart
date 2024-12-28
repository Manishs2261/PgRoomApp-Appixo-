import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pgroom/src/data/repository/apis/user_apis.dart';
import 'package:pgroom/src/features/Rooms_screen_new/model/room_model.dart';
import 'package:pgroom/src/model/user_rent_model/user_rent_model.dart';
import 'package:pgroom/src/utils/logger/logger.dart';

import '../../../utils/helpers/helper_function.dart';

class ApisClass {
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

  static var coverImageDownloadUrl;
  static var userRentId = "";
  static var otherDownloadUrl;
  static var reviewId = "";
  static var starOne;
  static var starTwo;
  static var starThree;
  static var starFour;
  static var starFive;
  static var averageRating;
  static var totalNumberOfStar;
  static UserRentModel model = UserRentModel();
  static List<UserRentModel> allDataList = [];
  static String coverImageFileId = '';

  //============ Post Room  Data Apis =====================

  //upload data in firebase for home screen list
  // in list all data in one collection
  static Future rentDetailsHomeList(
    coverImage,
    houseName,
    address,
    cityName,
    landMark,
    contactNumber,
    bhk,
    roomType,
    singlePrice,
    doublePrice,
    triplePrice,
    fourPrice,
    familyPrice,
    restrictedTime,
    numberOfRooms,
    wifi,
    bed,
    chair,
    table,
    fan,
    gadda,
    light,
    locker,
    bedSheet,
    washingMachine,
    parking,
    electricityBill,
    waterBill,
    flexible,
    cooking,
    cookingType,
    boyAllow,
    girlAllow,
    familyMember,
    attachBathRoom,
    shareAbleBathRoom,
    like,
    latitude,
    longitude,
  ) async {
    final userHomeList = UserRentModel(
      coverImage: coverImage,
      houseName: houseName,
      address: address,
      city: cityName,
      landMark: landMark,
      contactNumber: contactNumber,
      bhkType: bhk,
      roomType: roomType,
      singlePersonPrice: singlePrice,
      doublePersonPrice: doublePrice,
      triplePersonPrice: triplePrice,
      fourPersonPrice: fourPrice,
      familyPrice: familyPrice,
      numberOfRooms: numberOfRooms,
      wifi: wifi,
      bed: bed,
      chair: chair,
      table: table,
      fan: fan,
      gadda: gadda,
      light: light,
      locker: locker,
      bedSheet: bedSheet,
      washingMachine: washingMachine,
      parking: parking,
      electricityBill: electricityBill,
      waterBill: waterBill,
      flexibleTime: flexible,
      cooking: cooking,
      cookingType: cookingType,
      boy: boyAllow,
      girls: girlAllow,
      familyMember: familyMember,
      like: like,
      restrictedTime: restrictedTime,
      attachBathRoom: attachBathRoom,
      shareAbleBathRoom: shareAbleBathRoom,
      average: 0.0,
      numberOfRating: 0,
      roomAvailable: true,
      userRentId: time,
      latitude: latitude,
      longitude: longitude,
      coverImageId: coverImageFileId,
    );
    return await firebaseFirestore
        .collection("rentCollection")
        .doc(userRentId)
        .set(userHomeList.toJson());
  }

  // this data store in data in user profile specific

  static Future<DocumentReference<Map<String, dynamic>>?> rentDetailsUser(
    coverImage,
    houseName,
    address,
    cityName,
    landMark,
    contactNumber,
    bhk,
    roomType,
    singlePrice,
    doublePrice,
    triplePrice,
    fourPrice,
    familyPrice,
    restrictedTime,
    numberOfRooms,
    wifi,
    bed,
    chair,
    table,
    fan,
    gadda,
    light,
    locker,
    bedSheet,
    washingMachine,
    parking,
    electricityBill,
    waterBill,
    flexible,
    cooking,
    cookingType,
    boyAllow,
    girlAllow,
    familyMember,
    attachBathRoom,
    shareAbleBathRoom,
    like,
    latitude,
    longitude,
  ) async {
    final userHomeList = UserRentModel(
        coverImage: coverImage,
        houseName: houseName,
        address: address,
        city: cityName,
        landMark: landMark,
        contactNumber: contactNumber,
        bhkType: bhk,
        roomType: roomType,
        singlePersonPrice: singlePrice,
        doublePersonPrice: doublePrice,
        triplePersonPrice: triplePrice,
        fourPersonPrice: fourPrice,
        familyPrice: familyPrice,
        numberOfRooms: numberOfRooms,
        wifi: wifi,
        bed: bed,
        chair: chair,
        table: table,
        fan: fan,
        gadda: gadda,
        light: light,
        locker: locker,
        bedSheet: bedSheet,
        washingMachine: washingMachine,
        parking: parking,
        electricityBill: electricityBill,
        waterBill: waterBill,
        flexibleTime: flexible,
        cooking: cooking,
        cookingType: cookingType,
        boy: boyAllow,
        girls: girlAllow,
        familyMember: familyMember,
        like: like,
        restrictedTime: restrictedTime,
        attachBathRoom: attachBathRoom,
        shareAbleBathRoom: shareAbleBathRoom,
        average: 0.0,
        numberOfRating: 0,
        roomAvailable: true,
        userRentId: time,
        latitude: latitude,
        longitude: longitude,
        coverImageId: coverImageFileId);

    return await firebaseFirestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .add(userHomeList.toJson())
        .then((value) {
      AppLoggerHelper.info(value.id);
      userRentId = value.id;
      return null;
    });
  }

  // upload  Cover image data in firebase database
  static Future uploadCoverImage(File imageFile) async {
    try {
      final reference =
          storage.ref().child('coverImage/${user.uid}/${DateTime.now()}.jpg');

      String updatedPath = reference
          .toString()
          .substring(0, reference.toString().lastIndexOf(')'));
      List<String> pathSegments = updatedPath.split('/');
      coverImageFileId = pathSegments.last;

      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      coverImageDownloadUrl = await snapshot.ref.getDownloadURL();
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
  }

//=========================================================

//============== Edit Post Room Data APis ===================

  //upload other images in firebase database
  static Future uploadOtherImage(File imageFile, itemId) async {
    try {
      final reference =
          storage.ref().child('otherImage/$itemId/${DateTime.now()}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      otherDownloadUrl = await snapshot.ref.getDownloadURL();
      //rent collection data base
      await firebaseFirestore
          .collection("OtherImageUserList")
          .doc(itemId)
          .collection("$itemId")
          .add({'OtherImage': otherDownloadUrl}).then((value) async {
        AppLoggerHelper.info(value.id);
        userRentId = value.id;
//user personal collection data base
        await firebaseFirestore
            .collection("OtherImageList")
            .doc(itemId)
            .collection("$itemId")
            .doc(userRentId)
            .set({'OtherImage': otherDownloadUrl});

        return null;
      });
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
  }

// update cover Image data
  static Future<void> updateCoverItemImage(
      File file, String itemId, String coverImageFileName) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    AppLoggerHelper.info('Extension :$ext');

    // storage file ref with path
    final ref =
        storage.ref().child('coverImage/${user.uid}/$coverImageFileName');

    // uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      AppLoggerHelper.info(
          'Data Transferred :${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firebase  database
    model.coverImage = await ref.getDownloadURL();

    //rent collection data base
    await firebaseFirestore
        .collection('rentCollection')
        .doc(itemId)
        .update({'coverImage': model.coverImage});
//user personal collection data base
    await firebaseFirestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'coverImage': model.coverImage});
  }

  //update Permission data
  static Future<void> updatePermissionData(
      itemId, cookingType, cooking, boy, girl, familyMember) async {
    //rent collection data base
    await firebaseFirestore.collection("rentCollection").doc(itemId).update({
      'girls': girl,
      'boy': boy,
      'cooking': cooking,
      'cookingType': cookingType,
      'familyMember': familyMember
    });
//user personal collection data base
    await firebaseFirestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({
      'girls': girl,
      'boy': boy,
      'cooking': cooking,
      'cookingType': cookingType,
      'familyMember': familyMember
    });
  }

  // update provide Facilities Data
  static Future<void> updateProvideFacilitiesData(
      itemId,
      wifi,
      bed,
      chair,
      table,
      fan,
      gadda,
      light,
      locker,
      bedSheet,
      washingMachine,
      parking,
      attachBathroom,
      shareableBathroom) async {
    //rent collection data base
    await firebaseFirestore.collection("rentCollection").doc(itemId).update({
      'parking': parking,
      'bed': bed,
      'washingMachine': washingMachine,
      'locker': locker,
      'fan': fan,
      'gadda': gadda,
      'table': table,
      'wifi': wifi,
      'chair': chair,
      'bedSheet': bedSheet,
      'light': light,
      'attachBathRoom': attachBathroom,
      'shareAbleBathRoom': shareableBathroom,
    });
//user personal collection data base
    await firebaseFirestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({
      'parking': parking,
      'bed': bed,
      'washingMachine': washingMachine,
      'locker': locker,
      'fan': fan,
      'gadda': gadda,
      'table': table,
      'wifi': wifi,
      'chair': chair,
      'bedSheet': bedSheet,
      'light': light,
      'attachBathRoom': attachBathroom,
      'shareAbleBathRoom': shareableBathroom,
    });
  }

  // update Additional Charges And Door closing time
  static Future<void> updateAdditionalChargesAndDoorDate(
      itemId, electricity, water, restrictTime, flexibleTime) async {
    //rent collection data base
    await firebaseFirestore.collection("rentCollection").doc(itemId).update({
      'flexibleTime': flexibleTime,
      'restrictedTime': restrictTime,
      'waterBill': water,
      'electricityBill': electricity,
    });
//user personal collection data base
    await firebaseFirestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({
      'flexibleTime': flexibleTime,
      'restrictedTime': restrictTime,
      'waterBill': water,
      'electricityBill': electricity,
    });
  }

  //update Rent Details data
  static Future<void> updateRentDetailsData(
      name, address, city, landMark, number, numberOfRoom, itemID) async {
    //rent collection data base
    await firebaseFirestore.collection("rentCollection").doc(itemID).update({
      'houseName': name,
      'contactNumber': number,
      'landMark': landMark,
      'city': city,
      'address': address,
      'numberOfRooms': numberOfRoom
    });
//user personal collection data base
    await firebaseFirestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemID)
        .update({
      'houseName': name,
      'contactNumber': number,
      'landMark': landMark,
      'city': city,
      'address': address,
      'numberOfRooms': numberOfRoom
    });
  }

  // update Room type And Price Data
  static Future<void> updateRoomTypeAndPrice(
      itemId, single, doublePerson, triple, four, family) async {
    //rent collection data base
    await firebaseFirestore.collection("rentCollection").doc(itemId).update({
      'doublePersonPrice': doublePerson,
      'triplePersonPrice': triple,
      'familyPrice': family,
      'fourPersonPrice': four,
      'singlePersonPrice': single
    });
//user personal collection data base
    await firebaseFirestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({
      'doublePeronPrice': doublePerson,
      'triplePersonPrice': triple,
      'familyPrice': family,
      'fourPersonPrice': four,
      'singlePersonPrice': single
    });
  }

  // update map view  Data
  static Future<void> updateMapViewData(itemId, latitude, longitude) async {
    //rent collection data base
    await firebaseFirestore.collection("rentCollection").doc(itemId).update({
      'latitude': latitude,
      'longitude': longitude,
    });
//user personal collection data base
    await firebaseFirestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({
      'latitude': latitude,
      'longitude': longitude,
    });
  }

  static Future<void> updateRoomAvailable(roomAvailable, itemId) async {
    await firebaseFirestore
        .collection("rentCollection")
        .doc(itemId)
        .update({'roomAvailable': roomAvailable});
//user personal collection data base
    await firebaseFirestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'roomAvailable': roomAvailable});
  }

  // update Add to cart data
  static Future<void> updateAddToCart(itemId, like) async {
    //rent collection data base
    await firebaseFirestore.collection("rentCollection").doc(itemId).update({
      'like': like,
    });
  }

//=========================================================

  //============= Rating bar Summary Apis===================

  //Get in user rating bar summary data
  static Future<void> getRatingBarSummaryData(itemId) async {
    var collection = firebaseFirestore
        .collection("userReview")
        .doc("reviewCollection")
        .collection("$itemId")
        .doc(itemId)
        .collection("reviewSummary")
        .doc(itemId);
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    starOne = data?['ratingStar01'] ?? 0;
    starTwo = data?['ratingStar02'] ?? 0;
    starThree = data?['ratingStar03'] ?? 0;
    starFour = data?['ratingStar04'] ?? 0;
    starFive = data?['ratingStar05'] ?? 0;
    totalNumberOfStar = data?['totalNumberOfStar'] ?? 0;
    averageRating = data?['averageRating'] ?? 0.0;
  }

  //save Rating Summary data
  static Future<void> saveRatingBarSummaryData(
      itemId, one, two, three, four, five, avg, totalNumberOfStar) async {
    //Rating Summary data
    await firebaseFirestore
        .collection("userReview")
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
  static Future<void> updateRatingBarStarSummaryData(
      itemId, avg, totalNumberOfStar) async {
    //Rating Summary data
    await firebaseFirestore
        .collection("userReview")
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

//=========================================================

//============== Review Apis ==============================

  //get review id for check user a review submit or not
  static Future<String> getReviewData(itemId) async {
    var collection = firebaseFirestore
        .collection("loginUser")
        .doc(user.uid)
        .collection(auth.currentUser!.uid)
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId);

    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    reviewId = data?['itemId'] ?? '';

    return reviewId;
  }

  /// Rating and review create api
  static Future<void> ratingAndReviewCreateData(
      ratingStar, review, itemId) async {
    //This review data save in all viewer user
    await firebaseFirestore
        .collection("userReview")
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
      'itemId': itemId,
      'rating': ratingStar,
      'title': review,
      'currentDate': AppHelperFunction.getFormattedDate(DateTime.now()),
      'userName': UserApis.userName,
      'userImage': UserApis.userImage
    });
  }

  //add ratings in  user collection  and rent list collection
  static Future<void> addRatingMainList(itemId, average, numberOfRating) async {
    //rent collection data base
    await firebaseFirestore
        .collection("rentCollection")
        .doc(itemId)
        .update({'average': average, 'numberOfRating': numberOfRating});
//user personal collection data base
    await firebaseFirestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'average': average, 'numberOfRating': numberOfRating});
  }

  //=======================================================

//=========================================================

//============== Deletes data apis =========================

  // delete cover image  data and all list collection data  code
  static Future<void> deleteCoverImageData(
      String deleteId, String imageUrl) async {
    try {
      //delete a Firestorm
      DocumentReference documentReference = firebaseFirestore
          .collection('userRentDetails')
          .doc(user.uid)
          .collection(user.uid)
          .doc(deleteId);

      DocumentReference documentReference1 =
          firebaseFirestore.collection('rentCollection').doc(deleteId);

      //Rating Summary data
      await firebaseFirestore
          .collection("userReview")
          .doc("reviewCollection")
          .collection(deleteId)
          .doc(deleteId)
          .collection("reviewSummary")
          .doc(deleteId)
          .delete();

      // This review  data save in user account only
      await firebaseFirestore
          .collection("loginUser")
          .doc(user.uid)
          .collection(auth.currentUser!.uid)
          .doc(deleteId)
          .delete();

// delete other image in firebase storage

      if (kDebugMode) {
        print('id - $deleteId');
      }

      await FirebaseStorage.instance
          .ref("otherImage/$deleteId")
          .listAll()
          .then((value) {
        value.items.forEach((element) {
          FirebaseStorage.instance.ref(element.fullPath).delete();
        });
      });

      //delete other image doc

      final batch = firebaseFirestore.batch();
      var collection = firebaseFirestore
          .collection("OtherImageList")
          .doc(deleteId)
          .collection(deleteId);
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      final batch1 = firebaseFirestore.batch();
      var collection1 = firebaseFirestore
          .collection("OtherImageUserList")
          .doc(deleteId)
          .collection(deleteId);
      var snapshots1 = await collection1.get();
      for (var doc in snapshots1.docs) {
        batch1.delete(doc.reference);
      }
      await batch1.commit();

      //delete a review collection data

      final batch2 = firebaseFirestore.batch();
      var collection2 = firebaseFirestore
          .collection("userReview")
          .doc("reviewCollection")
          .collection(deleteId);
      var snapshots2 = await collection2.get();
      for (var doc in snapshots2.docs) {
        batch2.delete(doc.reference);
      }
      await batch2.commit();

      // // Delete the document.
      await documentReference.delete();
      await documentReference1.delete();

      // delete a firestorm image data
      final ref = storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      AppLoggerHelper.info("data in not delete $e");
    }
  }

  //delete Other image data
  static Future<void> deleteOtherImage(
      String deleteOtherIMageId, String itemId, String imageUrl) async {
    try {
      DocumentReference documentReference = firebaseFirestore
          .collection("OtherImageUserList")
          .doc(itemId)
          .collection(itemId)
          .doc(deleteOtherIMageId);

      DocumentReference documentReference1 = firebaseFirestore
          .collection("OtherImageList")
          .doc(itemId)
          .collection(itemId)
          .doc(deleteOtherIMageId);

      await documentReference.delete();
      await documentReference1.delete();

      // delete a firestorm image data
      final ref = storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      AppLoggerHelper.info("data in not delete $e");
    }
  }

//========================================================= new api=====

  // static Future addRoomRentList(roomOwnershipType, houseName, roomType,
  //     roomCategory, genderType, imageList, homeAddress, landmark, city, state,
  //     numberOfRoom, mealsAvailable, depositAmount, roomFacilityList,
  //     commonAreasList, billsList, longitude, latitude, houseRules, houseFAQ,
  //     rUid, uid, atCreated, atUpdated, isDelete, report, disable,) async {
  //
  //   return await firebaseFirestore
  //       .collection("DevRoomCollection")
  //       .add({
  //         "roomOwnershipType": roomOwnershipType,
  //         "houseName": houseName,
  //         "roomType": roomType,
  //         "roomCategory": roomCategory,
  //         "genderType": genderType,
  //         "imageList": imageList,
  //         "homeAddress": homeAddress,
  //         "landmark": landmark,
  //         "city": city,
  //         "state": state,
  //         "numberOfRoom": numberOfRoom,
  //         "mealsAvailable": mealsAvailable,
  //         "depositAmount": depositAmount,
  //         "roomFacilityList": roomFacilityList,
  //         "commonAreasList": commonAreasList,
  //         "billsList": billsList,
  //         "longitude": longitude,
  //         "latitude": latitude,
  //         "houseRules": houseRules,
  //         "houseFAQ": houseFAQ,
  //         "rUid": rUid,
  //         "uid": uid,
  //         "atCreated": atCreated,
  //         "atUpdated": atUpdated,
  //         "isDelete": isDelete,
  //         "report": report,
  //         "disable": disable
  //   });
  // }

  static Future<bool> addRoomData(
      {required String homeName,
      required String latitude,
      required String longitude,
      required String address,
      required String landmark,
      required String city,
      required String state,
      required List<String> commonAreasList,
      required List<String> roomFacilityList,
      required String roomType,
      required List<String> billsList,
      required List<File> imageFiles,
      required List<HouseFAQ> houseFAQ,
      required String roomOwnership,
      required String roomCategory,
      required String depositAmount,
      required String singlePersonCost,
      required String doublePersonCost,
      required String triplePersonCost,
      required String triplePlusCost,
      required String familyCost,
      required String roomsAvailable,
      required String noticePride,
      required String mealsAvailable,
      required List<String> houseRules,
      required String genderType,
      required String totalRoom,
      required String flatType

      }) async {
    AppHelperFunction.showCenterCircularIndicator(true);

    try {
      List<String> imageUrls = [];

      // Step 2: Prepare the data to save in Firestore
      final item = RoomModel(
        longitude: longitude,
        latitude: latitude,
        billsList: billsList,
        commonAreasList: commonAreasList,
        depositAmount: depositAmount,
        doublePersonCost: doublePersonCost,
        genderType: genderType,
        houseFAQ: houseFAQ,
        houseName: homeName,
        houseRules: houseRules,
        imageList: imageUrls,
        roomCategory: roomCategory,
        roomFacilityList: roomFacilityList,
        roomOwnershipType: roomOwnership,
        roomType: roomType,
        singlePersonCost: singlePersonCost,
        triplePersonCost: triplePersonCost,
        triplePlusCost: triplePlusCost,
        mealsAvailable: mealsAvailable,
        familyCost: familyCost,
        isRoomAvailableDate: roomsAvailable,
        noticePride: noticePride,
        rId: '',
        totalRoom: totalRoom,
        homeAddress: address,
        landmark: landmark,
        city: city,
        state: state,
        atCreate: DateTime.now().toString(),
        atUpdate: DateTime.now().toString(),
        isDelete: false,
        report: [],
        disable: false,
        uId: user.uid,
        flatType: flatType
      );

      // Step 3: Add the data to Firestore
      try {
        DocumentReference docRef = await FirebaseFirestore.instance
            .collection("DevRoomCollection")
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
            .collection("DevRoomCollection")
            .doc(docRef.id)
            .update({'r_id': docRef.id, 'imageList': imageUrls}).whenComplete(
                () {
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
          AppLoggerHelper.info("General error: $e");
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
          'DevRoomCollection/${user.uid}/$docId/${DateTime.now().millisecondsSinceEpoch}.jpg');
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

  static Future<void> submitReport(
      {required String reportReason, required String docId}) async {
    try {
      await FirebaseFirestore.instance
          .collection("DevRoomCollection")
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
}
