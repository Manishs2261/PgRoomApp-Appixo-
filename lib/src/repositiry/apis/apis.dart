import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pgroom/src/model/additional_charges_and_door_cloging_model/additional_charges_and_door_cloging_model.dart';
import 'package:pgroom/src/model/permission_model/permission_model.dart';
import 'package:pgroom/src/model/provide_facilites_models/provides_facilites_models.dart';
import 'package:pgroom/src/model/rent_details_model/rent_details_model.dart';
import 'package:pgroom/src/model/user_rent_model/user_rent_model.dart';

import '../../model/pgroomm_and_flat_type_model/pgroom_and_flat_type_model.dart';
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
  static Future<void> deleteData(String deleteId) async {
    try {
      //delete a firebasestore
      DocumentReference documentReference = firestore
          .collection('userRentDetails')
          .doc(user.uid)
          .collection("${user.uid}")
          .doc(deleteId);
      DocumentReference documentReference1 =
          firestore.collection('rentCollection').doc(deleteId);

      // // Delete the document.
      await documentReference.delete();
      await documentReference1.delete();
      //
      // // delete a firestorege image data
      // final reff = storage.refFromURL(imageUrl);
      // await reff.delete();

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
}
