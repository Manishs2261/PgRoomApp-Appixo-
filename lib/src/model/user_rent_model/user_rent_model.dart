class UserRentModel {
  bool? parking;
  String? bhkType;
  bool? bed;
  String? city;
  String? doublePersionPrice;
  bool? washingMachin;
  bool? girls;
  bool? faimlyMember;
  bool? boy;
  bool? waterBill;
  String? landMark;
  bool? locker;
  String? triplePersionPrice;
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
  String? faimlyPrice;
  bool? wifi;
  bool? like;
  bool? chair;
  String? addres;
  bool? bedSheet;
  bool? electricityBill;
  bool? light;
  String? fourPersionPrice;
  bool? fexibleTime;
  String? singlePersonPrice;
  String? cookingType;

  UserRentModel(
      {this.parking,
        this.bhkType,
        this.bed,
        this.city,
        this.doublePersionPrice,
        this.washingMachin,
        this.girls,
        this.faimlyMember,
        this.boy,
        this.waterBill,
        this.landMark,
        this.locker,
        this.triplePersionPrice,
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
        this.faimlyPrice,
        this.wifi,
        this.like,
        this.chair,
        this.addres,
        this.bedSheet,
        this.electricityBill,
        this.light,
        this.fourPersionPrice,
        this.fexibleTime,
        this.singlePersonPrice,
        this.cookingType});

  UserRentModel.fromJson(Map<String, dynamic> json) {
    parking = json['parking'];
    bhkType = json['BhkType'];
    bed = json['bed'];
    city = json['city'];
    doublePersionPrice = json['doublePersionPrice'];
    washingMachin = json['washingMachin'];
    girls = json['girls'];
    faimlyMember = json['faimlyMember'];
    boy = json['boy'];
    waterBill = json['waterBill'];
    landMark = json['landMark'];
    locker = json['locker'];
    triplePersionPrice = json['triplePersionPrice'];
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
    faimlyPrice = json['faimlyPrice'];
    wifi = json['wifi'];
    like = json['like'];
    chair = json['chair'];
    addres = json['addres'];
    bedSheet = json['bedSheet'];
    electricityBill = json['electricityBill'];
    light = json['light'];
    fourPersionPrice = json['fourPersionPrice'];
    fexibleTime = json['fexibleTime'];
    singlePersonPrice = json['singlePersonPrice'];
    cookingType = json['cookingType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parking'] = this.parking;
    data['BhkType'] = this.bhkType;
    data['bed'] = this.bed;
    data['city'] = this.city;
    data['doublePersionPrice'] = this.doublePersionPrice;
    data['washingMachin'] = this.washingMachin;
    data['girls'] = this.girls;
    data['faimlyMember'] = this.faimlyMember;
    data['boy'] = this.boy;
    data['waterBill'] = this.waterBill;
    data['landMark'] = this.landMark;
    data['locker'] = this.locker;
    data['triplePersionPrice'] = this.triplePersionPrice;
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
    data['faimlyPrice'] = this.faimlyPrice;
    data['wifi'] = this.wifi;
    data['like'] = this.like;
    data['chair'] = this.chair;
    data['addres'] = this.addres;
    data['bedSheet'] = this.bedSheet;
    data['electricityBill'] = this.electricityBill;
    data['light'] = this.light;
    data['fourPersionPrice'] = this.fourPersionPrice;
    data['fexibleTime'] = this.fexibleTime;
    data['singlePersonPrice'] = this.singlePersonPrice;
    data['cookingType'] = this.cookingType;
    return data;
  }
}
