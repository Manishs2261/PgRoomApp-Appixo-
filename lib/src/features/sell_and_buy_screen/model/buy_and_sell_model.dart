import 'package:cloud_firestore/cloud_firestore.dart';

class BuyAndSellModel {
  String? atCreate;
  List<String>? image;
  String? address;
  String? city;
  bool? isDelete;
  String? description;
  String? itemName;
  String? uId; // Firebase Authentication UID
  DocumentReference? userReference; // Firestore user reference
  String? atUpdate;
  bool? disable;
  String? price;
  List<String>? report;
  String? state;
  String? landmark;
  String? sabId;

  BuyAndSellModel({
    this.atCreate,
    this.image,
    this.address,
    this.city,
    this.isDelete,
    this.description,
    this.itemName,
    this.uId,
    this.userReference,
    this.atUpdate,
    this.disable,
    this.price,
    this.report,
    this.state,
    this.landmark,
    this.sabId,
  });

  BuyAndSellModel.fromJson(Map<String, dynamic> json) {
    atCreate = json['atCreate'];
    image = json['image']?.cast<String>();
    address = json['address'];
    city = json['city'];
    isDelete = json['isDelete'];
    description = json['description'];
    itemName = json['itemName'];
    uId = json['u_id'];
    userReference = json['userReference'] != null
        ? FirebaseFirestore.instance.doc(json['userReference'])
        : null;
    atUpdate = json['atUpdate'];
    disable = json['disable'];
    price = json['price'];
    report = json['report']?.cast<String>();
    state = json['state'];
    landmark = json['landmark'];
    sabId = json['sab_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['atCreate'] = this.atCreate;
    data['image'] = this.image;
    data['address'] = this.address;
    data['city'] = this.city;
    data['isDelete'] = this.isDelete;
    data['description'] = this.description;
    data['itemName'] = this.itemName;
    data['u_id'] = this.uId;
    data['userReference'] = this.userReference?.path; // Store reference path
    data['atUpdate'] = this.atUpdate;
    data['disable'] = this.disable;
    data['price'] = this.price;
    data['report'] = this.report;
    data['state'] = this.state;
    data['landmark'] = this.landmark;
    data['sab_id'] = this.sabId;
    return data;
  }
}
