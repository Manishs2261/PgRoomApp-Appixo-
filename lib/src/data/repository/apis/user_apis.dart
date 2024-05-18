import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pgroom/src/res/route_name/routes_name.dart';
import 'package:pgroom/src/utils/helpers/helper_function.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/logger/logger.dart';

class UserApis {
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

  static var userEmail;
  static var userCity;

  static var userName;

  static var userImage;

  static var userImageDownloadUrl;
  static var appShareUrl;

  //============== User Data  Apis ===========================

  //Get all data in user
  static Future<void> getUserData() async {
    var collection = firebaseFirestore.collection('loginUser').doc(user.uid).collection(user.uid).doc(user.uid);
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    userName = data?['Name'] ?? '';
    userCity = data?['city'] ?? '';
    userEmail = data?['email'] ?? '';
    userImage = data?['userImage'] ?? '';
  }

  // save a user data
  static Future<void> saveUserData(name, city, email, image) async {
    await firebaseFirestore.collection("loginUser").doc(user.uid).collection(user.uid).doc(user.uid).set({
      'city': city,
      'email': email,
      'Name': name,
      'userImage': image,
    });
  }

  static Future<void> updateUserData(name, city) async {
    await firebaseFirestore.collection("loginUser").doc(user.uid).collection(user.uid).doc(user.uid).update({
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

      await firebaseFirestore.collection('loginUser').doc(user.uid).update({'userImage': userImageDownloadUrl});
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

    await firebaseFirestore
        .collection('loginUser')
        .doc(user.uid)
        .collection(user.uid)
        .doc(user.uid)
        .update({'userImage': updateUserImage});

    //rent collection data base
  }

//=========================================================
//============== Share preference =========================

  //Remove user in share preferences
  static Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }

  static Future<void> deleteUserAllItemAccount() async {
    AppHelperFunction.checkInternetAvailability().then((value) async {
      if (value) {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            });
        try {
          final snapshots =
              firebaseFirestore.collection('userTiffineCollection').doc(user.uid).collection(user.uid).snapshots();

          var numberOfDocuments1;
          snapshots.listen((QuerySnapshot querySnapshot) {
            // Get the number of documents in the collection
            numberOfDocuments1 = querySnapshot.docs.length;
          });

          final snapshots1 =
              firebaseFirestore.collection('userRentDetails').doc(user.uid).collection(user.uid).snapshots();

          var numberOfDocuments2;
          snapshots1.listen((QuerySnapshot querySnapshot) {
            // Get the number of documents in the collection
            numberOfDocuments2 = querySnapshot.docs.length;
          });

          final snapshots2 =
              firebaseFirestore.collection('userOldGoodsList').doc(user.uid).collection(user.uid).snapshots();

          var numberOfDocuments3;
          snapshots2.listen((QuerySnapshot querySnapshot) {
            // Get the number of documents in the collection
            numberOfDocuments3 = querySnapshot.docs.length;
          });

          Future.delayed(const Duration(seconds: 1), () async {
            if (numberOfDocuments1 == 0 && numberOfDocuments2 == 0 && numberOfDocuments3 == 0) {
             Navigator.pop(Get.context!);
              Get.toNamed(RoutesName.reAuthScreen);


            } else {
            Navigator.pop(Get.context!);
              Get.snackbar("Alert", "Please delete all your posted items first.");
            }
          });
        } catch (e) {
          print("delete :$e");
        }
      }
    });
  }

  static Future<void> deleteUserAccount() async {

    AppHelperFunction.checkInternetAvailability().then((value) async {
      if (value) {

        await firebaseFirestore
            .collection("loginUser")
            .doc(user.uid)
            .collection(auth.currentUser!.uid)
            .doc(user.uid)
            .delete();

        if (user.displayName.runtimeType.toString() != 'String') {
           print("delete");
          final refCoverImage = storage.refFromURL(userImage);
          await refCoverImage.delete();
        }
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.clear();

        Get.offAllNamed(RoutesName.loginScreen);
        Get.snackbar("Delete", "Successfully");
        await FirebaseAuth.instance.currentUser?.delete();
        //  delete a Firestorm
      }
    });
  }


  static Future<void>appShareLink()async{
    var collection = firebaseFirestore.collection("AppShareLink").doc('bnoq4yEHODF87E5TN5Tp');
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    appShareUrl = data?['link'] ?? '';


  }
}
