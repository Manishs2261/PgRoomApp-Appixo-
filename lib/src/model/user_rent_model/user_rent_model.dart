class UserRentModel {
  String? houseName;
  bool? like;
  String? city;
  String? review;
  String? coverImage;
  String? addres;
  String? rentPrice;
  String? roomType;

  UserRentModel(
      {this.houseName,
        this.like,
        this.city,
        this.review,
        this.coverImage,
        this.addres,
        this.rentPrice,
        this.roomType});

  UserRentModel.fromJson(Map<String, dynamic> json) {
    houseName = json['houseName'];
    like = json['like'];
    city = json['city'];
    review = json['review'];
    coverImage = json['coverImage'];
    addres = json['addres'];
    rentPrice = json['rentPrice'];
    roomType = json['roomType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['houseName'] = this.houseName;
    data['like'] = this.like;
    data['city'] = this.city;
    data['review'] = this.review;
    data['coverImage'] = this.coverImage;
    data['addres'] = this.addres;
    data['rentPrice'] = this.rentPrice;
    data['roomType'] = this.roomType;
    return data;
  }
}

