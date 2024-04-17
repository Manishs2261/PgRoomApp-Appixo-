import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pgroom/src/data/repository/apis/user_apis.dart';

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
  static final time = DateTime
      .now()
      .microsecondsSinceEpoch
      .toString();

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

//==============Tiffine Services Apis =====================

  // create a tiffine services data base for main home collection
  static Future<void> addYourTiffineServices(coverImage, servicesName, address, price, menuImage,contactNumber,latu,
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
      longitude: lang
    );

    // store main list data
    return await firebaseFirestore
        .collection("tiffineServicesCollection")
        .doc(tiffineServicesId)
        .set(tiffineList.toJson());
  }

  // create a tiffine services data base for user data base
  static Future<void> addYourTiffineServicesUserAccount(coverImage, servicesName, address, price, menuImage,
      contactNumber,latu,lang) async {
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
        longitude: lang
    );
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
      final reference = storage.ref().child('tiffineServices/${user.uid}/${user.uid}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      tiffineServicesCoverImageUrl = await snapshot.ref.getDownloadURL();
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
  }

  // upload  Menu image data in firebase database
  static Future uploadMenuImage(File imageFile) async {
    try {
      final reference = storage.ref().child('foodMenu/${user.uid}/${user.uid}.jpg');
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
  static Future<void> updateTiffineServicesData(servicesName, address, price, itemId,contactNumber) async {
    //home list collection data base
    await firebaseFirestore.collection("tiffineServicesCollection").doc(itemId).update({
      'foodPrice': price,
      'address': address,
      'servicesName': servicesName,
      'contactNumber':contactNumber
    });
//user personal collection data base
    await firebaseFirestore.collection("userTiffineCollection").doc(user.uid).collection(user.uid).doc(itemId).update({
      'foodPrice': price,
      'address': address,
      'servicesName': servicesName,
      'contactNumber':contactNumber
    });
  }

  // update cover Image data
  static Future<void> updateTiffineCoverImage(File file, String itemId) async {
    //getting image file extension
    final ext = file.path
        .split('.')
        .last;
    AppLoggerHelper.info('Extension :$ext');

    // storage file ref with path
    final ref = storage.ref().child('tiffineServices/${user.uid}/${DateTime
        .now()}.$ext');

    // uploading image
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((p0) {
      AppLoggerHelper.info('Data Transferred :${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firebase  database
    final tiffineUrl = await ref.getDownloadURL();

    //rent collection data base
    await firebaseFirestore.collection('tiffineServicesCollection').doc(itemId).update({
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
  static Future<void> updateTiffineMenuImage(File file, String itemId) async {
    //getting image file extension
    final ext = file.path
        .split('.')
        .last;
    AppLoggerHelper.info('Extension :$ext');

    // storage file ref with path
    final ref = storage.ref().child('foodMenu/${user.uid}/${DateTime
        .now()}.$ext');

    // uploading image
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((p0) {
      AppLoggerHelper.info('Data Transferred :${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firebase  database
    final tiffineMenuUrl = await ref.getDownloadURL();

    //rent collection data base
    await firebaseFirestore.collection('tiffineServicesCollection').doc(itemId).update({
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
    var collection =
    firebaseFirestore.collection("loginUser").doc(user.uid).collection(auth.currentUser!.uid).doc(itemId);
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    tiffineReviewSubmitId = data?['tiffineUserId'] ?? '';

    return tiffineReviewSubmitId;
  }

  // Rating and review create api
  static Future<void> createTiffineRatingAndReviewData(ratingStar, review, itemId) async {
    //This review data save in all viewer user
    await firebaseFirestore.collection("TiffineReview").doc("reviewCollection").collection("$itemId").add({
      'rating': ratingStar,
      'title': review,
      'currentDate': AppHelperFunction.getFormattedDate(DateTime.now()),
      'userName': UserApis.userName,
      'userImage': UserApis.userImage
    });

    // This review  data save in user account only
    await firebaseFirestore.collection("loginUser").doc(user.uid).collection(auth.currentUser!.uid).doc(user.uid)
        .collection(auth.currentUser!.uid).doc(itemId).set({
      'tiffineUserId': itemId,
      'tiffineRating': ratingStar,
      'tiffineTitle': review,
      'currentDate': AppHelperFunction.getFormattedDate(DateTime.now()),
      'userName': UserApis.userName,
      'userImage': UserApis.userImage
    });
  }

  //add ratings in  user collection  and Tiffine list collection
  static Future<void> addRatingMainTiffineList(itemId, average, numberOfRating) async {
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
  static Future<void> saveRatingBarSummaryTiffineData(itemId, one, two, three, four, five, avg,
      totalNumberOfStar) async {
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
  static Future<void> updateRatingBarStarSummaryTiffineData(itemId, avg, totalNumberOfStar) async {
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

  static Future<void> deleteTiffineServicesData(String deleteId, coverImageUrl, menuImageUrl) async {
    try {
      //delete a Firestorm
      DocumentReference documentReference =
      firebaseFirestore.collection('userTiffineCollection').doc(user.uid).collection(user.uid).doc(deleteId);

      DocumentReference documentReference1 = firebaseFirestore.collection('tiffineServicesCollection').doc(deleteId);

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
      var collection = firebaseFirestore.collection("TiffineReview").doc("reviewCollection").collection(deleteId);
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



}
