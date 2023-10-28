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
class ApisClass{


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


  //upload data in firebase for home screen

  static Future<void> rentDetailsHomeList(coverImage,houseName,
      address,cityName,landMark,contactNumber,bhk,roomType,singlePrice,
      doublePrice,triplePrice,fourPrice,faimlyPrice,restrictedTime,review,
       wifi, bed, chair, table,fan,gadda,light,locker,bedSheet,
      washingMachine,parking,
      electricityBill,waterBill,fexible,cooking,cookingType,boyAllow,
      girlAllow,faimalyMember,like)async{

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
      restrictedTime: restrictedTime
    );
    return await firestore.collection("rentCollection").doc(time).set(userHomeList
        .toJson());

  }


// crete a user new rrnt Details Collection

static Future<void>newRentDetailsCollection(String houseName,address,
    cityName,landMark,contuctNumber)async {

  final rentDetailsMoel =RentDetailsModel(
    houseName: houseName,
    address: address,
    cityName: cityName,
    landMark: landMark,
    contactNumber: cityName

  );
  return await firestore.collection('rentUser').doc(user.uid).collection
    ('rentDetails').doc(time).set(rentDetailsMoel.toJson());


}



//crete a new pgRoom and falt type and price

static Future<void>pgRoomAndFlatTypePrice(String roomType,bhk,singleP,doubleP,
    triplep,fourP,faimly)async {

  final pgRoomPrice = PgRoomAndFlatTypeModel(

    roomType: roomType,
    bhkType: bhk,
    singlePersonPrice: singleP,
    doublePersionPrice: doubleP,
    triplePersionPrice: triplep,
    fourPersionPrice: fourP,
    faimlyPrice: faimly,
  );

     return await firestore.collection('rentUser').doc(user.uid).collection
       ('pgRoomAndFlatType').doc(time).set(pgRoomPrice.toJson());

}


//create a provide facilites firebase

static Future<void>newProvidFacilites(bool wifi,bed,chair,table,fan,gadda,
    light,locker,bedSheet,washingMachin,parking)async {

  final provide = ProvideFacilitesModel(
    wifi: wifi,
    bed: bed,
    chair: chair,
    table: table,
    fan: fan,
    gadda: gadda,
    light: light,
    locker: locker,
    bedSheet: bedSheet,
    washingMachin: washingMachin,
    parking: parking
  );
  return await firestore.collection('rentUser').doc(user.uid).collection
    ('providFacilites').doc(time).set(provide.toJson());

}

//for crete a additional charges
static Future<void>newAdditionChargesAndDoorClosing(String restricted,bool
electricity,water,fexibleTime)
async {

  final charges = AdditionChargesAndDoorClosingModel(
    electricityBill: electricity,
    fexibleTime: fexibleTime,
    restrictedTime: restricted,
    waterBill: water
  );

  return await firestore.collection('rentUser').doc(user.uid).collection
    ('otherCharges').doc(time).set(charges.toJson());
}


//create a new permission

static Future<void>newPermission(bool cookingAllow,cookingType,girl,boy,
    faimlyMember)
async {

  final permission = PermissionModel(
    boy: boy,
    cooking: cookingAllow,
    cookingType: cookingType,
    faimlyMember: faimlyMember,
    girl: girl
  );

  return await firestore.collection('rentUser').doc(user.uid).collection
    ('permission').doc(time).set(permission.toJson());


}


// uplaoad  Cover image data in firestorev database
  static Future uploadCoverImage(File imageFile )async{

    try{
      final reference = storage.ref().child('coverimage/${user.uid}/${DateTime
          .now()}.jpg');
      final UploadTask uploadTask = reference.putFile(imageFile);

      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      download = await snapshot.ref.getDownloadURL();
      print("user $user");
      print("url : $download");
    }catch(e)
    {
      print("image is not uploaded ; $e");
    }
  }


  //upload other images in firestore databse
static Future uploadOtherImage(File imageFile)async{

  try{
    final reference = storage.ref().child('otherimage/${DateTime.now()}.jpg');
    final UploadTask uploadTask = reference.putFile(imageFile);

    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    download = await snapshot.ref.getDownloadURL();

    print("url : $download");

  }catch(e)
  {
    print("image is not uploaded ; $e");
  }
}




}
