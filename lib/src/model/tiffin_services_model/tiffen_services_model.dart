class TiffineServicesModel {
  String? foodPrice;
  String? averageRating;
  String? address;
  String? numberOfRating;
  String? servicesName;
  String? menuImage;
  String? foodImage;

  TiffineServicesModel(
      {this.foodPrice,
        this.averageRating,
        this.address,
        this.numberOfRating,
        this.servicesName,
        this.menuImage,
        this.foodImage});

  TiffineServicesModel.fromJson(Map<String, dynamic> json) {
    foodPrice = json['foodPrice'];
    averageRating = json['averageRaing '];
    address = json['address'];
    numberOfRating = json['NumberOfRating'];
    servicesName = json['servicesName'];
    menuImage = json['menuImage'];
    foodImage = json['foodImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foodPrice'] = this.foodPrice;
    data['averageRaing '] = this.averageRating;
    data['address'] = this.address;
    data['NumberOfRating'] = this.numberOfRating;
    data['servicesName'] = this.servicesName;
    data['menuImage'] = this.menuImage;
    data['foodImage'] = this.foodImage;
    return data;
  }
}
