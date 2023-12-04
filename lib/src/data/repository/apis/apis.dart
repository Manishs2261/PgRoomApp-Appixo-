import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pgroom/src/model/user_rent_model/user_rent_model.dart';
import 'package:pgroom/src/utils/logger/logger.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/helpers/helper_function.dart';

class ApisClass {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //to return current user info
  static User get user => auth.currentUser!;

  // for accessing cloud firestorm database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // for storing Image  information
  static FirebaseStorage storage = FirebaseStorage.instance;

  //current date and time
  static final time = DateTime.now().microsecondsSinceEpoch.toString();

  static var CoverImagedownloadUrl;
  static var userRentId = "";
  static var userName;
  static var otherDownloadUrl;
  static var userEmail;
  static var userCity;
  static var userImage;
  static var reviewId = "";

  static var starOne;

  static var starTwo;

  static var starThree;

  static var starFour;

  static var starFive;

  static var averageRating;
  static var totalNumberOfStar;
  static var userImageDownloadUrl = '';

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
      faimlyPrice,
      restrictedTime,
      review,
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
      fexible,
      cooking,
      cookingType,
      boyAllow,
      girlAllow,
      faimalyMember,
      like) async {
    final userHomeList = UserRentModel(
        coverImage: coverImage,
        houseName: houseName,
        addres: address,
        city: cityName,
        landMark: landMark,
        contactNumber: contactNumber,
        bhkType: bhk,
        roomType: roomType,
        singlePersonPrice: singlePrice,
        doublePersionPrice: doublePrice,
        triplePersionPrice: triplePrice,
        fourPersionPrice: fourPrice,
        faimlyPrice: faimlyPrice,
        review: review,
        wifi: wifi,
        bed: bed,
        chair: chair,
        table: table,
        fan: fan,
        gadda: gadda,
        light: light,
        locker: locker,
        bedSheet: bedSheet,
        washingMachin: washingMachine,
        parking: parking,
        electricityBill: electricityBill,
        waterBill: waterBill,
        fexibleTime: fexible,
        cooking: cooking,
        cookingType: cookingType,
        boy: boyAllow,
        girls: girlAllow,
        faimlyMember: faimalyMember,
        like: like,
        restrictedTime: restrictedTime,
        userRentId: time);
    return await firestore.collection("rentCollection").doc(userRentId).set(userHomeList.toJson());
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
      faimlyPrice,
      restrictedTime,
      review,
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
      fexible,
      cooking,
      cookingType,
      boyAllow,
      girlAllow,
      faimalyMember,
      like) async {
    final userHomeList = UserRentModel(
        coverImage: coverImage,
        houseName: houseName,
        addres: address,
        city: cityName,
        landMark: landMark,
        contactNumber: contactNumber,
        bhkType: bhk,
        roomType: roomType,
        singlePersonPrice: singlePrice,
        doublePersionPrice: doublePrice,
        triplePersionPrice: triplePrice,
        fourPersionPrice: fourPrice,
        faimlyPrice: faimlyPrice,
        review: review,
        wifi: wifi,
        bed: bed,
        chair: chair,
        table: table,
        fan: fan,
        gadda: gadda,
        light: light,
        locker: locker,
        bedSheet: bedSheet,
        washingMachin: washingMachine,
        parking: parking,
        electricityBill: electricityBill,
        waterBill: waterBill,
        fexibleTime: fexible,
        cooking: cooking,
        cookingType: cookingType,
        boy: boyAllow,
        girls: girlAllow,
        faimlyMember: faimalyMember,
        like: like,
        restrictedTime: restrictedTime,
        userRentId: time);

    return await firestore
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
      final reference = storage.ref().child('coverimage/${user.uid}/${DateTime.now()}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      CoverImagedownloadUrl = await snapshot.ref.getDownloadURL();
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
  }

//=========================================================

//============== Edit Post Room Data APis ===================

  //upload other images in firebase database
  static Future uploadOtherImage(File imageFile, itemid) async {
    try {
      final reference = storage.ref().child('otherimage/${DateTime.now()}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      otherDownloadUrl = await snapshot.ref.getDownloadURL();
      //rent collection data base
      await firestore
          .collection("OtherImageUserList")
          .doc(itemid)
          .collection("$itemid")
          .add({'OtherImage': otherDownloadUrl}).then((value) async {
        AppLoggerHelper.info(value.id);
        userRentId = value.id;
//user personal collection data base
        await firestore
            .collection("OtherImageList")
            .doc(itemid)
            .collection("$itemid")
            .doc(userRentId)
            .set({'OtherImage': otherDownloadUrl});

        return null;
      });
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
  }

// update cover Image data
  static Future<void> updateCoverItemImage(File file, String itmeId) async {
    //getting image file extenstion
    final ext = file.path.split('.').last;
    AppLoggerHelper.info('Extension :$ext');

    // storage file ref with path
    final ref = storage.ref().child('coverimage/${user.uid}.$ext');

    // uploading image
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((p0) {
      AppLoggerHelper.info('Data Transferred :${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firebase  database
    model.coverImage = await ref.getDownloadURL();

    //rent collection data base
    await firestore.collection('rentCollection').doc(itmeId).update({'coverImage': model.coverImage});
//user personal collection data base
    await firestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itmeId)
        .update({'coverImage': model.coverImage});
  }

  //update Permission data
  static Future<void> updatePermissionData(itemId, cookingType, cooking, boy, girl, familyMember) async {
    //rent collection data base
    await firestore.collection("rentCollection").doc(itemId).update(
        {'girls': girl, 'boy': boy, 'cooking': cooking, 'cookingType': cookingType, 'faimlyMember': familyMember});
//user personal collection data base
    await firestore.collection("userRentDetails").doc(user.uid).collection(user.uid).doc(itemId).update(
        {'girls': girl, 'boy': boy, 'cooking': cooking, 'cookingType': cookingType, 'faimlyMember': familyMember});
  }

  // update provide Facilities Data
  static Future<void> updateProvideFacilitiesData(
      itemId, wifi, bed, chair, table, fan, gadda, light, locker, bedSheet, washingMachine, parking) async {
    //rent collection data base
    await firestore.collection("rentCollection").doc(itemId).update({
      'parking': parking,
      'bed': bed,
      'washingMachin': washingMachine,
      'locker': locker,
      'fan': fan,
      'gadda': gadda,
      'table': table,
      'wifi': wifi,
      'chair': chair,
      'bedSheet': bedSheet,
      'light': light,
    });
//user personal collection data base
    await firestore.collection("userRentDetails").doc(user.uid).collection(user.uid).doc(itemId).update({
      'parking': parking,
      'bed': bed,
      'washingMachin': washingMachine,
      'locker': locker,
      'fan': fan,
      'gadda': gadda,
      'table': table,
      'wifi': wifi,
      'chair': chair,
      'bedSheet': bedSheet,
      'light': light,
    });
  }

  // update Additional Charges And Door closing time
  static Future<void> updateAdditionalChargesAndDoorDate(itemId, electricity, water, restrictTime, flexibleTime) async {
    //rent collection data base
    await firestore.collection("rentCollection").doc(itemId).update({
      'fexibleTime': flexibleTime,
      'restrictedTime': restrictTime,
      'waterBill': water,
      'electricityBill': electricity,
    });
//user personal collection data base
    await firestore.collection("userRentDetails").doc(user.uid).collection(user.uid).doc(itemId).update({
      'fexibleTime': flexibleTime,
      'restrictedTime': restrictTime,
      'waterBill': water,
      'electricityBill': electricity,
    });
  }

  //update Rent Details data
  static Future<void> updateRentDetailsData(name, address, city, landMark, number, itemID) async {
    //rent collection data base
    await firestore
        .collection("rentCollection")
        .doc(itemID)
        .update({'houseName': name, 'contactNumber': number, 'landMark': landMark, 'city': city, 'addres': address});
//user personal collection data base
    await firestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemID)
        .update({'houseName': name, 'contactNumber': number, 'landMark': landMark, 'city': city, 'addres': address});
  }

  // update Room type And Price Data
  static Future<void> updateRoomTypeAndPrice(itemId, single, double, triple, four, faimly) async {
    //rent collection data base
    await firestore.collection("rentCollection").doc(itemId).update({
      'doublePersionPrice': double,
      'triplePersionPrice': triple,
      'faimlyPrice': faimly,
      'fourPersionPrice': four,
      'singlePersonPrice': single
    });
//user personal collection data base
    await firestore.collection("userRentDetails").doc(user.uid).collection(user.uid).doc(itemId).update({
      'doublePersionPrice': double,
      'triplePersionPrice': triple,
      'faimlyPrice': faimly,
      'fourPersionPrice': four,
      'singlePersonPrice': single
    });
  }

//=========================================================

//============== User Data  Apis ===========================

  //Get all data in user
  static Future<void> getUserData() async {
    var collection = firestore.collection('loginUser').doc(user.uid);
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    userName = data?['Name'] ?? '';
    userCity = data?['city'] ?? '';
    userEmail = data?['email'] ?? '';
    userImage = data?['userImage'] ?? '';
  }

  // save a user data
  static Future<void> saveUserData(name, city, email, image) async {
    await firestore.collection("loginUser").doc(user.uid).set({
      'city': city,
      'email': email,
      'Name': name,
      'userImage': image,
    });
  }

  static Future<void> updateUserData(name, city) async {
    await firestore.collection("loginUser").doc(user.uid).update({
      'city': city,
      'Name': name,
    });
  }

  //upload user images in firebase database
  static Future<String> uploadUserImage(File imageFile) async {
    try {
      final reference = storage.ref().child('userImage/${user.uid}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      userImageDownloadUrl = await snapshot.ref.getDownloadURL();

      await firestore.collection('loginUser').doc(user.uid).update({'userImage': userImageDownloadUrl});
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
    return userImageDownloadUrl;
  }

  // update user Image data
  static Future<void> updateUserImage(File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    AppLoggerHelper.info('Extension :$ext');

    // storage file ref with path
    final ref = storage.ref().child('userImage/${user.uid}.$ext');

    // uploading image
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((p0) {
      AppLoggerHelper.info('Data Transferred :${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firebase  database
    var updateUserImage = await ref.getDownloadURL();

    await firestore.collection('loginUser').doc(user.uid).update({'userImage': updateUserImage});

    //rent collection data base
  }

//=========================================================

  //============= Rating bar Summary Apis===================

  //Get in user rating bar summary data
  static Future<void> getRatingBarSummaryData(itemId) async {
    var collection = firestore
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
    await firestore
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
    await firestore
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
      AppLoggerHelper.info("Update Rating bar avarage successfully");
    }).onError((error, stackTrace) {
      AppLoggerHelper.error("Update Rating bar avarage successfully");
    });
  }

//=========================================================

//============== Review Apis ==============================

  //get review id for check user a review submit or not
  static Future<String> getReviewData(itemId) async {
    var collection = firestore.collection("loginUser").doc(user.uid).collection(auth.currentUser!.uid).doc(itemId);
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    reviewId = data?['itemId'] ?? '';
    return reviewId;
  }

  /// Rating and review create api
  static Future<void> ratingAndReviewCreateData(ratingStar, review, itemId) async {
    //This review data save in all viewer user
    await firestore.collection("userReview").doc("reviewCollection").collection("$itemId").add({
      'rating': ratingStar,
      'title': review,
      'currentDate': AppHelperFunction.getFormattedDate(DateTime.now()),
    });

    // This review  data save in user account only
    await firestore.collection("loginUser").doc(user.uid).collection(auth.currentUser!.uid).doc(itemId).set({
      'itemId': itemId,
      'rating': ratingStar,
      'title': review,
      'currentDate': AppHelperFunction.getFormattedDate(DateTime.now()),
    });
  }

  //=======================================================

//============== Share preference =========================

  //Remove user in share preferences
  static Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }

//=========================================================

//============== Deletes data apis =========================

  // delete cover image  data and all list collection data  code
  static Future<void> deleteCoverImageData(String deleteId, String imageUrl) async {
    try {
      //delete a Firestorm
      DocumentReference documentReference =
          firestore.collection('userRentDetails').doc(user.uid).collection(user.uid).doc(deleteId);

      DocumentReference documentReference1 = firestore.collection('rentCollection').doc(deleteId);

      // Delete the document.
      await documentReference.delete();
      await documentReference1.delete();

      // delete a firestorm image data
      final reff = storage.refFromURL(imageUrl);
      await reff.delete();
    } catch (e) {
      AppLoggerHelper.info("data in not delete $e");
    }
  }

  //delete Other image data
  static Future<void> deleteOtherImage(String deleteOtherIMageId, String itemId, String imageUrl) async {
    try {
      DocumentReference documentReference =
          firestore.collection("OtherImageUserList").doc(itemId).collection(itemId).doc(deleteOtherIMageId);

      DocumentReference documentReference1 =
          firestore.collection("OtherImageList").doc(itemId).collection(itemId).doc(deleteOtherIMageId);

      await documentReference.delete();
      await documentReference1.delete();

      // delete a firestorege image data
      final reff = storage.refFromURL(imageUrl);
      await reff.delete();
    } catch (e) {
      AppLoggerHelper.info("data in not delete $e");
    }
  }

//=========================================================
}
