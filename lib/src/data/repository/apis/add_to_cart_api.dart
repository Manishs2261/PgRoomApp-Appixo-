import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../model/old_goods_model/old_goods_model.dart';
import '../../../model/tiffin_services_model/tiffen_services_model.dart';
import '../../../model/user_rent_model/user_rent_model.dart';
import '../../../utils/logger/logger.dart';

class AddToCartApis {
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

  static Future<DocumentReference<Map<String, dynamic>>?> createAddToCartUserRoom(
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
      latitude: latitude,
      longitude: longitude,
    );

    await firebaseFirestore
        .collection("loginUser")
        .doc(user.uid)
        .collection(auth.currentUser!.uid)
        .doc(user.uid)
        .collection('addToCartRoom')
        .doc(itemId)
        .set(userHomeList.toJson());
    return null;
  }

  static Future<void> deleteAddToCartRoomData(itemId) async {
    await firebaseFirestore
        .collection("loginUser")
        .doc(user.uid)
        .collection(auth.currentUser!.uid)
        .doc(user.uid)
        .collection('addToCartRoom')
        .doc(itemId)
        .delete();
  }

  // create a tiffine services data base for user data base
  static Future<void> createAddToCartUserTiffine(
      coverImage, servicesName, address, price, menuImage, contactNumber, lati, lang, itemId) async {
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
        latitude: lati,
        longitude: lang);
    // user list collection

    await firebaseFirestore
        .collection("loginUser")
        .doc(user.uid)
        .collection(auth.currentUser!.uid)
        .doc(user.uid)
        .collection('addToCartFoods')
        .doc(itemId)
        .set(tiffineList.toJson());
    return;
  }

  static Future<void> deleteAddToCarTiffineData(itemId) async {
    await firebaseFirestore
        .collection("loginUser")
        .doc(user.uid)
        .collection(auth.currentUser!.uid)
        .doc(user.uid)
        .collection('addToCartFoods')
        .doc(itemId)
        .delete();
  }

  // create a tiffine services data base for main home collection
  static Future<void> createAddToCartOldGoods(image, name, address, price, postdate, contactNumber, itemId) async {
    // model class
    final oldGoodsList = OldGoodsModel(
      address: address,
      image: image,
      name: name,
      contactNumber: contactNumber,
      postDate: postdate,
      price: price,
    );

    await firebaseFirestore
        .collection("loginUser")
        .doc(user.uid)
        .collection(auth.currentUser!.uid)
        .doc(user.uid)
        .collection('addToCartGoods')
        .doc(itemId)
        .set(oldGoodsList.toJson());
    return;
  }

  static Future<void> deleteAddToCarGoodsData(itemId) async {
    await firebaseFirestore
        .collection("loginUser")
        .doc(user.uid)
        .collection(auth.currentUser!.uid)
        .doc(user.uid)
        .collection('addToCartGoods')
        .doc(itemId)
        .delete();
  }
}
