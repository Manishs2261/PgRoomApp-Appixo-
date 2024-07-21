class UserPersonModel {
  String? city;
  String? email;
  String? name;
  String? userImage;

  UserPersonModel({this.city, this.email, this.name,this.userImage});

  UserPersonModel.fromJson(Map<String, dynamic> json) {
    city = json['city'] ?? '';
    email = json['email'] ?? '';
    name = json['Name'] ?? '';
    userImage = json['userImage'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['email'] = email;
    data['Name'] = name;
    data['userImage'] = userImage;
    return data;
  }
}
