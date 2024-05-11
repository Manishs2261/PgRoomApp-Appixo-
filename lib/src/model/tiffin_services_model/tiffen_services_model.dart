class TiffineServicesModel {
  String? foodPrice;
  double? averageRating;
  String? address;
  int? numberOfRating;
  String? servicesName;
  String? menuImage;
  String? foodImage;
  String? contactNumber;
  String? latitude;
  String? longitude;
  String? coverImageId;
  String? menuImageId;



  TiffineServicesModel(
      {this.foodPrice,
        this.averageRating,
        this.address,
        this.numberOfRating,
        this.servicesName,
        this.menuImage,
        this.foodImage,
      this.contactNumber,
        this.longitude,
        this.latitude,
        this.coverImageId,
        this.menuImageId
      });

  TiffineServicesModel.fromJson(Map<String, dynamic> json) {
    foodPrice = json['foodPrice'];
    averageRating = json['averageRating'];
    address = json['address'];
    numberOfRating = json['NumberOfRating'];
    servicesName = json['servicesName'];
    menuImage = json['menuImage'];
    foodImage = json['foodImage'];
    contactNumber = json['contactNumber'];
    longitude = json['longitude'] ;
    latitude = json['latitude'] ;
    coverImageId = json['coverImageId'] ;
    menuImageId = json['menuImageId'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foodPrice'] = this.foodPrice;
    data['averageRating'] = this.averageRating;
    data['address'] = this.address;
    data['NumberOfRating'] = this.numberOfRating;
    data['servicesName'] = this.servicesName;
    data['menuImage'] = this.menuImage;
    data['foodImage'] = this.foodImage;
    data['contactNumber'] = this.contactNumber;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['coverImageId'] = this.coverImageId;
    data['menuImageId'] = this.menuImageId;
    return data;
  }
}
