import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pgroom/src/model/additional_charges_and_door_cloging_model/additional_charges_and_door_cloging_model.dart';
import 'package:pgroom/src/model/provide_facilites_models/provides_facilites_models.dart';
import 'package:pgroom/src/model/rent_details_model/rent_details_model.dart';

import '../../model/pgroomm_and_flat_type_model/pgroom_and_flat_type_model.dart';

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

}