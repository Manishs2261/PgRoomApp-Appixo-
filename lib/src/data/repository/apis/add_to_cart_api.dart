import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../model/user_rent_model/user_rent_model.dart';
import '../../../utils/logger/logger.dart';

class AddToCartApis{


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



  // this data store in data in user profile specific

  static Future<DocumentReference<Map<String, dynamic>>?> createAddToCartUser(
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
      itemId,
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
      latitude:latitude,
      longitude: longitude,
    );

    await firebaseFirestore
        .collection("loginUser")
        .doc(user.uid)
        .collection(auth.currentUser!.uid)
        .doc(user.uid)
        .collection('addToCart')
        .doc(itemId)
        .set(
      userHomeList.toJson()
    );
    return null;
  }






}
