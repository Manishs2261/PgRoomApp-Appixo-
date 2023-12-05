class UserRentModel {
  bool? parking;
  String? bhkType;
  bool? bed;
  String? city;
  String? doublePersonPrice;
  bool? washingMachine;
  bool? girls;
  bool? familyMember;
  bool? boy;
  bool? waterBill;
  String? landMark;
  bool? locker;
  String? triplePersonPrice;
  String? houseName;
  bool? fan;
  String? review;
  String? coverImage;
  String? contactNumber;
  String? restrictedTime;
  bool? cooking;
  bool? gadda;
  String? roomType;
  bool? table;
  String? familyPrice;
  bool? wifi;
  bool? like;
  bool? chair;
  String? address;
  bool? bedSheet;
  bool? electricityBill;
  bool? light;
  String? fourPersonPrice;
  bool? flexibleTime;
  String? singlePersonPrice;
  String? cookingType;
  String? userRentId;
  bool? attachBathRoom;
  bool? shareAbleBathRoom;

  UserRentModel({
    this.parking,
    this.bhkType,
    this.bed,
    this.city,
    this.doublePersonPrice,
    this.washingMachine,
    this.girls,
    this.familyMember,
    this.boy,
    this.waterBill,
    this.landMark,
    this.locker,
    this.triplePersonPrice,
    this.houseName,
    this.fan,
    this.review,
    this.coverImage,
    this.contactNumber,
    this.restrictedTime,
    this.cooking,
    this.gadda,
    this.roomType,
    this.table,
    this.familyPrice,
    this.wifi,
    this.like,
    this.chair,
    this.address,
    this.bedSheet,
    this.electricityBill,
    this.light,
    this.fourPersonPrice,
    this.flexibleTime,
    this.singlePersonPrice,
    this.cookingType,
    this.userRentId,
    this.attachBathRoom,
    this.shareAbleBathRoom,
  });

  UserRentModel.fromJson(Map<String, dynamic> json) {
    parking = json['parking'];
    bhkType = json['BhkType'];
    bed = json['bed'];
    city = json['city'];
    doublePersonPrice = json['doublePersonPrice'];
    washingMachine = json['washingMachine'];
    girls = json['girls'];
    familyMember = json['familyMember'];
    boy = json['boy'];
    waterBill = json['waterBill'];
    landMark = json['landMark'];
    locker = json['locker'];
    triplePersonPrice = json['triplePersonPrice'];
    houseName = json['houseName'];
    fan = json['fan'];
    review = json['review'];
    coverImage = json['coverImage'];
    contactNumber = json['contactNumber'];
    restrictedTime = json['restrictedTime'];
    cooking = json['cooking'];
    gadda = json['gadda'];
    roomType = json['roomType'];
    table = json['table'];
    familyPrice = json['familyPrice'];
    wifi = json['wifi'];
    like = json['like'];
    chair = json['chair'];
    address = json['address'];
    bedSheet = json['bedSheet'];
    electricityBill = json['electricityBill'];
    light = json['light'];
    fourPersonPrice = json['fourPersonPrice'];
    flexibleTime = json['flexibleTime'];
    singlePersonPrice = json['singlePersonPrice'];
    cookingType = json['cookingType'];
    userRentId = json['userRentId'];
    attachBathRoom = json["attachBathRoom"] ?? false;
    shareAbleBathRoom = json["shareAbleBathRoom"] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parking'] = this.parking;
    data['BhkType'] = this.bhkType;
    data['bed'] = this.bed;
    data['city'] = this.city;
    data['doublePersonPrice'] = this.doublePersonPrice;
    data['washingMachine'] = this.washingMachine;
    data['girls'] = this.girls;
    data['familyMember'] = this.familyMember;
    data['boy'] = this.boy;
    data['waterBill'] = this.waterBill;
    data['landMark'] = this.landMark;
    data['locker'] = this.locker;
    data['triplePersonPrice'] = this.triplePersonPrice;
    data['houseName'] = this.houseName;
    data['fan'] = this.fan;
    data['review'] = this.review;
    data['coverImage'] = this.coverImage;
    data['contactNumber'] = this.contactNumber;
    data['restrictedTime'] = this.restrictedTime;
    data['cooking'] = this.cooking;
    data['gadda'] = this.gadda;
    data['roomType'] = this.roomType;
    data['table'] = this.table;
    data['familyPrice'] = this.familyPrice;
    data['wifi'] = this.wifi;
    data['like'] = this.like;
    data['chair'] = this.chair;
    data['address'] = this.address;
    data['bedSheet'] = this.bedSheet;
    data['electricityBill'] = this.electricityBill;
    data['light'] = this.light;
    data['fourPersonPrice'] = this.fourPersonPrice;
    data['flexibleTime'] = this.flexibleTime;
    data['singlePersonPrice'] = this.singlePersonPrice;
    data['cookingType'] = this.cookingType;
    data['userRentId'] = this.userRentId;
    data['attachBathRoom'] = this.attachBathRoom;
    data['shareAbleBathRoom'] = this.shareAbleBathRoom;
    return data;
  }
}
