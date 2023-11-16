class OtherImageModel {
  List<String>? dImage;

  OtherImageModel({this.dImage});

  OtherImageModel.fromJson(Map<String, dynamic> json) {
    dImage = json['dImage'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dImage'] = this.dImage;
    return data;
  }
}
