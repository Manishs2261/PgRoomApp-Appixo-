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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['email'] = this.email;
    data['Name'] = this.name;
    data['userImage'] = this.userImage;
    return data;
  }
}
