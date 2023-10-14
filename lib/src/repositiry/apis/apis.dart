import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pgroom/src/model/rent_details_model/rent_details_model.dart';

class ApisClass{


  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  //to return current user
  static User get user => auth.currentUser!;

  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // fpr storing self   `information
  static FirebaseStorage storage = FirebaseStorage.instance;

// crete a user new rrnt Details Collection

static Future<void>newRentDetailsCollection(String houseName,address,
    cityName,landMark,contuctNumber)async {

  final time = DateTime.now().microsecondsSinceEpoch.toString();

  final rentDetailsMoel =RentDetailsModel(
    houseName: houseName,
    address: address,
    cityName: cityName,
    landMark: landMark,
    contactNumber: cityName

  );
  return firestore.collection('rentUser').doc(user.uid).collection
    ('rentDetails').doc(time).set(rentDetailsMoel.toJson());


}

}