class OtherImageModel {
  String? otherImage;

  OtherImageModel({this.otherImage});

  OtherImageModel.fromJson(Map<String, dynamic> json) {
    otherImage = json['OtherImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OtherImage'] = otherImage;
    return data;
  }
}
