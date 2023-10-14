class RentdetalsModel {
  String? houseName;
  String? address;
  String? cityName;
  String? contactNumber;
  String? landMark;

  RentdetalsModel(
      {this.houseName,
        this.address,
        this.cityName,
        this.contactNumber,
        this.landMark});

  RentdetalsModel.fromJson(Map<String, dynamic> json) {
    houseName = json['houseName'];
    address = json['address'];
    cityName = json['cityName'];
    contactNumber = json['contactNumber'];
    landMark = json['landMark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['houseName'] = this.houseName;
    data['address'] = this.address;
    data['cityName'] = this.cityName;
    data['contactNumber'] = this.contactNumber;
    data['landMark'] = this.landMark;
    return data;
  }
}
