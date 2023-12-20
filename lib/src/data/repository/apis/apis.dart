import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pgroom/src/data/repository/apis/user_apis.dart';
import 'package:pgroom/src/model/user_rent_model/user_rent_model.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'dart:io';
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
      like) async {
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
        userRentId: time);
    return await firebaseFirestore.collection("rentCollection").doc(userRentId).set(userHomeList.toJson());
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
      like) async {
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
        userRentId: time);

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
      final reference = storage.ref().child('coverImage/${user.uid}/${user.uid}.jpg');
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
      final reference = storage.ref().child('otherImage/${DateTime.now()}.jpg');
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
  static Future<void> updateCoverItemImage(File file, String itemId) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    AppLoggerHelper.info('Extension :$ext');

    // storage file ref with path
    final ref = storage.ref().child('coverImage/${user.uid}/${user.uid}.$ext');

    // uploading image
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((p0) {
      AppLoggerHelper.info('Data Transferred :${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firebase  database
    model.coverImage = await ref.getDownloadURL();

    //rent collection data base
    await firebaseFirestore.collection('rentCollection').doc(itemId).update({'coverImage': model.coverImage});
//user personal collection data base
    await firebaseFirestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'coverImage': model.coverImage});
  }

  //update Permission data
  static Future<void> updatePermissionData(itemId, cookingType, cooking, boy, girl, familyMember) async {
    //rent collection data base
    await firebaseFirestore.collection("rentCollection").doc(itemId).update(
        {'girls': girl, 'boy': boy, 'cooking': cooking, 'cookingType': cookingType, 'familyMember': familyMember});
//user personal collection data base
    await firebaseFirestore.collection("userRentDetails").doc(user.uid).collection(user.uid).doc(itemId).update(
        {'girls': girl, 'boy': boy, 'cooking': cooking, 'cookingType': cookingType, 'familyMember': familyMember});
  }

  // update provide Facilities Data
  static Future<void> updateProvideFacilitiesData(itemId, wifi, bed, chair, table, fan, gadda, light, locker, bedSheet,
      washingMachine, parking, attachBathroom, shareableBathroom) async {
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
    await firebaseFirestore.collection("userRentDetails").doc(user.uid).collection(user.uid).doc(itemId).update({
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
  static Future<void> updateAdditionalChargesAndDoorDate(itemId, electricity, water, restrictTime, flexibleTime) async {
    //rent collection data base
    await firebaseFirestore.collection("rentCollection").doc(itemId).update({
      'flexibleTime': flexibleTime,
      'restrictedTime': restrictTime,
      'waterBill': water,
      'electricityBill': electricity,
    });
//user personal collection data base
    await firebaseFirestore.collection("userRentDetails").doc(user.uid).collection(user.uid).doc(itemId).update({
      'flexibleTime': flexibleTime,
      'restrictedTime': restrictTime,
      'waterBill': water,
      'electricityBill': electricity,
    });
  }

  //update Rent Details data
  static Future<void> updateRentDetailsData(name, address, city, landMark, number, numberOfRoom, itemID) async {
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
    await firebaseFirestore.collection("userRentDetails").doc(user.uid).collection(user.uid).doc(itemID).update({
      'houseName': name,
      'contactNumber': number,
      'landMark': landMark,
      'city': city,
      'address': address,
      'numberOfRooms': numberOfRoom
    });
  }

  // update Room type And Price Data
  static Future<void> updateRoomTypeAndPrice(itemId, single, doublePerson, triple, four, family) async {
    //rent collection data base
    await firebaseFirestore.collection("rentCollection").doc(itemId).update({
      'doublePersonPrice': doublePerson,
      'triplePersonPrice': triple,
      'familyPrice': family,
      'fourPersonPrice': four,
      'singlePersonPrice': single
    });
//user personal collection data base
    await firebaseFirestore.collection("userRentDetails").doc(user.uid).collection(user.uid).doc(itemId).update({
      'doublePeronPrice': doublePerson,
      'triplePersonPrice': triple,
      'familyPrice': family,
      'fourPersonPrice': four,
      'singlePersonPrice': single
    });
  }

  static Future<void> updateRoomAvailable(roomAvailable, itemId) async {
    await firebaseFirestore.collection("rentCollection").doc(itemId).update({'roomAvailable': roomAvailable});
//user personal collection data base
    await firebaseFirestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'roomAvailable': roomAvailable});
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
  static Future<void> saveRatingBarSummaryData(itemId, one, two, three, four, five, avg, totalNumberOfStar) async {
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
  static Future<void> updateRatingBarStarSummaryData(itemId, avg, totalNumberOfStar) async {
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
    var collection =
        firebaseFirestore.collection("loginUser").doc(user.uid).collection(auth.currentUser!.uid).doc(itemId);
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    reviewId = data?['itemId'] ?? '';
    return reviewId;
  }

  /// Rating and review create api
  static Future<void> ratingAndReviewCreateData(ratingStar, review, itemId) async {
    //This review data save in all viewer user
    await firebaseFirestore.collection("userReview").doc("reviewCollection").collection("$itemId").add({
      'rating': ratingStar,
      'title': review,
      'currentDate': AppHelperFunction.getFormattedDate(DateTime.now()),
      'userName': UserApis.userName,
      'userImage': UserApis.userImage
    });

    // This review  data save in user account only
    await firebaseFirestore.collection("loginUser").doc(user.uid).collection(auth.currentUser!.uid).doc(itemId).set({
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
  static Future<void> deleteCoverImageData(String deleteId, String imageUrl) async {
    try {
      //delete a Firestorm
      DocumentReference documentReference =
          firebaseFirestore.collection('userRentDetails').doc(user.uid).collection(user.uid).doc(deleteId);

      DocumentReference documentReference1 = firebaseFirestore.collection('rentCollection').doc(deleteId);

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

      //delete a review collection data

      final batch = firebaseFirestore.batch();
      var collection = firebaseFirestore.collection("userReview").doc("reviewCollection").collection(deleteId);
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      // Delete the document.
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
  static Future<void> deleteOtherImage(String deleteOtherIMageId, String itemId, String imageUrl) async {
    try {
      DocumentReference documentReference =
          firebaseFirestore.collection("OtherImageUserList").doc(itemId).collection(itemId).doc(deleteOtherIMageId);

      DocumentReference documentReference1 =
          firebaseFirestore.collection("OtherImageList").doc(itemId).collection(itemId).doc(deleteOtherIMageId);

      await documentReference.delete();
      await documentReference1.delete();

      // delete a firestorm image data
      final ref = storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      AppLoggerHelper.info("data in not delete $e");
    }
  }

//=========================================================
}
