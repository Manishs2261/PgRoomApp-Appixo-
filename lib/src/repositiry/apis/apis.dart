import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:pgroom/src/model/user_rent_model/user_rent_model.dart';

import 'dart:io';

class ApisClass {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //to return current user
  static User get user => auth.currentUser!;

  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // fpr storing self   `information
  static FirebaseStorage storage = FirebaseStorage.instance;

  static final time = DateTime.now().microsecondsSinceEpoch.toString();
  static var download;
  static var userRentId = "";
  static var userName;

  static var userEmail;
  static var userCity;
  static var  houseNameMap ;

  static UserRentModel model = UserRentModel();
 static List<UserRentModel> allDataList = [];


  //upload data in firebase for home screen list
  // in list all data in one collection
  // user collection documnet id and home list id is same

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
    return await firestore
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
        .collection("${user.uid}")
        .add(userHomeList.toJson())
        .then((value) {
      print(value.id);
      userRentId = value.id;
      return null;
    });
  }

  // delete data code
  static Future<void> deleteData(String deleteId, String imageUrl) async {
    try {
      //delete a firebasestore
      DocumentReference documentReference = firestore
          .collection('userRentDetails')
          .doc(user.uid)
          .collection("${user.uid}")
          .doc(deleteId);
      DocumentReference documentReference1 =
          firestore.collection('rentCollection').doc(deleteId);

      // Delete the document.
      await documentReference.delete();
      await documentReference1.delete();
      //
      // delete a firestorege image data
      final reff = storage.refFromURL(imageUrl);
      await reff.delete();

      print("deleted");
    } catch (e) {
      print("data in not delete $e");
    }
  }

// uplaoad  Cover image data in firestorev database
  static Future uploadCoverImage(File imageFile) async {
    try {
      final reference =
          storage.ref().child('coverimage/${user.uid}/${DateTime.now()}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);

      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      download = await snapshot.ref.getDownloadURL();
    } catch (e) {
      print("image is not uploaded ; $e");
    }
  }

  //upload other images in firestore databse
  static Future uploadOtherImage(File imageFile) async {
    try {
      final reference = storage.ref().child('otherimage/${DateTime.now()}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);

      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      download = await snapshot.ref.getDownloadURL();

      print("url : $download");
    } catch (e) {
      print("image is not uploaded ; $e");
    }
  }

  //update profile picture of user

  static Future<void> updateItemImage(File file, String itmeId) async {
    //getting image file extenstion
    final ext = file.path.split('.').last;
    log('Extension :$ext');

    // storage file ref with path
    final ref = storage.ref().child('coverimage/${user.uid}.$ext');

    // uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred :${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firestore database
    model.coverImage = await ref.getDownloadURL();
    await firestore
        .collection('rentCollection')
        .doc(itmeId)
        .update({'coverImage': model.coverImage});

    await firestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection("${user.uid}")
        .doc(itmeId)
        .update({'coverImage': model.coverImage});
  }

  //update Rent Details data

  static Future<void> updateRentDetilaData(
      name, address, city, landMark, number, itemID) async {
    await firestore.collection("rentCollection").doc(itemID).update({
      'houseName': name,
      'contactNumber': number,
      'landMark': landMark,
      'city': city,
      'addres': address
    });

    await firestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection("${user.uid}")
        .doc(itemID)
        .update({
      'houseName': name,
      'contactNumber': number,
      'landMark': landMark,
      'city': city,
      'addres': address
    });
  }

  // update Room type And Price Data

  static Future<void> updateRoomTypeAndPrice(
      itemId, single, double, triple, four, faimly) async {
    await firestore.collection("rentCollection").doc(itemId).update({
      'doublePersionPrice': double,
      'triplePersionPrice': triple,
      'faimlyPrice': faimly,
      'fourPersionPrice': four,
      'singlePersonPrice': single
    });

    await firestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection("${user.uid}")
        .doc(itemId)
        .update({
      'doublePersionPrice': double,
      'triplePersionPrice': triple,
      'faimlyPrice': faimly,
      'fourPersionPrice': four,
      'singlePersonPrice': single
    });
  }

// update provide Facilites Data

  static Future<void> updateProvideFacilitesData(
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
      parking) async {
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

    await firestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection("${user.uid}")
        .doc(itemId)
        .update({
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

  // update Additional Chages And Door closing time
  static Future<void> updateAdditionalCharesAndDoorDate(
      itemId, electricity, water, restrictTime, fexibleTime) async {
    await firestore.collection("rentCollection").doc(itemId).update({
      'fexibleTime': fexibleTime,
      'restrictedTime': restrictTime,
      'waterBill': water,
      'electricityBill': electricity,
    });

    await firestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection("${user.uid}")
        .doc(itemId)
        .update({
      'fexibleTime': fexibleTime,
      'restrictedTime': restrictTime,
      'waterBill': water,
      'electricityBill': electricity,
    });
  }

  //update Permmission
  static Future<void> updatePermissionData(
      itemId, cookinType, cooking, boy, girl, faimlyMember) async {
    await firestore.collection("rentCollection").doc(itemId).update({
      'girls': girl,
      'boy': boy,
      'cooking': cooking,
      'cookingType': cookinType,
      'faimlyMember': faimlyMember
    });

    await firestore
        .collection("userRentDetails")
        .doc(user.uid)
        .collection("${user.uid}")
        .doc(itemId)
        .update({
      'girls': girl,
      'boy': boy,
      'cooking': cooking,
      'cookingType': cookinType,
      'faimlyMember': faimlyMember
    });
  }

  //Get all data in list

  static Future<void> getUserData() async {
    //
    // var collection = firestore.collection('loginUser');
    // var querySnapshot = await collection.get();
    // for (var queryDocumentSnapshot in querySnapshot.docs) {
    //   Map<String, dynamic> data = queryDocumentSnapshot.data();
    //   var name = data['name'];
    //   var phone = data['city'];
    // }

    var collection = firestore.collection('loginUser').doc(user.uid);
    var querySnapshot = await collection.get();

    Map<String, dynamic>? data = querySnapshot.data();
    userName = data?['Name'];
    userCity = data?['city'];
    userEmail = data?['email'];
  }


  static Future<void> getAllItemData()async{

    var collection = firestore.collection('rentCollection');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var name = data['city'];
       houseNameMap = data['houseName'];

    }

  }


  // store a user data
  static Future<void> saveUserData(name, city, email) async {
    await firestore.collection("loginUser").doc(user.uid).set({
      'city': city,
      'email': email,
      'Name': name,
    });
  }
}
