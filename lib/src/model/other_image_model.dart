class OtherImageModel {
  String? otherRentImage;

  OtherImageModel({this.otherRentImage});

  OtherImageModel.fromJson(Map<String, dynamic> json) {
    otherRentImage = json['otherRentImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otherRentImage'] = this.otherRentImage;
    return data;
  }
}
