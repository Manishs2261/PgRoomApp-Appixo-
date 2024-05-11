import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../../model/old_goods_model/old_goods_model.dart';
import '../../../utils/logger/logger.dart';

class OldGoodsApis {
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

  static var id = '';
  static var imageUrl = '';
  static String coverImageFileName = '';



//==============Tiffine Services Apis =====================

  // create a tiffine services data base for main home collection
  static Future<void> addYourOldGoods(image, name, address, price, postdate, contactNumber) async {
    // model class
    final oldGoodsList = OldGoodsModel(
      address: address,
      image: image,
      name: name,
      contactNumber: contactNumber,
      postDate: postdate,
      price: price,
      coverImageId:coverImageFileName,
    );

    // store main list data
    return await firebaseFirestore.collection("oldGoods").doc(id).set(oldGoodsList.toJson());
  }

  // create a tiffine services data base for user data base
  static Future<void> addYourOldGoodsUserAccount(image, name, address, price, postdate, contactNumber) async {
    // model class
    final oldGoodsList = OldGoodsModel(
      address: address,
      image: image,
      name: name,
      contactNumber: contactNumber,
      postDate: postdate,
      price: price,
      coverImageId:coverImageFileName
    );

    // user list collection
    return await firebaseFirestore
        .collection("userOldGoodsList")
        .doc(user.uid)
        .collection(user.uid)
        .add(oldGoodsList.toJson())
        .then((value) {
      AppLoggerHelper.info(value.id);
      // for store unique item id
      id = value.id;
      return null;
    });
  }

  // upload Cover image data in firebase database
  static Future uploadOldGoodsImage(File imageFile) async {
    try {
      final reference = storage.ref().child('oldGoodsImage/${user.uid}/${DateTime.now()}.jpg');

      String updatedPath =reference.toString().substring(0, reference.toString().lastIndexOf(')'));
      List<String> pathSegments = updatedPath.split('/');
      coverImageFileName = pathSegments.last;

      final UploadTask uploadTask = reference.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      imageUrl = await snapshot.ref.getDownloadURL();
    } catch (e) {
      AppLoggerHelper.info("image is not uploaded ; $e");
    }
  }

//=========================================================

//==============Edit  Tiffine Services Apis ===============

  //update tiffine service  data
  static Future<void> updateOldGoodsData(name, address, price, itemId, contactNumber) async {
    //home list collection data base
    await firebaseFirestore
        .collection("oldGoods")
        .doc(itemId)
        .update({'price': price, 'address': address, 'name': name, 'contactNumber': contactNumber});
//user personal collection data base
    await firebaseFirestore
        .collection("userOldGoodsList")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'price': price, 'address': address, 'name': name, 'contactNumber': contactNumber});
  }

  // update cover Image data
  static Future<void> updateOldGoodsImage(File file, String itemId,String coverImageFileName) async {
    //getting image file extension
    final ext = file.path.split('.').last;
    AppLoggerHelper.info('Extension :$ext');
    
    print("cover :$coverImageFileName");

    // storage file ref with path
    final ref = storage.ref().child('oldGoodsImage/${user.uid}/$coverImageFileName');


    // uploading image
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((p0) {
      AppLoggerHelper.info('Data Transferred :${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firebase  database
    final imageUrl = await ref.getDownloadURL();

    //rent collection data base
    await firebaseFirestore.collection('oldGoods').doc(itemId).update({
      'image': imageUrl,
    });
//user personal collection data base
    await firebaseFirestore
        .collection("userOldGoodsList")
        .doc(user.uid)
        .collection(user.uid)
        .doc(itemId)
        .update({'image': imageUrl});
  }

//=========================================================

  //delete a data

  static Future<void> deleteOldGoodsData(String deleteId, coverImageUrl, menuImageUrl) async {
    try {
      //delete a Firestorm
      DocumentReference documentReference =
          firebaseFirestore.collection('userOldGoodsList').doc(user.uid).collection(user.uid).doc(deleteId);

      DocumentReference documentReference1 = firebaseFirestore.collection('oldGoods').doc(deleteId);

      // Delete the document.
      await documentReference.delete();
      await documentReference1.delete();
      //
      //   // delete a firestorm image data
      final refCoverImage = storage.refFromURL(coverImageUrl);
      await refCoverImage.delete();
    } catch (e) {
      AppLoggerHelper.info("data in not delete $e");
    }
  }
}
