class UserRentModel {
  bool? parking;
  String? bhkType;
  bool? bed;
  String? city;
  String? doublePersionPrice;
  bool? washingMachin;
  bool? girls;
  bool? faimlyMember;
  bool? waterBill;
  bool? boy;
  bool? locker;
  String? landMark;
  String? triplePersionPrice;
  String? houseName;
  bool? fan;
  String? review;
  String? coverImage;
  String? contactNumber;
  bool? cooking;
  String? rentPrice;
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
  String? fexibleTime;
  String? fourPersionPrice;
  bool? light;
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
        this.waterBill,
        this.boy,
        this.locker,
        this.landMark,
        this.triplePersionPrice,
        this.houseName,
        this.fan,
        this.review,
        this.coverImage,
        this.contactNumber,
        this.cooking,
        this.rentPrice,
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
        this.fexibleTime,
        this.fourPersionPrice,
        this.light,
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
    waterBill = json['waterBill'];
    boy = json['boy'];
    locker = json['locker'];
    landMark = json['landMark'];
    triplePersionPrice = json['triplePersionPrice'];
    houseName = json['houseName'];
    fan = json['fan'];
    review = json['review'];
    coverImage = json['coverImage'];
    contactNumber = json['contactNumber'];
    cooking = json['cooking'];
    rentPrice = json['rentPrice'];
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
    fexibleTime = json['fexibleTime'];
    fourPersionPrice = json['fourPersionPrice'];
    light = json['light'];
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
    data['waterBill'] = this.waterBill;
    data['boy'] = this.boy;
    data['locker'] = this.locker;
    data['landMark'] = this.landMark;
    data['triplePersionPrice'] = this.triplePersionPrice;
    data['houseName'] = this.houseName;
    data['fan'] = this.fan;
    data['review'] = this.review;
    data['coverImage'] = this.coverImage;
    data['contactNumber'] = this.contactNumber;
    data['cooking'] = this.cooking;
    data['rentPrice'] = this.rentPrice;
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
    data['fexibleTime'] = this.fexibleTime;
    data['fourPersionPrice'] = this.fourPersionPrice;
    data['light'] = this.light;
    data['singlePersonPrice'] = this.singlePersonPrice;
    data['cookingType'] = this.cookingType;
    return data;
  }
}
