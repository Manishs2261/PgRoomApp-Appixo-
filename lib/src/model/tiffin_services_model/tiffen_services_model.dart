class TiffineServicesModel {
  String? foodPrice;
  double? averageRating;
  String? address;
  int? numberOfRating;
  String? servicesName;
  String? menuImage;
  String? foodImage;
  String? contactNumber;

  TiffineServicesModel(
      {this.foodPrice,
        this.averageRating,
        this.address,
        this.numberOfRating,
        this.servicesName,
        this.menuImage,
        this.foodImage,
      this.contactNumber});

  TiffineServicesModel.fromJson(Map<String, dynamic> json) {
    foodPrice = json['foodPrice'];
    averageRating = json['averageRating'];
    address = json['address'];
    numberOfRating = json['NumberOfRating'];
    servicesName = json['servicesName'];
    menuImage = json['menuImage'];
    foodImage = json['foodImage'];
    contactNumber = json['contactNumber'];
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
    return data;
  }
}
