class UserModel {
  String? atCreate;
  String? country;
  String? image;
  String? address;
  String? gender;
  String? city;
  bool? isDelete;
  String? postalCode;
  List<String>? foodId;
  String? dateOfBirth;
  List<String>? buyAndSellId;
  List<String>? roomId;
  String? uId;
  String? phone;
  String? atUpdate;
  bool? disable;
  String? name;
  List<String>? report;
  String? state;
  List<String>? serviceId;
  String? email;

  UserModel(
      {this.atCreate,
        this.country,
        this.image,
        this.address,
        this.gender,
        this.city,
        this.isDelete,
        this.postalCode,
        this.foodId,
        this.dateOfBirth,
        this.buyAndSellId,
        this.roomId,
        this.uId,
        this.phone,
        this.atUpdate,
        this.disable,
        this.name,
        this.report,
        this.state,
        this.serviceId,
        this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    atCreate = json['atCreate'];
    country = json['country'];
    image = json['image'];
    address = json['address'];
    gender = json['gender'];
    city = json['city'];
    isDelete = json['isDelete'];
    postalCode = json['postalCode'];
    foodId = json['foodId'].cast<String>();
    dateOfBirth = json['dateOfBirth'];
    buyAndSellId = json['buyAndSellId'].cast<String>();
    roomId = json['roomId'].cast<String>();
    uId = json['u_id'];
    phone = json['phone'];
    atUpdate = json['atUpdate'];
    disable = json['disable'];
    name = json['name'];
    report = json['report'].cast<String>();
    state = json['state'];
    serviceId = json['serviceId'].cast<String>();
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['atCreate'] = this.atCreate;
    data['country'] = this.country;
    data['image'] = this.image;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['city'] = this.city;
    data['isDelete'] = this.isDelete;
    data['postalCode'] = this.postalCode;
    data['foodId'] = this.foodId;
    data['dateOfBirth'] = this.dateOfBirth;
    data['buyAndSellId'] = this.buyAndSellId;
    data['roomId'] = this.roomId;
    data['u_id'] = this.uId;
    data['phone'] = this.phone;
    data['atUpdate'] = this.atUpdate;
    data['disable'] = this.disable;
    data['name'] = this.name;
    data['report'] = this.report;
    data['state'] = this.state;
    data['serviceId'] = this.serviceId;
    data['email'] = this.email;
    return data;
  }
}
