class OtherImageModel {
  String? OtherImage;

  OtherImageModel({this.OtherImage});

  OtherImageModel.fromJson(Map<String, dynamic> json) {
    OtherImage = json['OtherImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OtherImage'] = this.OtherImage;
    return data;
  }
}
