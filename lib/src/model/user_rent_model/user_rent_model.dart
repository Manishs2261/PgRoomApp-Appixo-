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
  String? numberOfRooms;
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
  double? average;
  int? numberOfRating;
  bool? roomAvailable;
  String? latitude;
  String? longitude;
  String? coverImageId;

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
    this.numberOfRooms,
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
    this.average,
    this.numberOfRating,
    this.roomAvailable,
    this.longitude,
    this.latitude,
    this.coverImageId,
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
    numberOfRooms = json['numberOfRooms'] ?? '0';
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
    average = json['average'] ?? 0.0;
    numberOfRating = json['numberOfRating'] ?? 0;
    roomAvailable = json['roomAvailable'] ?? true;
    longitude = json['longitude'];
    latitude = json['latitude'];
    coverImageId = json['coverImageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parking'] = parking;
    data['BhkType'] = bhkType;
    data['bed'] = bed;
    data['city'] = city;
    data['doublePersonPrice'] = doublePersonPrice;
    data['washingMachine'] = washingMachine;
    data['girls'] = girls;
    data['familyMember'] = familyMember;
    data['boy'] = boy;
    data['waterBill'] = waterBill;
    data['landMark'] = landMark;
    data['locker'] = locker;
    data['triplePersonPrice'] = triplePersonPrice;
    data['houseName'] = houseName;
    data['fan'] = fan;
    data['numberOfRooms'] = numberOfRooms;
    data['coverImage'] = coverImage;
    data['contactNumber'] = contactNumber;
    data['restrictedTime'] = restrictedTime;
    data['cooking'] = cooking;
    data['gadda'] = gadda;
    data['roomType'] = roomType;
    data['table'] = table;
    data['familyPrice'] = familyPrice;
    data['wifi'] = wifi;
    data['like'] = like;
    data['chair'] = chair;
    data['address'] = address;
    data['bedSheet'] = bedSheet;
    data['electricityBill'] = electricityBill;
    data['light'] = light;
    data['fourPersonPrice'] = fourPersonPrice;
    data['flexibleTime'] = flexibleTime;
    data['singlePersonPrice'] = singlePersonPrice;
    data['cookingType'] = cookingType;
    data['userRentId'] = userRentId;
    data['attachBathRoom'] = attachBathRoom;
    data['shareAbleBathRoom'] = shareAbleBathRoom;
    data['average'] = average;
    data['numberOfRating'] = numberOfRating;
    data['roomAvailable'] = roomAvailable;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['coverImageId'] = coverImageId;

    return data;
  }
}
