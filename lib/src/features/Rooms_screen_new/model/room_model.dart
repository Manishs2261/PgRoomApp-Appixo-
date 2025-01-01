import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RoomModel {
  String? city;
  String? mealsAvailable;
  String? latitude;
  String? triplePersonCost;
  String? houseName;
  String? uId;
  String? isRoomAvailableDate;
  String? atUpdate;
  String? state;
  List<String>? houseRules;
  String? landmark;
  String? roomType;
  String? genderType;
  String? flatType;
  String? doublePersonCost;
  String? homeAddress;
  String? longitude;
  String? atCreate;
  String? depositAmount;
  String? roomCategory;
  String? triplePlusCost;
  bool? isDelete;
  String? totalRoom;
  List<HouseFAQ>? houseFAQ;
  List<Report>? reportList;
  String? roomOwnershipType;
  String? singlePersonCost;
  bool? disable;
  List<String>? roomFacilityList;
  List<String>? report;
  List<String>? billsList;
  String? noticePride;
  String? rId;
  List<String>? imageList;
  List<String>? commonAreasList;
  String? familyCost;
  String? userDocId;
  String? userName;
  String? mobileNumber;
  String? userImage;


  RoomModel(
      {this.city,
        this.mealsAvailable,
        this.latitude,
        this.triplePersonCost,
        this.houseName,
        this.uId,
        this.isRoomAvailableDate,
        this.atUpdate,
        this.state,
        this.houseRules,
        this.landmark,
        this.roomType,
        this.genderType,
        this.doublePersonCost,
        this.homeAddress,
        this.longitude,
        this.atCreate,
        this.depositAmount,
        this.roomCategory,
        this.triplePlusCost,
        this.isDelete,
        this.totalRoom,
        this.houseFAQ,
        this.roomOwnershipType,
        this.singlePersonCost,
        this.disable,
        this.roomFacilityList,
        this.report,
        this.billsList,
        this.noticePride,
        this.rId,
        this.imageList,
        this.commonAreasList,
        this.familyCost,
        this.reportList,
        this.flatType,
        this.userDocId,
        this.userName,
        this.mobileNumber,
        this.userImage
      });

  RoomModel.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    mealsAvailable = json['mealsAvailable'];
    latitude = json['latitude'];
    triplePersonCost = json['triple_person_cost'];
    houseName = json['houseName'];
    uId = json['u_id'];
    userDocId = json['userDocId'];
    userName = json['userName'];
    mobileNumber = json['mobileNumber'];
    userImage = json['userImage'];
    isRoomAvailableDate = json['isRoomAvailableDate'];
    atUpdate = json['atUpdate'];
    state = json['state'];
    houseRules = json['houseRules'].cast<String>();
    landmark = json['landmark'];
    roomType = json['roomType'];
    genderType = json['genderType'];
    flatType = json['flatType'];
    doublePersonCost = json['double_person_cost'];
    homeAddress = json['homeAddress'];
    longitude = json['longitude'];
    atCreate = json['atCreate'];
    depositAmount = json['depositAmount'];
    roomCategory = json['roomCategory'];
    triplePlusCost = json['triple_plus_cost'];
    isDelete = json['isDelete'];
    totalRoom = json['totalRoom'];
    if (json['houseFAQ'] != null) {
      houseFAQ = <HouseFAQ>[];
      json['houseFAQ'].forEach((v) {
        houseFAQ!.add(new HouseFAQ.fromJson(v));
      });
    }
    if (json['report'] != null) {
      reportList = <Report>[];
      json['report'].forEach((v) {
        reportList!.add(new Report.fromJson(v));
      });
    }
    roomOwnershipType = json['roomOwnershipType'];
    singlePersonCost = json['single_person_cost'];
    disable = json['disable'];
    roomFacilityList = json['roomFacilityList'].cast<String>();
    report = json['report'].cast<String>();
    billsList = json['billsList'].cast<String>();
    noticePride = json['notice_pride'];
    rId = json['r_id'];
    imageList = json['imageList'].cast<String>();
    commonAreasList = json['commonAreasList'].cast<String>();
    familyCost = json['family_cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['mealsAvailable'] = this.mealsAvailable;
    data['latitude'] = this.latitude;
    data['triple_person_cost'] = this.triplePersonCost;
    data['houseName'] = this.houseName;
    data['u_id'] = this.uId;
    data['userDocId'] = this.userDocId;
    data['userName'] = this.userName;
    data['mobileNumber'] = this.mobileNumber;
    data['userImage'] = this.userImage;
    data['isRoomAvailableDate'] = this.isRoomAvailableDate;
    data['atUpdate'] = this.atUpdate;
    data['state'] = this.state;
    data['houseRules'] = this.houseRules;
    data['landmark'] = this.landmark;
    data['roomType'] = this.roomType;
    data['genderType'] = this.genderType;
    data['flatType'] = this.flatType;
    data['double_person_cost'] = this.doublePersonCost;
    data['homeAddress'] = this.homeAddress;
    data['longitude'] = this.longitude;
    data['atCreate'] = this.atCreate;
    data['depositAmount'] = this.depositAmount;
    data['roomCategory'] = this.roomCategory;
    data['triple_plus_cost'] = this.triplePlusCost;
    data['isDelete'] = this.isDelete;
    data['totalRoom'] = this.totalRoom;
    if (this.houseFAQ != null) {
      data['houseFAQ'] = this.houseFAQ!.map((v) => v.toJson()).toList();
    }
    if (this.reportList != null) {
      data['report'] = this. reportList!.map((v) => v.toJson()).toList();
    }
    data['roomOwnershipType'] = this.roomOwnershipType;
    data['single_person_cost'] = this.singlePersonCost;
    data['disable'] = this.disable;
    data['roomFacilityList'] = this.roomFacilityList;
    data['report'] = this.report;
    data['billsList'] = this.billsList;
    data['notice_pride'] = this.noticePride;
    data['r_id'] = this.rId;
    data['imageList'] = this.imageList;
    data['commonAreasList'] = this.commonAreasList;
    data['family_cost'] = this.familyCost;
    return data;
  }
}

class HouseFAQ {
  String? question;
  String? answer;

  HouseFAQ({this.question, this.answer});

  HouseFAQ.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['answer'] = this.answer;
    return data;
  }
}

class  Report {
  String? date;
  String? description;
  DocumentReference? userRef ;

  Report({this.date, this.description, this.userRef});

  Report.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    description = json['description'];
    userRef = json['userRef'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['description'] = this.description;
    data['userRef'] = this.userRef;
    return data;
  }
}
