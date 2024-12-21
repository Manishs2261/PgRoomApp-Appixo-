import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pgroom/src/features/auth_screen/Model/user_model.dart';
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

  static Future<bool> getUserUid(String uid) async {
    try {
      List<String> userUIDs = [];

      final querySnapshot =
          await FirebaseFirestore.instance.collection('DevUser').get();

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        if (data['u_id'] != null && data['u_id'] is String) {
          userUIDs.add(data['u_id'] as String);
        }
      }
      print(userUIDs);
      if (userUIDs.contains(uid)) {
        return true;
      }
      return false; // Return the list of user UIDs
    } catch (e) {
      // Handle errors and return an empty list in case of failure
      AppLoggerHelper.error("Error fetching user UIDs: $e");
      return false;
    }
  }

  //Get all data in user
  static Future<void> getUserData() async {
    var collection = firebaseFirestore.collection('loginUser').doc(user.uid);
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    userName = data?['Name'] ?? '';
    userCity = data?['city'] ?? '';
    userEmail = data?['email'] ?? '';
    userImage = data?['userImage'] ?? '';
  }

  // save a user data
  static Future<void> saveUserData(name, city, email, image) async {
    await firebaseFirestore.collection("loginUser").doc(user.uid).set({
      'city': city,
      'email': email,
      'Name': name,
      'userImage': image,
      'uid': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
      // Timestamp when document is created
      'updatedAt': FieldValue.serverTimestamp(),
      // Timestamp when document is updated
    });
  }

  static Future<void> updateUserData(name, city) async {
    await firebaseFirestore
        .collection("loginUser")
        .doc(user.uid)
        .collection(user.uid)
        .doc(user.uid)
        .update({
      'city': city,
      'Name': name,
    });
  }

  // update user Image data
  static Future<void> updateUserImage(File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    AppLoggerHelper.info('Extension :$ext');

    // storage file ref with path
    final ref = storage.ref().child('userImage/${user.uid}.$ext');

    // uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      AppLoggerHelper.info(
          'Data Transferred :${p0.bytesTransferred / 1000} kb');
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
          final snapshots = firebaseFirestore
              .collection('userTiffineCollection')
              .doc(user.uid)
              .collection(user.uid)
              .snapshots();

          var numberOfDocuments1;
          snapshots.listen((QuerySnapshot querySnapshot) {
            // Get the number of documents in the collection
            numberOfDocuments1 = querySnapshot.docs.length;
          });

          final snapshots1 = firebaseFirestore
              .collection('userRentDetails')
              .doc(user.uid)
              .collection(user.uid)
              .snapshots();

          var numberOfDocuments2;
          snapshots1.listen((QuerySnapshot querySnapshot) {
            // Get the number of documents in the collection
            numberOfDocuments2 = querySnapshot.docs.length;
          });

          final snapshots2 = firebaseFirestore
              .collection('userOldGoodsList')
              .doc(user.uid)
              .collection(user.uid)
              .snapshots();

          var numberOfDocuments3;
          snapshots2.listen((QuerySnapshot querySnapshot) {
            // Get the number of documents in the collection
            numberOfDocuments3 = querySnapshot.docs.length;
          });

          Future.delayed(const Duration(seconds: 1), () async {
            if (numberOfDocuments1 == 0 &&
                numberOfDocuments2 == 0 &&
                numberOfDocuments3 == 0) {
              Navigator.pop(Get.context!);
              Get.toNamed(RoutesName.reAuthScreen);
            } else {
              Navigator.pop(Get.context!);
              Get.snackbar(
                  "Alert", "Please delete all your posted items first.");
            }
          });
        } catch (e) {
          if (kDebugMode) {
            print("delete :$e");
          }
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

  static Future<void> appShareLink() async {
    var collection = firebaseFirestore
        .collection("AppShareLink")
        .doc('bnoq4yEHODF87E5TN5Tp');
    var querySnapshot = await collection.get();
    Map<String, dynamic>? data = querySnapshot.data();
    appShareUrl = data?['link'] ?? '';
  }

  static Future<bool> createNewUser(
      String name, String city, String imageUrl, String email) async {
    AppHelperFunction.showCenterCircularIndicator(true);

    try {
      final item = UserModel(
        uId: user.uid,
        image: imageUrl,
        name: name,
        city: city,
        atCreate: DateTime.now().toString(),
        atUpdate: DateTime.now().toString(),
        email: email,
        docId: '',
      );

      try {
        DocumentReference docRef = await FirebaseFirestore.instance
            .collection("DevUser")
            .add(item.toJson())
            .timeout(const Duration(seconds: 2000), onTimeout: () {
          Navigator.pop(Get.context!);
          throw TimeoutException("The operation timed out after 2000 seconds");
        });

        // Update the document with its ID
        await FirebaseFirestore.instance
            .collection("DevUser")
            .doc(docRef.id)
            .update({
          'docId': docRef.id,
        }).whenComplete(() {
          Navigator.pop(Get.context!);
          AppLoggerHelper.info(
              "Document added successfully with ID: ${docRef.id}");
        });
        UserApis.setSharedPreferences(user.uid);
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
        return false;
      }
    } catch (e) {
      Navigator.pop(Get.context!);
      AppLoggerHelper.error("Error adding document: $e");
      return false; // Return false for general errors
    }
  }

  //upload user images in firebase database
  static Future<String> uploadUserImage(File imageFile) async {
    try {
      final reference = storage.ref().child('DevUserImage/${user.uid}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      userImageDownloadUrl = await snapshot.ref.getDownloadURL();

      await firebaseFirestore
          .collection('loginUser')
          .doc(user.uid)
          .update({'userImage': userImageDownloadUrl});
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
    return userImageDownloadUrl;
  }


 static Future<void> setSharedPreferences(String uid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Upload user UID data in SharedPreferences
    preferences.setString('userUid', uid);
  }

 static Future<String?> getSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Retrieve the user UID from SharedPreferences
    return preferences.getString('userUid');
  }



}
